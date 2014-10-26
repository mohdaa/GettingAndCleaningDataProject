## Loading data into R
x_train <- read.table("X_train.txt", header = FALSE)
y_train <- read.table("y_train.txt", header = FALSE)
subject_train <- read.table("subject_train.txt", header = FALSE)
x_test <- read.table("X_test.txt", header = FALSE)
y_test <- read.table("y_test.txt", header = FALSE)
subject_test <- read.table("subject_test.txt", header = FALSE)
features <- read.table("features.txt", header = FALSE)
activity_labels <- read.table("activity_labels.txt", header = FALSE)


## Assigning meaningful names to each column of the loaded data
colnames(x_train) <- features[, 2]
colnames(y_train) <- "ActivityID"
colnames(subject_train) <- "SubjectID"
colnames(x_test) <- features[, 2]
colnames(y_test) <- "ActivityID"
colnames(subject_test) <- "SubjectID"
colnames(activity_labels) <- c("ActivityID", "ActivityType")

## Combining the train data into a single dataset
trainDataset <- cbind(y_train, subject_train, x_train)

## Combining the test data into a single dataset
testDataset <- cbind(y_test, subject_test, x_test)

## Appending the test to the train to creat a complete dataset
completeDataset <- rbind(trainDataset, testDataset)

## Creating a vector of column names to be used in the analysis
datasetCols <- colnames(completeDataset)

## Creating a vector of logical values to identify which column are means or standard
## deviation variablesactivities column names to be used in the analysis
meanSTDCols <- (grepl("ActivityID", datasetCols) | grepl("SubjectID", datasetCols) | 
                grepl("-std()", datasetCols) | grepl("-mean()", datasetCols) &
                        !grepl("-meanFreq()", datasetCols))

## Removing columns that are not means or standard deviation variables
completeDataset <- completeDataset[meanSTDCols == TRUE]

## Adding the ActivityType by merging the main dataset with activity_labels based on
## ActivityID
completeDataset <- merge(completeDataset, activity_labels, by = "ActivityID", all.x = TRUE)

## Update column names
datasetCols <- colnames(completeDataset)

## Making the variable names more meaningful
for (i in 1:length(datasetCols)) {
        
        if (substr(datasetCols[i], 1, 1) == "t") {
                datasetCols[i] <- sub("t", "Time", datasetCols[i])
                } else {
                        if (substr(datasetCols[i], 1, 1) == "f") {
                                datasetCols[i] <- sub("f", "Freq", datasetCols[i])
                        }
        }
        
        datasetCols[i] <- gsub("\\()", "", datasetCols[i])
        datasetCols[i] <- gsub("-std", "StdDev", datasetCols[i])
        datasetCols[i] <- gsub("-mean", "Mean", datasetCols[i])
        print(datasetCols[i])
}

## Update column names
colnames(completeDataset) <- datasetCols

## Removing the ActivityID column as ActivityType is available and more understandable
completeDataset <- completeDataset[, datasetCols != "ActivityID"]

## Update column names after removing the ActivityID column
datasetCols <- colnames(completeDataset)

## Creating the second dataset by calculating the means of each variable 
##for each activity and each subject
ScndDataset <- aggregate(completeDataset[2:(length(datasetCols) - 1)], 
                         by = list(ActivityType = completeDataset$ActivityType, 
                                   SubjectID = completeDataset$SubjectID), mean)
## Writing the resulting dataset into a text file
write.table(ScndDataset, "tidyData.txt", row.names = FALSE, sep = "\t")