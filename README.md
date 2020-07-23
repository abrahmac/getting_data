# Getting and Cleaning Data

## Course Project - Generate a Tidy Dataset

### Problem Statement

To create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Solution Content

The solution provided here consists of the following.

1. A code script called ```run_analysis.R```.
2. A tidy dataset file called ```tidy_dataset.txt``` as the output of this solution.
3. This file (```README.md```).
4. A codebook called ```CodeBook.md``` that provides details summary of data and variables used in the code.

### How to execution the solution

1. cd <some-base-dir-of-your-choice-on-your-machine>
2. git checkout <this-git-repository-branch>
3. cd <repo-directory>
4. Invoke R or R Studio.
5. ```source("./run_analysis.R")```
6. Exit R.
7. Review the file tidy_dataset.txt residing in the same base directory.

