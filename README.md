# Data Anonymization Shiny App

An interactive R Shiny application for applying basic anonymization techniques to CSV datasets. Users can upload data, select columns, choose anonymization methods, preview the results, and download the transformed file.

## Features

* Upload CSV datasets
* Select columns for anonymization
* Apply masking, recoding, rounding, and noise-based transformations
* Preview anonymized data before downloading
* Export the anonymized dataset as a CSV file

## Tools Used

* R
* Shiny
* tidyverse
* stringr

## Skills Demonstrated

* Interactive application development
* Data privacy and anonymization concepts
* Data cleaning and transformation
* Reactive programming in Shiny
* User input handling and CSV import/export

## How to Run

1. Download or clone this repository
2. Open `app.R` in RStudio
3. Install the required packages if needed:

```r
install.packages(c("shiny", "tidyverse", "stringr"))
```

4. Run the app:

```r
shiny::runApp()
```

## Future Improvements

* Add a sample dataset for demonstration
* Improve input validation for numeric and categorical variables
* Add screenshots or a short app demo
* Refine the interface for a more polished user experience
