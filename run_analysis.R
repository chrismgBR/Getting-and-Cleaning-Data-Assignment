############################################
### Assignment Getting and Cleaning Data ###
############################################



### Download and unzip data

library(data.table)

setwd("E:/Desktop/Data Science -  Foundations using R/3-Getting and Cleaning Data/Assignment")

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists('./data')){
  download.file(fileURL,'./Dataset.zip', mode = 'wb')
  unzip("Dataset.zip", exdir = './')
}


#### PART 1 ####
####  Merge the training and the test sets to create one data set

### Read and inspect data

# Train data
Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
str(Xtrain)
dim(Xtrain)

Ytrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
str(Ytrain)
dim(Ytrain)
table(Ytrain)

SubjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
str(SubjectTrain)
dim(SubjectTrain)


# Test data
Xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
str(Xtest)
dim(Xtest)

Ytest <- read.table("UCI HAR Dataset/test/Y_test.txt")
str(Ytest)
dim(Ytest)
table(Ytest)

SubjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
str(SubjectTest)
dim(SubjectTest)

# Features
features <- read.table("UCI HAR Dataset/features.txt")
head(features)
tail(features)
str(features)
dim(features)

# Activity
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
str(activity)

# Create dataframes for Train and Test

df.train <- data.frame(SubjectTrain, Ytrain, Xtrain)  # combining subject, activity and features for data train
names(df.train) <- c("subject", "activity", features[,2])
head(df.train)
dim(df.train)

df.test <- data.frame(SubjectTest, Ytest, Xtest)  # combining subject, activity and features for data test
names(df.test) <- c("subject", "activity", features[,2])
head(df.test)
dim(df.test)

# Merge data train and test

df <- rbind(df.train, df.test)
dim(df)

#### PART 2 ####
####  Extracts only the measurements on the mean and standard deviation for each measurement

names(df)
meanstdcol <- grep("mean|std", names(df))
names(df)[meanstdcol]  # check if the column names selected contain "mean" or "std"

df.sub <- df[, meanstdcol]  # subset for columns with "mean" or "std"
head(df.sub)
dim(df.sub)



#### PART 3 ####
####  Use descriptive activity names to name the activities in the data set
activity.names <- activity[, 2]  # the names for the activities are in the second column
df$activity <- activity.names[df$activity]
df[1:5, 1:10] # check if the activities names are correct



#### PART 4 ####
####  Appropriately labels the data set with descriptive variable names

newnames <- names(df.sub)
newnames <- gsub("[(][)]","", newnames)  # remove ()
newnames <- gsub("-", "_", newnames)     # substitute "-" for "_"
#newnames <- gsub("subject", "SubjectID", newnames)
newnames <- gsub("^f", "FrequencyDomain_", newnames) # according file "features.info" "f" stands for frequency domain signals
newnames <- gsub("^t", "TimeDomain_", newnames) # according file "features.info" "t" stands for time domain signals
newnames # check newmanes
names(df.sub) <- newnames


#### PART 5 ####
####  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

df.sub["SubjectID"] <- as.factor(df$subject)
df.sub["Activity"] <- df$activity

bylist <- list(SubjectID = df.sub$SubjectID, Activity = df.sub$Activity)

# example for aggregate function: aggregate(x, by, FUN, …, simplify = TRUE, drop = TRUE)

df.tidy <- aggregate(df.sub[,1:(ncol(df.sub) - 2)], bylist, mean) # the last 2 columns are SubjectID and Activity, so they are not considered in the mean calculation
dim(df.tidy) # check for dimensions
head(df.tidy[,1:7])

# Write tidy data frame
write.csv(x = df.tidy, file = "tidy_data.csv", row.names = FALSE)


