# Diabeta Web Application

**Diabeta** is an interactive web application designed to visualize and analyze crucial diabetes-related parameters over time. The app allows users to upload CSV files containing **Nutrient Intake Data**, **Stress Levels**, and **Blood Glucose Levels**. It provides an intuitive interface to explore the data through customizable plots and visualizations. Additionally, users can access an introductory section that includes an explanatory video on how to use the app.

## Access the Web App
You can access the web app through this link: [Diabeta Web App](https://janovapp.shinyapps.io/diabeta_webapp/)

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [File Upload Requirements](#file-upload-requirements)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Features

### Interactive Analysis of Diabetes-Related Data
Our platform offers a comprehensive workflow for analyzing diabetes-related data, focusing on key factors such as nutrient intake, stress levels, and glucose blood levels. The app is designed to provide robust statistical analysis and data visualization tools, facilitating the exploration and interpretation of complex datasets.

1. **Nutrient Intake Analysis**: Utilize an interactive stacked bar plot to examine and compare the intake of various nutrients across different conditions or time periods.

2. **Stress Levels Variation**: Analyze the variation in stress levels and its potential impact on diabetes management.

3. **Glucose Blood Levels Assessment**: Evaluate the normality and distribution of glucose levels through rigorous statistical methods.

4. **Statistical Testing**: Conduct ANOVA and Tukey's post-hoc tests to determine significant differences between groups.

## Installation
If you prefer running the web app locally, you can follow the following steps :
### Prerequisites

- **R** (version 4.0 or later)
- **RStudio** or another suitable IDE
- Required R packages:
```R
required_packages <- c("shiny", "ggplot2", "reshape2", "gridExtra", "tidyverse", 
                       "shinyWidgets", "multcomp", "agricolae", "dplyr", "bslib")
```
### Steps

1. **Clone the repository**:
```
   git clone https://github.com/MohammadHichamPolo/diabeta.git
   cd diabeta
```
2. **Install the required packages**:
```
install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
}

lapply(required_packages, install_if_missing)
```
3. **Run the application**:
   - Save the app.R file and Run it or combine all files in a single file and run the known commande:
```
shiny::runApp()
```
## Usage

#### 🚀 Getting Started
**Download the Google Sheets Template:** We've prepared a structured template to ensure your data is correctly formatted. [Download Google Sheets Template](https://docs.google.com/spreadsheets/d/1Ej_6PBFx4pqYEv_2VbgJ7stdpmkrNwEaSI1FOin0VaU/edit?gid=0#gid=0)
**Explore the Features:** Navigate through the tabs to explore various analytical tools and visualizations. 
Our intuitive interface makes it easy to uncover trends, compare nutrient intake, and gain deeper insights into your dietary patterns.

## File Upload Requirements

For seamless analysis, please ensure your datasets are correctly formatted as CSV files. The app supports the following data inputs:

- **Nutrient Intake:** Upload your CSV file to analyze nutrient composition and patterns.
- **Stress Levels:** Import your CSV file to investigate variations and correlations in stress.
- **Glucose Measurements:** Provide your glucose measurements in CSV format for detailed statistical assessment.
  
### Customization
- User-Friendly: Designed with simplicity in mind, no advanced technical skills required.
- Customizable Visuals: Tailor the charts and graphs to your preferences, making data interpretation a breeze.
- Data Security: Your data stays with you. We prioritize your privacy and do not store any of your uploaded files.

## Troubleshooting

#### If you encounter any issues, please refer to the following:

- Check File Formatting: Ensure your CSV files are correctly formatted and match the required structure.
- Clear Cache: Sometimes, clearing your browser's cache can resolve unexpected behavior.

## Contributing

### We welcome contributions! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the GNU General Public License v3.0 - see the LICENSE file for details.

Created by Mohammad HICHAM POLO from JANOVAPP organisation.
