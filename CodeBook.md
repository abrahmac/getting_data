# Getting and Cleaning Data

## Course Project - Generate a Tidy Dataset

### Experiment Files

1. Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Experiment Details

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

For each record it is provided:

1. Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
2. Triaxial Angular velocity from the gyroscope.
3. A 561-feature vector with time and frequency domain variables.
4. Its activity label.
5. An identifier of the subject who carried out the experiment.

#### Input dataset

1. README.txt
2. features_info.txt: Shows information about the variables used on the feature vector.
3. features.txt: List of all features.
4. activity_labels.txt: Links the class labels with their activity name.
5. train/X_train.txt: Training set.
6. train/y_train.txt: Training labels.
7. test/X_test.txt: Test set.
8. test/y_test.txt: Test labels.

#### Training and Test Data along with Their Descriptions

1. train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
2. train/Inertial Signals/total_acc_x_train.txt: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
3. train/Inertial Signals/body_acc_x_train.txt: The body acceleration signal obtained by subtracting the gravity from the total acceleration.
4. train/Inertial Signals/body_gyro_x_train.txt: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

#### Other Notes

1. Features are normalized and bounded within [-1,1].
2. Each feature vector is a row on the text file.

### Main script: run_analysis.R

#### Program Flow

The script carries out the following steps in the given order.

1. At the top, it adds comments about the author and the assignment problem statement.
2. Next, it imports some libraries to be used through the program execution.
3. Then it declares functions used through the program execution.
4. Then it initialized variables that are used through the program execution
5. Then it first erases everything under the base project directory to start clean.
6. Then it downloads the required datasets from the given HTTP url, unzips them and saves them locally.
7. At this point, it is ready to address the problem statement and does the following.
   - It loads test and training data into R data frames.
   - From these data frames, it constructs merged data frames for each of test and training separately.
   - Then it merges the training and test merged data sets themselves; thus forming a fully merged data set.
   - It gives proper names for columns of the merged data frame.
     - Here it also gives names based on the features listed in features.txt.
   - Next it limits the merged data frame to only the mean and standard deviation measurements.
   - Then it uses the activity_labels.txt to join with the merged data set to fetch activity name.
   - It discards activity_id and keeps activity_name instead in the merged data frame.
   - Next it massages column names further:
     - It uses proper full forms instead of abbreviations.
     - It removes (), replaces - with _.
     - It converts it all to lower case.
8. Finally it generates a tidy mean dataset by activity_name and subject_id and stores it in the file tidy_data.txt.

### Project Execution Details

README.md provides details on how to run the solution script to generate a tidy dataset from the given experiment data.

