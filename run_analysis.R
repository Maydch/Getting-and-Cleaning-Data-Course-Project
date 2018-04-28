library(data.table)

#download data file
if(!file.exists("data")){
  dir.create("data")
}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "projectdata.zip",method = "curl")

unzip(zipfile ="projectdata.zip")

#Activity Lable
ActivityLabel <- fread(file="UCI HAR Dataset/activity_labels.txt"
                       ,col.names = c("Activity_ID","Activity"))

#Features
Features <- fread(file="UCI HAR Dataset/features.txt"
                  ,col.names = c("Feat_ID","Features"))

#TestData
DataX_test <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
DataY_test <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
Datasubject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)

DataX_train <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
DataY_train <- read.table("UCI HAR Dataset/train/Y_train.txt", header=FALSE)
Datasubject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)

#1.Merges the training and the test sets to create one data set.
#Merge Data
DataX <- rbind(DataX_test,DataX_train)
DataY <- rbind(DataY_test,DataY_train)
DataSubject <- rbind(Datasubject_test,Datasubject_train)

#set Column NAME
names(DataY)<-c("Activity_ID")
names(DataSubject)<-c("Subject")
names(DataX)<-Features$Features

#Needed Feature
NeedFeature <-  grepl("(mean|std)\\(\\)", Features[, Features])
subsetFeature <- subset(Features, NeedFeature)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#Extracts needed measurements
SubsetDataX <- subset(DataX,select = subsetFeature$Feat_ID)

#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names.
nDataY <- merge(DataY,ActivityLabel,by="Activity_ID")

#Full Dataset
FullDataSet <- cbind(DataSubject,nDataY$Activity,SubsetDataX)

names(FullDataSet)[2]<-"Activity"

#5.Data in average
TidyDataSet<-aggregate(. ~Subject + Activity,FullDataSet, mean)

write.table(TidyDataSet, file = "TidyDataSet.txt",row.name=FALSE)

