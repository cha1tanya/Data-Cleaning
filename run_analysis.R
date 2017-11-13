# Step 1: Merge the training and the test sets to create one data set.

# Step 1.1: Read and combine the training data sets
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names = "Activity")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = "SubjectID")

features <- read.table("./UCI HAR Dataset/features.txt",sep = " ")
features$V3 <- gsub("\\(\\)","",gsub("-",".",features$V2))

colnames(x_train) <- features$V3

train <- cbind(subject_train,y_train,x_train)

# Step 1.2: Read and combine the testing data sets
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names = "Activity")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = "SubjectID")

features <- read.table("./UCI HAR Dataset/features.txt",sep = " ")
features$V3 <- gsub("\\(\\)","",gsub("-",".",features$V2))

colnames(x_test) <- features$V3

test <- cbind(subject_test,y_test,x_test)

# Step 1.3: Merge train and test data sets
TrainAndTestData <- rbind(train,test)

# Step 2: Extract only the measurements on the mean and standard deviation for each measurement.
SelectColumns <- grep(".mean.|.std.",colnames(TrainAndTestData))
MeanStdData <- TrainAndTestData[,c(1:2,SelectColumns)]


# Step 3: Use descriptive activity names to name the activities in the data set
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("Activity","Activity.Name"))
library(dplyr)
MeanStdData_Activity <- inner_join(MeanStdData,activity_labels,by="Activity")
MeanStdData_Activity <- MeanStdData_Activity[,c(1,64,3:63)]

# Step 4: Appropriately label the data set with descriptive variable names.
# Each variable is labelled as and when defined in the steps above. Hence, there is no further need here.

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Summary_Means <- MeanStdData_Activity %>% group_by(SubjectID,Activity.Name) %>% summarise_all(mean)
colnames(Summary_Means)[3:63] <- paste("Mean(",colnames(Summary_Means)[3:63],")",sep = "")

write.table(Summary_Means, file = "./Summary_Means.txt")
Col_Names <- colnames(Summary_Means)
write.table(Col_Names, file = "./FeatureList.txt", col.names = FALSE, quote = FALSE)
