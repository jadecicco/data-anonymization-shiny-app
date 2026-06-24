library(shiny)
library(tidyverse)
library(stringr)

ui <- fluidPage(
  
  titlePanel("Data Anonymization Tool"),
  
  sidebarLayout(
    sidebarPanel(
      
      # Upload comma-separated data
      fileInput("file", "Upload your CSV File", accept = ".csv"),
      
      # Column selection UI
      uiOutput("column_select"),
      
      # Method selection UI \
      uiOutput("method_select"),
      
      # Download anonymous data
      downloadButton("download", "Download Anonymous Dataset")
    ),
    
    mainPanel(
      h3("Preview of Anonymous Data"),
      tableOutput("preview")
    )
  )
)

server <- function(input, output, session) {
  
  # Read uploaded data
  raw_data <- reactive({
    req(input$file)
    read_delim(input$file$datapath, delim = ",", show_col_types = FALSE)
  })
  
  # Column selection checkboxes
  output$column_select <- renderUI({
    req(raw_data())
    checkboxGroupInput(
      "columns",
      "Select Columns to Anonymize:",
      choices = names(raw_data())
    )
  })
  
  # Method + regex selection per column
  output$method_select <- renderUI({
    req(input$columns)
    
    tagList(
      lapply(input$columns, function(col) {
        safe_col <- gsub("\\W", "_", col)  #fixes issue with conditional panel appearing when it's not suppossed to
        
        tagList(
          selectInput(
            inputId = paste0("method_", safe_col),
            label = paste("Method for", col),
            choices = c(
              "String Mask" = "mask_string",
              "Regex Mask" = "regex_mask",
              "Categorical Recode" = "recode_cat",
              "Numeric Rounding" = "round_num",
              "Add Noise (jitter)" = "jitter"
            )
          ),
          
          # Regex input appears ONLY if regex method is selected for THIS column
          conditionalPanel(
            condition = sprintf("input['method_%s'] == 'regex_mask'", safe_col),
            textInput(
              inputId = paste0("pattern_", safe_col),
              label = paste("Regex pattern for", col),
              value = "[A-Za-z]"
            )
          )
        )
      })
    )
  })
  
  
  # Apply anonymization
  anonymous_data <- reactive({
    req(raw_data(), input$columns)
    
    data <- raw_data()
    
    for (col in input$columns) {
      
      safe_col <- gsub("\\W", "_", col)  # same transformation
      method <- input[[paste0("method_", safe_col)]]
      
      if (method == "regex_mask") {
        pattern <- input[[paste0("pattern_", safe_col)]]
        data[[col]] <- str_replace_all(as.character(data[[col]]), pattern, 
                                       function(x) paste(rep("X", nchar(x)), collapse=""))
      }
      
      else if (method == "mask_string") {
        data[[col]] <- str_replace_all(as.character(data[[col]]), ".", "X")
      }
      
      #Will recode categorical to letters alphabetically unless there are more than 26 unique values
      else if (method == "recode_cat") {
        if (!is.numeric(data[[col]])) {
          uniq <- sort(unique(as.character(data[[col]])))
          labels <- if (length(uniq) <= 26) {
            LETTERS[1:length(uniq)]
          } else {
            paste0("CAT", seq_along(uniq))
          }
          data[[col]] <- factor(data[[col]], levels = uniq, labels = labels)
        }
      }
      
      else if (method == "round_num") {
        suppressWarnings({
          data[[col]] <- round(as.numeric(data[[col]]), 0)
        })
      }
      
      else if (method == "jitter") {
        suppressWarnings({
          data[[col]] <- jitter(as.numeric(data[[col]]), amount = 0.1)
        })
      }
    }
    
    data
  })
  
  # Preview first 20 rows of new data
  output$preview <- renderTable({
    req(anonymous_data())
    head(anonymous_data(), 20)
  })
  
  # Download new anonymous dataset
  output$download <- downloadHandler(
    filename = function() {
      paste0("anonymous_data-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(anonymous_data(), file)
    }
  )
}

shinyApp(ui, server)
