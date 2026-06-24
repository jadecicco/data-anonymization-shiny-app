# Data Anonymization Shiny App

An interactive R Shiny application that allows users to upload a CSV file, select columns, apply anonymization methods, preview the transformed data, and download an anonymized version of the dataset.

## Project Overview

This project was built to demonstrate privacy-focused data handling through an interactive application. Users can upload tabular data and apply different anonymization techniques depending on the type of variable they want to protect.

The app is designed around a simple workflow:

1. Upload a CSV file
2. Select columns to anonymize
3. Choose an anonymization method for each selected column
4. Preview the anonymized dataset
5. Download the transformed CSV file

## Features

* CSV file upload
* Dynamic column selection
* Multiple anonymization methods
* Preview of anonymized data
* Downloadable anonymized CSV output
* Interactive R Shiny interface

## Anonymization Methods

The app currently supports:

* **String Masking:** Replaces characters with `X`
* **Regex Masking:** Applies user-defined pattern-based masking
* **Categorical Recoding:** Recodes category values into generic labels
* **Numeric Rounding:** Rounds numeric values
* **Noise Addition:** Adds small random variation to numeric values

## Tools Used

* R
* Shiny
* tidyverse
* stringr

## Skills Demonstrated

* Interactive dashboard/application development
* Data privacy concepts
* Data cleaning and transformation
* User input handling
* Reactive programming in Shiny
* CSV import/export workflow

## How to Run

1. Clone or download this repository
2. Open `app.R` in RStudio
3. Install required packages if needed:

```r
install.packages(c("shiny", "tidyverse", "stringr"))
```

4. Run the app:

```r
shiny::runApp()
```

## Future Improvements

* Add sample dataset for demonstration
* Add clearer validation for numeric vs. categorical methods
* Add before-and-after data comparison
* Add downloadable documentation for anonymization methods
* Improve UI layout and styling

