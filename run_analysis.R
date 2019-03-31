# Author: Atman Brahmachari
# Purpose: Peer-graded Assignment: Getting and Cleaning Data Course Project
# Script: run_analysis.R

#### Original assignment statement:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# You should create one R script called run_analysis.R that does the following.
#
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
####

# Import libraries
library(utils)
library(plyr)
library(dplyr)

# Function Definitions
read_data <- function(data_dir, prefix, data_type=NA) {
  if (is.na(data_type)) {
    file_name = paste(prefix, "txt", sep=".")
  }
  else {
    file_name <- paste(paste(prefix, data_type, sep="_"), "txt", sep=".")
  }
  full_path <- paste(data_dir, file_name, sep="/")
  read.table(full_path, header=FALSE)
}

# Initialize variables
base_dir <- getwd()
orig_project_dir <- paste(base_dir, "UCI HAR Dataset", sep="/")
project_dir <- paste(base_dir, "uci_har_dataset", sep="/")
train_dir <- paste(project_dir, "train", sep="/")
test_dir <- paste(project_dir, "test", sep="/")
dest_file <- paste(base_dir, "uci_har_dataset.zip", sep="/")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
tidy_dataset <- paste(base_dir, "tidy_dataset.txt", sep="/")

# Clear data if it pre-exists.
unlink(project_dir, recursive=TRUE)

# Download and unzip files, 
download.file(method="curl", destfile=dest_file, url=url)
unzip(dest_file, exdir=base_dir)
file.rename(orig_project_dir, project_dir)

# A. Merge training and test data sets.

# load test data into R and merge columns.
subject_test <- read_data(test_dir, "subject", "test")
x_test <- read_data(test_dir, "X", "test")
y_test <- read_data(test_dir, "y", "test")
merged_test <- cbind(subject_test, y_test, x_test)

# load training data into R and merge columns.
subject_train <- read_data(train_dir, "subject", "train")
x_train <- read_data(train_dir, "X", "train")
y_train <- read_data(train_dir, "y", "train")
merged_train <- cbind(subject_train, y_train, x_train)

# Total merge here.
merged_data <- rbind(merged_train, merged_test)

# Column naming for merged_data.
features <- read_data(project_dir, "features")
f <- features[, 2]
feature_columns <- levels(f)[f]
colnames(merged_data) <- c("subject_id", "activity_id", feature_columns)

# B. Extract mean and standard deviation measurements.

col_match <- grepl("subject_id|activity_id|mean|std", colnames(merged_data))
merged_data <- merged_data[, col_match]

# C. Use descriptive activity names in the data set.

activity_labels <- read_data(project_dir, "activity", "labels")
colnames(activity_labels) <- c("activity_id", "activity_name")
merged_data <- join(merged_data, activity_labels, by = "activity_id")
move_idx <- grep("activity_name", names(merged_data))
merged_data <- merged_data[, c(move_idx, (1:ncol(merged_data))[-move_idx])]
merged_data <- merged_data[, -3]

# D. Use appropriate descriptive labels for variables.

names(merged_data) <- tolower(names(merged_data))
names(merged_data) <- gsub("gravity", "gravity_", names(merged_data))
names(merged_data) <- gsub("acc-", "acc", names(merged_data))
names(merged_data) <- gsub("acc", "acceleration_", names(merged_data))
names(merged_data) <- gsub("bodybody", "body", names(merged_data))
names(merged_data) <- gsub("body", "body_", names(merged_data))
names(merged_data) <- gsub("-", "_", names(merged_data))
names(merged_data) <- gsub("^t", "time_", names(merged_data))
names(merged_data) <- gsub("gyro_", "gyro", names(merged_data))
names(merged_data) <- gsub("gyro", "gyro_", names(merged_data))
names(merged_data) <- gsub("jerk_", "jerk", names(merged_data))
names(merged_data) <- gsub("jerk", "jerk_", names(merged_data))
names(merged_data) <- gsub("man", "mag_", names(merged_data))
names(merged_data) <- gsub("meanfreq", "mean_frequency", names(merged_data))
names(merged_data) <- gsub("\\(\\)", "", names(merged_data))
names(merged_data) <- gsub("^f", "frequency_", names(merged_data))

# E. Create a tidy data set with the average of each activity and subject.

merged_data <- ddply(merged_data, c("activity_name","subject_id"), numcolwise(mean))
write.table(merged_data, tidy_dataset, row.names=FALSE)
