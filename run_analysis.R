# First read in the activity labels
activityLabels <- fread("UCI_HAR_Dataset/activity_labels.txt", drop = 1, col.names = "activity", data.table = FALSE)

# Read in features
features <- fread("UCI_HAR_Dataset/features.txt", drop = 1, col.names = "features", data.table = FALSE)
# Remove all features without mean or std in them
cleanFeatures <- grepl("*mean*|*std*", features$features)
# Gather the list of features that meet the criteria
tidyFeatures <- features[which(cleanFeatures),]

# Make features more readable
tidierFeatures <- gsub("-", "", tidyFeatures)
tidierFeatures <- gsub("()", "", tidierFeatures)
columnNames <- c("subject","activity",tidierFeatures)

# Read test data
Subject <- fread("UCI_HAR_Dataset/test/subject_test.txt", data.table = FALSE)
Activity <- fread("UCI_HAR_Dataset/test/y_test.txt", data.table = FALSE)
Measurments <- fread("UCI_HAR_Dataset/test/X_test.txt", data.table = FALSE)
testData <- cbind(Subject,Activity,Measurments)
names(testData) <- columnNames

# Read train data
trainSubject <- fread("UCI_HAR_Dataset/train/subject_train.txt", data.table = FALSE)
trainActivity <- fread("UCI_HAR_Dataset/train/y_train.txt", data.table = FALSE)
trainMeasurments <- fread("UCI_HAR_Dataset/train/X_train.txt", data.table = FALSE)
trainData <- cbind(trainSubject, trainActivity, trainMeasurments)
names(trainData) <- columnNames

# Combine data sets
allData <- rbind(testData,trainData)

# Change the subject and activity to factors (allows for the next part to work as intended)
allData$subject <- as.factor(allData$subject)
allData$activity <- as.factor(allData$activity)

# Rename the activities to their appropriate descriptions
levels(allData$activity) <- as.list(activityLabels)[[1]]

# Create a tidy dataset with the average of each variable
tidyTable <- aggregate(.~subject+activity, allData, mean)


