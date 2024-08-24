# SAS

## Overview
This SAS script is designed to analyze a dataset (`DBEREL01.20240814133622.csv`) containing various statistics. The script performs a series of data processing and visualization tasks, including importing the dataset, exploring its structure, calculating descriptive statistics, and generating visualizations like histograms and bar charts.

## Files
- **Final Project.sas**: The primary SAS script containing all the data processing and analysis steps.
- **DBEREL01.20240814133622.csv**: The dataset file imported by the SAS script. This file must be placed in the correct directory for the script to run successfully.

## Requirements
- **SAS Software**: Ensure that SAS is installed on your system.
- **Dataset**: The script expects a CSV file named `DBEREL01.20240814133622.csv` to be located in the specified directory within the SAS environment.

## Script Structure

### 1. Importing the Dataset
The script begins by importing the dataset from a CSV file into a SAS dataset (`work.mydata`).

```sas
PROC IMPORT DATAFILE='/home/u63920390/sasuser.v94/DBEREL01.20240814133622.csv'
    OUT=work.mydata
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;
```
- **PROC IMPORT**: Reads the CSV file.
- **OUT=work.mydata**: Saves the data to the `work.mydata` dataset.
- **GETNAMES=YES**: Uses the first row of the CSV file as variable names.

### 2. Exploring the Dataset Structure
The structure of the dataset is explored to understand its contents.

```sas
PROC CONTENTS DATA=work.mydata;
RUN;

PROC PRINT DATA=work.mydata (OBS=10);
RUN;
```
- **PROC CONTENTS**: Displays metadata about the dataset.
- **PROC PRINT**: Prints the first 10 observations to preview the data.

### 3. Descriptive Statistics for Numerical Variables
This step calculates descriptive statistics (mean, median, standard deviation, etc.) for numerical variables.

```sas
DATA work.mydata;
    SET work.mydata;
    VALUE_num = INPUT(VALUE, 8.);
RUN;

PROC MEANS DATA=work.mydata N MEAN MEDIAN STDDEV MIN MAX;
    VAR VALUE_num;
RUN;
```
- **VALUE_num**: Converts the `VALUE` variable from text to numeric if necessary.
- **PROC MEANS**: Computes statistics like mean, median, and standard deviation for `VALUE_num`.

### 4. Frequency Tables for Categorical Variables
Frequency tables are generated for categorical variables to understand the distribution of categories.

```sas
PROC FREQ DATA=work.mydata;
    TABLES STATISTIC "Statistic Label"N "Type of Dwelling"N "Energy Rating"N;
RUN;
```
- **PROC FREQ**: Creates frequency tables for categorical variables.

### 5. Histogram for a Numerical Variable
A histogram is created to visualize the distribution of the numeric variable `VALUE_num`.

```sas
PROC SGPLOT DATA=work.mydata;
    HISTOGRAM VALUE_num;
    TITLE "Distribution of VALUE_num";
RUN;
```
- **PROC SGPLOT**: Generates a histogram for `VALUE_num`.

### 6. Bar Chart for a Categorical Variable
A bar chart is created to visualize the frequency of categories in the `Type of Dwelling` variable.

```sas
PROC SGPLOT DATA=work.mydata;
    VBAR "Type of Dwelling"N;
    TITLE "Frequency of Type of Dwelling";
RUN;
```
- **PROC SGPLOT**: Generates a bar chart for the `Type of Dwelling` variable.

## Comments and Insights
- The script contains comments and text outputs to provide insights into the analysis, such as descriptions of histogram distributions and interpretations of bar charts.
- These sections use `PROC ODSTEXT` for textual explanations of visualized data.

## Usage
1. Place the `DBEREL01.20240814133622.csv` file in the correct directory.
2. Run the `Final Project.sas` script in your SAS environment.
3. Review the output for insights into the data, including tables, descriptive statistics, and visualizations.

## Conclusion
This SAS script is a comprehensive tool for importing, analyzing, and visualizing data from a CSV file. It provides a structured approach to exploring both numerical and categorical variables, offering valuable insights into the dataset.
