library(reshape2)

fileUrl       <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
localFileName <- "dataset.zip"

# Download glorious data and uncompress it, if necessary.
if (!file.exists(localFileName))
{
  download.file(fileUrl, destfile=localFileName)
  unzip(localFileName)
}

# Load features data.  Eliminate all that are not measurements on mean or standard deviation
features       <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
features.idx   <- grep("mean|std", features[,2])
features.names <- features[features.idx,2]

# Load training subject, activity and data 
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainLabels   <- read.table("UCI HAR Dataset/train/y_train.txt")
trainData     <- read.table("UCI HAR Dataset/train/X_train.txt")[features.idx]
trainAll      <- cbind(trainSubjects, trainLabels, trainData)

# Load test subject, activity and data 
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testLabels   <- read.table("UCI HAR Dataset/test/y_test.txt")
testData     <- read.table("UCI HAR Dataset/test/X_test.txt")[features.idx]
testAll      <- cbind(testSubjects, testLabels, testData)

# Read activity without fancy smancy factor conversion
labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)

# Combine your chocolate with my peanut butter
all <- rbind(trainAll, testAll)

# Convert meaningless column names to something more readable
names(all) <- c("subject" , "activity", features.names)

# Convert activity factor from integer to string
all$activity <- factor(all$activity, levels=labels[,1],labels=labels[,2])

# Use melty magic to get means for each variable for each subject and activity
all.melt <- melt(all, id=c("subject","activity"))
all.mean <- dcast(all.melt, subject + activity ~ variable, fun.aggregate = mean)

# Output tidy data!
write.table(all.mean, file="./tidy.txt", row.name=FALSE, quote=FALSE)
