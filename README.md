# Getting-and-Cleaning-Data-Course-Project
This repository contains the relevant files to satisfy the requirements of the Course Project for the "Getting &amp; Cleaning Data" course.

Steps to create the tidy data file:

1. Step 1 - download *run_analysis.R* to the top-level of the "UCI HAR Dataset" folder structure (place it in the "UCI HAR Dataset" folder)
2. Step 2 - run *run_analysis.R*
3. Step 3 - the tidy output file will be called "summary_data.txt" and stored in the "UCI HAR Dataset" folder

To load / verify the tidy data file, run the following in RStudio:

> data <- read.table(file_path, header = TRUE)

> View(data)

The run_analysis.R script will have accomplished the following tasks:

1. Merged the training and the test sets to create one data set.
2. Extracted only the measurements on the mean and standard deviation for each measurement.
3. Used descriptive activity names to name the activities in the data set
4. Appropriately labelled the data set with descriptive variable names.
5. From the data set in step 4, created a second, independent tidy data set with the average of each variable for each activity and each subject.
 
To do that, here are the steps the script follows:

1. Loads the feature names (and drops the first column)
2. Loads the activity labels
3. Loads the Labels, Subjects & Data for the Training set; as part of this step, it assigns the columns the descriptive feature names we loaded in step 1 
4. Loads the Labels, Subjects & Data for the Test set; as part of this step, it assigns the columns the descriptive feature names we loaded in step 1
5. Stitches together the data sets, and replaces the activity numeric IDs with the activity labels we loaded in step 2
6. Removes all of the measures except those that measure the mean and standard deviation
7. Groups the data frame on Activty and Subject
8. Averages the measurements for each activity by subject (using the grouping from step 8)
9. Writes out the tidy data to the file "summary_data.txt"

