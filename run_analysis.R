## library(dplyr)

## Reading data and create data Frames

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## Merging data

XM <- rbind(x_train, x_test)
YM <- rbind(y_train, y_test)
SubjectM <- rbind(subject_train, subject_test)
Merged_Data <- cbind(SubjectM, XM, YM)

## Extract Mean & std deviation
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

##  Create meaningful headers
TidyData$code <- activities[TidyData$code, 2]

## Check table and Headings in TidyData
TidyData

## Assign descriptive names
names(TidyData)[2] = "Activity"
names(TidyData)<-gsub("Acc", "Acceleration", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "Time_Body", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "Std", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

## Final Tidy data table

FinalTidyData<- TidyData %>%
  group_by(subject, Activity) %>%
  summarise_all(funs(mean))
write.table(FinalTidyData, "FinalTidyData.txt", row.name=FALSE)


