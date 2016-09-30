library(reshape2)

filename <- "dataset.zip"

## Download the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}

## Unzip the dataset if not already present in the directory

if (!file.exists("input_dataset")) { 
  unzip(filename) 
}

# Load activity labels + features
activityLabels <- read.table("input_dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("input_dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
acceptablefeatures <- grep(".*mean.*|.*std.*", features[,2])
acceptablefeatures.names <- features[acceptablefeatures,2]
acceptablefeatures.names = gsub('-mean', 'Mean', acceptablefeatures.names)
acceptablefeatures.names = gsub('-std', 'Std', acceptablefeatures.names)
acceptablefeatures.names <- gsub('[-()]', '', acceptablefeatures.names)


# Load the datasets
train <- read.table("input_dataset/train/X_train.txt")[acceptablefeatures]
trainActivities <- read.table("input_dataset/train/Y_train.txt")
trainSubjects <- read.table("input_dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("input_dataset/test/X_test.txt")[acceptablefeatures]
testActivities <- read.table("input_dataset/test/Y_test.txt")
testSubjects <- read.table("input_dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels
merged_data <- rbind(train, test)
colnames(merged_data) <- c("subject", "activity", acceptablefeatures.names)

# turn activities & subjects into factors
merged_data$activity <- factor(merged_data$activity, levels = activityLabels[,1], labels = activityLabels[,2])
merged_data$subject <- as.factor(merged_data$subject)

merged_data.melted <- melt(merged_data, id = c("subject", "activity"))
merged_data.mean <- dcast(merged_data.melted, subject + activity ~ variable, mean)

write.table(merged_data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
