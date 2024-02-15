### Introduction

This document aims to describe the variables, data sets and any transformations performed in the analysis.


### Data

The data was downloaded from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data is about wearable computing and more information can be obtained in the following link:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data is divided into train and test data sets, and the data was cleaned and merged.

### Variables

The variable names (in alphabetical order) used in the analysis are:

**activity**: one of the possible 6 activities performed *(walking, walking upstairs, walking downstairs, sitting, standing, laying)*

**activity.names**: names for the activities 

**bylist**: variable (list) created with SubjectID and Activity

**df**: data-frame with train and test data 

**df.sub**: subset of dataframe "*df*" with mean and standard-deviation (std) for the features

**df.test**: data-frame with test data

**df.tidy**: tidy data-frame with features mean for each subjectID and activity

**df.train**: data-frame with train data

**features**: 561 features collected on the smartphones 

**fileURL**: path for data to be downloaded

**newnames**: variables names modified for better user understanding

**SubjectTrain, SubjectTest**: data-frame with subject train and test data

**Xtrain, Xtest**: data-frame with features train and test data

**Ytrain, Ytest**: data-frame with activities train and test data


### Part 1

In part 1 the train and test data sets (X, Y, and subject) were download and read/associated with each data-frame. The dimensions (*dim*) and structure (*str*) were inspected in order to achive a better understanding of the variables.

The train and test data-frames were merged into data-frame *df*.


### Part 2
In part 2 the measurements on the mean and standard deviation were extracted. The data-frame with the selected variables was named *df.sub*.

### Part 3

In part 3 the activities in the dataset were modified to use descriptive activity names.

### Part 4

In part 4 the data set variable names were modified for appropriately labels that better describe those variables. Some of the modifications considered removal of "()", substitution of "-" for "_" and description of the variables (ex: "f" for "Frequency domain").

### Part 5

In part 5 an independent tidy data-frame (**df.tidy**) was created with the average of each variable for each activity and each subject. This tidy data frame considered the modifications performed in the variables names according explanation in parts 3 and 4.

Finally, the tidy frame was exported into a tidy dat set in the format .csv (*tidy_data.csv*).

