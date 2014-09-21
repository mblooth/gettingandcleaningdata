## read data from the training set

y_train <- read.table("Getting and Cleaning Data/data/UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("Getting and Cleaning Data/data/UCI HAR Dataset/train/x_train.txt")
sub_train <- read.table("Getting and Cleaning Data/data/UCI HAR Dataset/train/subject_train.txt")
act <- read.table("Getting and Cleaning Data/data/UCI HAR Dataset/activity_labels.txt")
feat <- read.table("Getting and Cleaning Data/data/UCI HAR Dataset/features.txt")

## read data from the test set
y_test <- read.table("Getting and Cleaning Data/data/UCI HAR Dataset/test/y_test.txt")
x_test <- read.table("Getting and Cleaning Data/data/UCI HAR Dataset/test/x_test.txt")
sub_test <- read.table("Getting and Cleaning Data/data/UCI HAR Dataset/test/subject_test.txt")

## values in the features data set correspond to columns in the x_train data set
## extract these values from the features frame, and use it as factors for the x_train data set
names(x_train) <- feat$V2

## values in the features data set correspond to columns in the x_test data set
## extract these values from the features frame, and use it as factors for the x_test data set
names(x_test) <- feat$V2

## look for columns that have mean or standard deviaiton values
meanvec <- grep ("mean", feat$V2) 
stdvec <- grep ("std", feat$V2)
rowIndices <- c(meanvec, stdvec)

## extract these columns from the x_train and x_test data frames, discard the rest
x_train <- x_train [, rowIndices]
x_test <- x_test [, rowIndices]


## this code uses plyr and reshape2 libraries
require(plyr)
require (reshape2)

## combine activities and y_train
## values y_train are activities that need to be labeled according to the labels data set
y_train <- mapvalues (y_train$V1, act$V1, as.character(act$V2))


## merged train data
merged_train_data <- cbind(sub_train, y_train, x_train)
colnames(merged_train_data)[1] <- "Subject"
colnames(merged_train_data)[2] <- "Activity"

## combine activities and y_test
## values y_test are activities that need to be labeled according to the labels data set
y_test <- mapvalues (y_test$V1, act$V1, as.character(act$V2))


## merged test data
merged_test_data <- cbind(sub_test, y_test, x_test) 
colnames(merged_test_data)[1] <- "Subject"
colnames(merged_test_data)[2] <- "Activity"

## final combined data set for test and train
comb_data <- rbind(merged_train_data, merged_test_data)

## melt the combined data set 
comb_melt <- melt (comb_data, id = c("Subject", "Activity"))
final_data <- dcast(comb_melt, Subject + Activity ~ variable, mean)

## output the final data set
write.table(final_data,"./final_tidy_data.txt",row.name=F)

