## Coursera - Getting and Cleaning Data Project

## run_analysis.R description:
## This script performs the following steps on the dataset downloaded from
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## - merges the training and test datasets to create one dataset
## - extracts only the mean and standard deviation for each measurement
## - uses descriptive activity names to name the activities in the dataset
## - appropriately labels the dataset with descriptive variable names
## - creates a tidy dataset with the average of each variable for each activity & subject

library(dplyr)

## Download and unzip the file
filename <- "getdata-projectfiles-UCI HAR Dataset.zip"

if (!file.exists(filename)) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method = "curl")
}

if(!file.exists("UCI HAR Dataset")){
    unzip(filename)
}

setwd("UCI HAR Dataset")

## load the activity types and features and give meaningful column names
activity_types <- read.table("activity_labels.txt", col.names =  c("activity_id", "activity_name"))
activity_types[,2] <- as.character(activity_types[,2]) 
features <- read.table("features.txt", col.names = c("feature_id", "feature_name"))

## load the X data
x_train <- read.table("train/X_train.txt")
x_test <- read.table("test/X_test.txt")
x_data <- rbind(x_train, x_test)

## load the Y data
y_train <- read.table("train/y_train.txt", col.names = "activity_id")
y_test <- read.table("test/y_test.txt", col.names = "activity_id")
y_data <- rbind(y_train, y_test)

## load the subject data
subject_train <- read.table("train/subject_train.txt", col.names = "subject_id")
subject_test <- read.table("test/subject_test.txt", col.names = "subject_id")
subject_data <- rbind(subject_train, subject_test)

## filter the data for only those columns with mean and standard deviation
features_wanted <- grep("(mean|std)\\(\\)", features[,2])

# only return the mean and standard deviation data
x_data <- x_data[, features_wanted]

## give the x data the feature names
names(x_data) <- features[features_wanted, 2]

## use descriptive activity names
## replace the activity_id with activity_name
y_data["activity_name"] <- activity_types[y_data[,1],2]    

## bind the columns needed into a single dataset
all_data <- cbind(subject_data, y_data[,2], x_data)
colnames(all_data)[2] <- "activity_name"

## create tidy dataset with the average
average_data <- all_data %>%
    group_by(subject_id, activity_name) %>%
    summarise_each(funs(mean))

## clean up column names
colnames(average_data) <- gsub("\\()", "", colnames(average_data))
colnames(average_data) <- gsub("^(t)", "time", colnames(average_data))
colnames(average_data) <- gsub("^(f)", "freq", colnames(average_data))
colnames(average_data) <- gsub("-mean", "Mean", colnames(average_data))
colnames(average_data) <- gsub("-std", "StdDev", colnames(average_data))
colnames(average_data) <- gsub("-", "", colnames(average_data))

## write the tidy data to a file
write.table(average_data, "tidy_data.txt", sep = "\t", row.names = FALSE)

