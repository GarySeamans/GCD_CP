# First read in the activity labels
activityLabels <- read.table("UCI_HAR_Dataset/activity_labels.txt", col.names = c("","activity"))

# Read in features
features <- read.table("UCI_HAR_Dataset/features.txt")
# Remove all features without mean or std in them
cleanFeatures <- grepl("*mean*|*std*", features[,2])
# Gather the list of features that meet the criteria
tidyFeatures <- features[which(cleanFeatures),]


# Make features more readable
tidierFeatures <- gsub("-", "", tidyFeatures[,2])
# Assign column names
columnNames <- c("subject","activity",tidierFeatures)

# Read test data
Subject <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
Activity <- read.table("UCI_HAR_Dataset/test/y_test.txt")
Measurments <- read.table("UCI_HAR_Dataset/test/X_test.txt")
testData <- cbind(Subject,Activity,Measurments)
names(testData) <- columnNames

# Read train data
trainSubject <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
trainActivity <- read.table("UCI_HAR_Dataset/train/y_train.txt")
trainMeasurments <- read.table("UCI_HAR_Dataset/train/X_train.txt")
trainData <- cbind(trainSubject, trainActivity, trainMeasurments)
names(trainData) <- columnNames

# Combine data sets
allData <- rbind(testData,trainData)

# Change the subject and activity to factors (allows for the next part to work as intended)
allData$subject <- as.factor(allData$subject)
allData$activity <- as.factor(allData$activity)

# Rename the activities to their appropriate descriptions
levels(allData$activity) <- gsub("1", "Walking", levels(allData$activity))
levels(allData$activity) <- gsub("2", "Walking_Upstairs", levels(allData$activity))
levels(allData$activity) <- gsub("3", "Walking_Downstairs", levels(allData$activity))
levels(allData$activity) <- gsub("4", "Sitting", levels(allData$activity))
levels(allData$activity) <- gsub("5", "Standing", levels(allData$activity))
levels(allData$activity) <- gsub("6", "Laying", levels(allData$activity))

# Create a tidy dataset with the average of each variable
tidyTable <- aggregate(.~subject+activity, allData, mean)


