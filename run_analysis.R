# Read Column names
colNames <- read.table("./UCI HAR Dataset/features.txt", header =FALSE, strip.white=TRUE)

# Load test subject data
tSub <- read.table("./UCI HAR Dataset/test/subject_test.txt", header =FALSE, strip.white=TRUE)
names(tSub)[names(tSub)=="V1"] <- "Subject#" #Change Column Name
# Load test label data
tLbl <- read.table("./UCI HAR Dataset/test/y_test.txt", header =FALSE, strip.white=TRUE)
names(tLbl)[names(tLbl)=="V1"] <- "ActivityType#" #Change Column Name
# Load test label data
tVar <- read.table("./UCI HAR Dataset/test/X_test.txt", header =FALSE, strip.white=TRUE)
colnames(tVar) <- colNames$V2 # assign column names
# Merging test data
tmv <- cbind.data.frame(tSub, tLbl, tVar)

# Load Training subject data
tnSub <- read.table("./UCI HAR Dataset/train/subject_train.txt", header =FALSE, strip.white=TRUE)
names(tnSub)[names(tnSub)=="V1"] <- "Subject#" #Change Column Name
# Load Training label data
tnLbl <- read.table("./UCI HAR Dataset/train/y_train.txt", header =FALSE, strip.white=TRUE)
names(tnLbl)[names(tnLbl)=="V1"] <- "ActivityType#" #Change Column Name
# Load Training label data
tnVar <- read.table("./UCI HAR Dataset/train/X_train.txt", header =FALSE, strip.white=TRUE)
colnames(tnVar) <- colNames$V2 # assign column names
# Merging Train data
tnmv <- cbind.data.frame(tnSub, tnLbl, tnVar)

# Finally merge test and training data
fD <- rbind(tmv,tnmv)

# Select only columns with mean, and std in their column names
fdmean <- fD[, grep("mean", names(fD), value=TRUE)]
fdsd <- fD[, grep("std", names(fD), value=TRUE)]

# Make the final data set
finalDataSet <- cbind.data.frame(fD[,1] , fD[,2], fdmean, fdsd)
names(finalDataSet)[names(finalDataSet)=="fD[, 1]"] <- "Subject"
names(finalDataSet)[names(finalDataSet)=="fD[, 2]"] <- "ActivityType"

#update the activity data
finalDataSet[ finalDataSet$ActivityType == "1",2] = "WALKING"
finalDataSet[ finalDataSet$ActivityType == "2",2] = "WALKING_UPSTAIRS"
finalDataSet[ finalDataSet$ActivityType == "3",2] = "WALKING_DOWNSTAIRS"
finalDataSet[ finalDataSet$ActivityType == "4",2] = "SITTING"
finalDataSet[ finalDataSet$ActivityType == "5",2] = "STANDING"
finalDataSet[ finalDataSet$ActivityType == "6",2] = "LAYING"

# Summarize data by groups
attach(finalDataSet)
SummaryDataSet <- aggregate(finalDataSet, by=list(Subject,ActivityType), FUN=mean, na.rm=TRUE)
detach(finalDataSet)

#Drop uneccesary columns
drops <- c("Subject","ActivityType") 
SummaryDataSet <- SummaryDataSet[,!(names(SummaryDataSet) %in% drops)]
names(SummaryDataSet)[names(SummaryDataSet)=="Group.1"] <- "Subject"
names(SummaryDataSet)[names(SummaryDataSet)=="Group.2"] <- "ActivityType"
#write output
write.table(SummaryDataSet, "TidyData.txt") 
