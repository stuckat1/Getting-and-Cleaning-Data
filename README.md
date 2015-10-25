# Getting and Cleaning Data
## Course Project

## Introduction
This repository holds the raw data, a R script and the processed tidy data necessary to complete the peer assessment. 

## Raw data
The raw data was generated from sensors inside a Samsung smartphone.  Human subjects performed various activities and their performance was logged.  
The raw data is stored over many files.  The information was partitioned randomly into a training set and a test set.  Each set consisted of multiple files that recorded a subject's id, activity and sensor data. 

In addition there is a meta data file that defines the 561 features in either time or fequency domain.

## Goals
The requirements of the script are the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Running the script
I created a script, run_analysis.R, to process the raw data and create a tidy data file. 

To run the script run the following line on the R command line:

```
source("run_analysis.R")
```

## How it works
First the metadata file that described all of the features are processed to eliminate measurements not relating to mean or standard deviation.  Super advanced filtering techniques are used to improve existing feature names to make it super clear to the reader.

Then, for the training set the subjects identifier, activity label and feature data that were in separate files are read into R and and combined column-wise.  The same is done for the test data.  The combined training and test data are row combined.

Using melt and dcast methods, the mean is computed by grouping by user and activity.

## Processed data
The processed data named 'tidy.txt' is tidy.  It embodies all the major tidy principals extoled by data scientists around the globe such as:
* Each variable you measure should be in one column
* Each different observation of that variable should be in a different row
* There should be one table for each "kind" of variable

See the **CodeBook.MD** file for more information.

Peace out.

