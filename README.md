TidyDataSet.txt

The original data set is from Human Activity Recognition Using Smartphones Dataset.
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

The TidyDataSet.txt is generate by following steps:
1. Extract data set from zip file including activity_labels.txt, features.txt, test/X_test.txt, test/Y_test.txt, test/subject_test.txt, train/X_train.txt, train/Y_train.txt,train/subject_train.txt.
2. Grouped data to make a full data set, and rename columns with descriptive column names.
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Join activity label to subjects activity ID to make descriptive activity data.
4. Get the average of each variable for each activity and each subject to make a new tidy dataset. 
5. Export tidy data in text file

The dataset includes the following files:

- 'README.md'

- 'CodeBook.md': Shows variables about the TidyDataSet.txt.

- 'TidyDataSet.txt': Data set.

