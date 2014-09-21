---
title: "README"
author: "Mittal Monani"
date: "Saturday, September 20, 2014"
output: html_document
---

The script is divided into the following sections: 

1. Read the data. 

This is the initial section where data is read into varaibles from files using read.table methods. 
Variables x, y and subjects for training and test sets are identified using _traina and _test 
extensions. Activities and features are common to both sets. 

2.Clean the data. 

Fist step is to provide the right column names to the x data frames. 

Second step is to extract the columns we are interested in. I have used grep function to look for 
names containing "mean" or "std" strings. The names of the columns are in the features frame. 
Grep returns a vector of row numbers which I have then used to subset the x_train and x_test data sets. 
The x data sets only contain mean and standard deviation columns, which essentialy solves part #2 of the 
course project. 

Third step is to use descriptive activity names. The y data sets have activities identified by numbers.
The actual activity names are in the act variable. Using mapvalues functions, y data sets are modified to 
replace activity numbers with descriptive names. This solves part # 3 of the course assignment. 

3.Combine the data

Using cbind and rbind functions on the appropriate elements, we get the combined data set. The data is in variable comb_data.This solves part #1 of the course assignment. The column names are also renamed to identify which 
columns have subject id's and which ones have activity names. This solves part # 4 of the course assignment.

4.Final processing the data

Using melt and dcast functions then produces the final data set we are looking for. This data set has 180 rows and 
81 columns. The 81 columns comprise of Subject, Activity and 79 average columns. 
