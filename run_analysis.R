
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr) 

# Change WD to the folder with the data
setwd("~/RWorkingDir/Getting and Cleaning Data/Week 3/UCI HAR Dataset")

# Load Feature names, then drop the first column since it's meaningless
# We will use feature_names to name the columns as we import the train and test data (to satisfy req #4)
feature_names <- read.table("features.txt",sep=" ")
feature_names <- feature_names[,2]

# Load Activity Labels
# We will use activity_labels to provide meaningful descriptions of the activity in each measurement (to satisfy req #3)
activity_labels <- read.table("activity_labels.txt",sep=" ", col.name=c("ActivityID", "ActivityDesc"))

# Load the Labels, Subjects & Data for the Training set
train_labels <- read.table("train/Y_train.txt",col.names=(c("activity")), as.is=TRUE)
train_subjects <- read.table("train/subject_train.txt", col.names=(c("Subject")))
train_data <- read.table("train/X_train.txt",col.names = feature_names, as.is=TRUE)   # To satisfy req #4, on import columns are assigned descriptive names from feature_names

# Load the Labels, Subjects & Data for the Test set
test_labels <- read.table("test/Y_test.txt",col.names=(c("activity")), as.is=TRUE)
test_subjects <- read.table("test/subject_test.txt", col.names=(c("Subject")))
test_data <- read.table("test/X_test.txt",col.names = feature_names, as.is=TRUE)      # To satisfy req #4, on import columns are assigned descriptive names from feature_names

# Stitch them all together
full_train_data <- cbind(train_subjects, train_labels, train_data)      # stitch together the subjects, activity labels and measurement data for training set
full_test_data <- cbind(test_subjects, test_labels, test_data)          # stitch together the subjects, activity labels and measurement data for test set
full_data <- rbind(full_train_data, full_test_data)                     # To satisfy req #1, stitch the training set to the test set
full_data <- merge(activity_labels, full_data, by.x="ActivityID", by.y="activity")  # To satisfy req #3, replace activity IDs with descriptions (we do it after stitching because merge reorders records)

# Now, to satisfy req #2, keep only "the measurements on the mean and standard deviation for each measurement" 
full_data <- select(full_data,contains("ActivityDesc"), contains("Subject"), ends_with("mean...X"), ends_with("mean...Y"), ends_with("mean...Z"), ends_with("mean.."), contains("std.."))

#### We now have the data set required through step #4 of the assignment. It's time to create a second, independent tidy data set with the average of each variable for each activity and each subject.

by_subject_activity <- group_by(full_data, ActivityDesc, Subject) # Group the data frame on Activty and Subject
summary_data <- summarise_each(by_subject_activity, funs(mean))   # Average the measurements for each activity by subject

# To satisfy req #5, write the tidy data out to a file
write.table(summary_data, "~/RWorkingDir/Getting and Cleaning Data/Week 3/summary_data.txt", row.names=FALSE)

#######

# Per David's post in the forum, here is a bit of code for reading the file back into R and viewing it (remove comments):

# data <- read.table(file_path, header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
# View(data)

# h/t https://class.coursera.org/getdata-012/forum/thread?thread_id=9

#######
