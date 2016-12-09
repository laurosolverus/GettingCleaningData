run_analysis <- function(){
  #libraries
  library(dplyr)
  library(tidyr)
  
  #Getting data
  setwd("~/Dropbox/Data Science Specialization/Getting n Cleaning/UCI HAR Dataset/test")
  X_test <- read.table("X_test.txt")#Test set
  y_test <- read.table("y_test.txt")#Test labels
  subject_test <- read.table("subject_test.txt")#Each row identifies the subject who performed the activity for each window sample.
  setwd("~/Dropbox/Data Science Specialization/Getting n Cleaning/UCI HAR Dataset/train")
  X_train <- read.table("X_train.txt")#Training set
  y_train <- read.table("y_train.txt")#Training labels
  subject_train <- read.table("subject_train.txt")
  activity_labels <- read.table("activity_labels.txt")#Links the class labels with their activity name.
  setwd("~/Dropbox/Data Science Specialization/Getting n Cleaning/UCI HAR Dataset/train/Inertial Signals")
  body_acc_x_train <- read.table("body_acc_x_train.txt")
  body_acc_y_train <- read.table("body_acc_y_train.txt")
  body_acc_z_train <- read.table("body_acc_z_train.txt")
  body_gyro_x_train <- read.table("body_gyro_x_train.txt")
  body_gyro_y_train <- read.table("body_gyro_y_train.txt")
  body_gyro_z_train <- read.table("body_gyro_z_train.txt")
  total_acc_x_train <- read.table("total_acc_x_train.txt")
  total_acc_y_train <- read.table("total_acc_y_train.txt")
  total_acc_z_train <- read.table("total_acc_y_train.txt")
  setwd("~/Dropbox/Data Science Specialization/Getting n Cleaning/UCI HAR Dataset/test/Inertial Signals")
  body_acc_x_test <- read.table("body_acc_x_test.txt")
  body_acc_y_test <- read.table("body_acc_y_test.txt")
  body_acc_z_test <- read.table("body_acc_z_test.txt")
  body_gyro_x_test <- read.table("body_gyro_x_test.txt")
  body_gyro_y_test <- read.table("body_gyro_y_test.txt")
  body_gyro_z_test <- read.table("body_gyro_z_test.txt")
  total_acc_x_test <- read.table("total_acc_x_test.txt")
  total_acc_y_test <- read.table("total_acc_y_test.txt")
  total_acc_z_test <- read.table("total_acc_y_test.txt")
  setwd("~/Dropbox/Data Science Specialization/Getting n Cleaning/UCI HAR Dataset")
  features <- read.table("features.txt")
  
  #Appropriately labels the data set with descriptive variables names
  testdt <- cbind.data.frame(subject_test, y_test, X_test)
  parameter <- features$V2
  parameter <- as.character(parameter)
  testdt <- setNames(testdt, c("Activity", "Subject", parameter))
  valid_column_names <- make.names(names=names(testdt), unique=TRUE, allow_ = TRUE)
  names(testdt) <- valid_column_names
  testdt <- cbind(testdt, group="test")
  traindt <- cbind.data.frame(subject_train, y_train, X_train)
  names(traindt) <- valid_column_names
  traindt <- cbind(traindt, group="train")
  
  #merge the trainning and the test sets to create one data set
  alldata <-rbind(testdt, traindt)
  
  #Extracts only the measurements on the mean and std for each measurement
  alldataMeanStd <- select(alldata, Activity, Subject, contains("mean"),contains("std"), group)
  
  #Use descriptive activity names to name the activities in the data set
  alldataMeanStdNames <- merge(alldataMeanStd, activity_labels, by.x = "Activity", by.y = "V1", all = TRUE )
  alldataMeanStdNames <- select(alldataMeanStdNames, -Activity)
  alldataMeanStdNames<- rename(alldataMeanStdNames, activity = V2)
  alltidydata <- alldataMeanStdNames%>%
    gather(Parameters, Value, tBodyAcc.mean...X:fBodyBodyGyroJerkMag.std..)
  View(alltidydata)
  
  #From the previously data set, creates a second independent tidy data set with the average of each variable for each activity and each subject
  groupSummarize <- group_by(alltidydata, activity, Subject, Parameters)
  secondDataSet <- summarize(groupSummarize, Average = mean(Value))
  View(secondDataSet)
  
}