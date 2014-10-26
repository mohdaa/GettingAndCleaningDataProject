Getting and Cleaning Data Project
=============================

### run_analysis.R

The R script "run_analysis.R" executes a set of commands that consolidate data from different text filesand outputs "tidyData.txt" file as follows:

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement.
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive activity names.
5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Running the Script

1.  Loading data into R.
2.  Assigning meaningful names to each column of the loaded data.
3.  Combining the train data into a single dataset.
4.  Combining the test data into a single dataset.
5.  Appending the test to the train to creat a complete dataset.
6.  Removing columns that are not means or standard deviation variables
7.  Adding the ActivityType by merging the main dataset with activity_labels based on ActivityID
8.  Run a for loop to make the variable names more meaningful
9.  Removing the ActivityID column as ActivityType is available and more understandable
10.  Creating the second dataset by calculating the means of each variable for each activity and each subject
11.  Writing the resulting dataset "tidyData.txt" file


### CodeBook.md

This markdown files contains discription of the variables output in the "tidyData.txt" file.