# Getting and Cleaning Data Course Project

## Files
- The files were saved originally as UCI HAR Dataset but as a general rule I was taught, I changed it to UCI_HAR_Dataset
- The files on the second level of the directory were activity_labels.txt, features.txt, features_info.txt, and README.txt
- The folders on the second level were test and train
- Within each were a folder Inertial Signals, subject_[test/train],X_[test/train], and y_[test/train]

## Functions
- activityLabels reads the activity_labels.txt file and gave the column a name of "activity".
- features reads the features.txt file.
- cleanFeatures removes any unnecessary features from the old list by assigning them true/false objects.
- tidyFeatures finds the features assigned a TRUE object and places them into another list.
- tidierFeatures uses the gsub function to remove hyphens.
- columnNames assigns the names for the columns we use in the allData data set and tidyData data set.
- The [blank] or train versions of Subject, Activity, and Measurements reads the data from the test and train folders.
- I used cbind to bind all the data sets from test together and the same for train.
- I used the names() function to assign these new mass data sets the column names we attained previously.
- allData is the data set with the rows of testData and trainData combined.
- allData$x <- as.factor(allData$x) changes the subject and activity to factors to help with the next piece of code.
- the levels() function takes the activities numbers in the allData set and changes them to their corresponding labels from the activity labels we got beforehand.
- tidyTable used the aggregate function to take the mean of both the subject and activity. 