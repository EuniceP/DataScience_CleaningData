# DataScience_CleaningData
Author: Eunice Park
Date:   8/23/15
Description: The R script analyzes the Human Activity Recognition Using Smartphones Dataset,  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# The R script, run_analysis.R performs the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a tidy data set as above
6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Input:
~/Datascience/JHDS_BigData/CleanData/Project
├── UCI\ HAR\ Dataset
    ├── activity_labels.txt
    ├── features.txt
    ├── test
    │   ├── subject_test.txt
    │   ├── X_test.txt
    │   └── y_test.txt
    └── train
        ├── subject_train.txt
        ├── X_train.txt
        └── y_train.txt
	  
	- features.txt: feature vector for each pattern:
		'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
		tBodyAcc-XYZ
		tGravityAcc-XYZ
		tBodyAccJerk-XYZ
		tBodyGyro-XYZ
		tBodyGyroJerk-XYZ
		tBodyAccMag
		tGravityAccMag
		tBodyAccJerkMag
		tBodyGyroMag
		tBodyGyroJerkMag
		fBodyAcc-XYZ
		fBodyAccJerk-XYZ
		fBodyGyro-XYZ
		fBodyAccMag
		fBodyAccJerkMag
		fBodyGyroMag
		fBodyGyroJerkMag

		The set of variables that were estimated from these signals are: 

		mean(): Mean value
		std(): Standard deviation

	- activity_labels.txt : Activities for which measurements were made 
							 Links the class labels with their activity name.
							(contains Activity ID and activity)
		1 WALKING
		2 WALKING_UPSTAIRS
		3 WALKING_DOWNSTAIRS
		4 SITTING
		5 STANDING
		6 LAYING
	- 'features.txt': List of all features.

	- Training Dataset: 
	   └── train
        ├── subject_train.txt: Training data variable names
        ├── X_train.txt:  Training data
        └── y_train.txt:  Training labels with Activity ID (which can be cross referenced to activity_labels.txt)

	- Test Dataset: 
	   └── train
        ├── subject_test.txt: Training data variable names
        ├── X_test.txt:  Test data
        └── y_test.txt:  Test labels with Activity ID (which can be cross referenced to activity_labels.txt)

# Output:  
		- TinyDS - Tidy Dataset 
		- TinyDSAvg - Tidy Dataset's average of each variable for each activity and each subject.


# Variables
	- HAR is a list containing data frames described below
		- HAR$features: contains feature vector as described for features.txt
		- HAR$activity_features: Contains activity ids and activity names
		- HAR$train - Training Dataset
		- HAR$test - Test Dataset
	- HAR_Combine - Merged Training & Test dataset

# Transformations
1.  read.table : All data files are loaded into R tables
2.  HAR$test data frame is created by column binding subject and measurement data files (subject_test.txt and x_test.txt)
3.  Similarly HAR$train data frame is created by column binding subject and measurement data files (subject_train.txt and x_train.txt)
4.  HAR_Combine data is created using rbind() to combine training and test datasets
5.  Variable names are then applied to names(HAR_Combine) using HAR$feature
6.  The Tidy dataset is then generated from extracting only the measurements on the mean and standard deviation using regular expression function grep() -  grep("mean\\(|std\\(", names(HAR_Combine))
7.  Final Tidy Dataset is created by using merge() function to combine TidyDS created above plus the activity names from HAR$activity_features
8.  The second Tidy Dataset containing averages of each variable for each activity  & each subject using ddply() & melt() functions
