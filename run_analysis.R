# Author: Eunice Park
# Date:   8/23/15
# Description: The R script analyzes the Human Activity Recognition Using Smartphones Dataset
#              https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#              The script performs the following:
#              1. Merges the training and the test sets to create one data set.
#              2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#              3. Uses descriptive activity names to name the activities in the data set
#              4. Appropriately labels the data set with descriptive variable names. 
#              5. Creates a tidy data set as above
#              6. From the data set in step 4, creates a second, independent tidy data set with the average 
#                 of each variable for each activity and each subject.

# Set directory
setwd("~/Datascience/JHDS_BigData/CleanData/Project")
dir <- "UCI HAR Dataset"

library(reshape2)
library(plyr)

# Read in features.txt
HAR <- list()
HAR$features <- read.table(paste(dir, "features.txt", sep=" "), stringsAsFactors=FALSE, col.names=c('id', 'feature'))

# Read in activity_features.txt
HAR$activity_features <- read.table(paste(dir, "activity_labels.txt", sep="/"), col.names=c('id','activity'))

# Read in training data
subject <- read.table(paste(dir, "train", "subject_train.txt", sep="/"), col.names="subject")
x <- read.table(paste(dir, "train", "X_train.txt", sep="/"))
y <- read.table(paste(dir, "train", "y_train.txt", sep="/"), col.names = "activity_id")
HAR$train <- cbind(subject, y, x)

# Read in test data
subject2 <- read.table(paste(dir, "test", "subject_test.txt", sep="/"), col.names="subject")
x2 <- read.table(paste(dir, "test", "x_test.txt", sep="/"))
y2 <- read.table(paste(dir, "test", "y_test.txt", sep="/"), col.names = "activity_id")
HAR$test <- cbind(subject2, y2, x2)

# Merge the Training & Test data sets
HAR_Combine <- rbind(HAR$train, HAR$test)

# Apply meaningful variable names 
names(HAR_Combine) <- c("subject","activity_id",HAR$features$feature )

# Extract only the measurements on the mean and standard deviation for each measurement
TidyDS <- HAR_Combine[,c(1,2, grep("mean\\(|std\\(", names(HAR_Combine)))]

# Label each data with descriptive activity name
TidyDS <- merge(TidyDS, HAR$activity_features, by.x = "activity_id", by.y = "id")

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
TidyDSAvg <-  ddply(melt(TidyDS, id.vars=c("subject", "activity")), .(subject, activity), summarise, MeanSamples=mean(value))

# Write out data into files
write.table(TidyDS, file="tidyds.txt", row.names = FALSE)
write.table(TidyDSAvg, file="tidyds_avg.txt", row.names=FALSE)