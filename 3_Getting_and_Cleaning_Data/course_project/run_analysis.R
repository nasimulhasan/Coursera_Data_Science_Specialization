setwd("F:/Data Science/3. Getting and Cleaning Data/Week4/Project")

##load the files
X_train <- read.table("X_train.txt")
dim(X_train)

y_train <- read.table("y_train.txt")
dim(y_train)

subject_train <- read.table("subject_train.txt")
dim(subject_train)

X_test <- read.table("X_test.txt")
dim(X_test)

y_test <- read.table("y_test.txt")
dim(y_test)

subject_test <- read.table("subject_test.txt")
dim(subject_test)

features <- read.table("features.txt")

activity <- read.table("activity_labels.txt")

##step #1 
#label the columns
colnames(X_train) = features[, 2]
names(X_train)

colnames(y_train) = c("activity")
names(y_train)

colnames(subject_train) = c("subject")
names(subject_train)

colnames(X_test) = features[, 2]
names(X_test)

colnames(y_test) = c("activity")
names(y_test)

colnames(subject_test) = c("subject")
names(subject_test)

#combine subject_train, y_train and  X_train
bindTrain <- cbind(subject_train, y_train, X_train)
bindTrain[1:5, 1:5]
dim(bindTrain)

#combine subject_test, y_test and  X_test
bindTest <- cbind(subject_test, y_test, X_test)
dim(bindTest)

#combine bindTrain and bindTest
bindTrainTest <- rbind(bindTrain, bindTest)
dim(bindTrainTest)

##step #2
#Extracts only the measurements on the mean and
#standard deviation for each measurement. 
ext1 <- bindTrainTest[, 1:8]
dim(ext1)

ext2 <- bindTrainTest[, 43:48]
dim(ext2)

ext3 <- bindTrainTest[, 83:88]
dim(ext3)

ext4 <- bindTrainTest[, 123:128]
dim(ext4)

ext5 <- bindTrainTest[, 163:168]
dim(ext5)

ext6 <- bindTrainTest[, 203:204]
dim(ext6)

ext7 <- bindTrainTest[, 216:217]
dim(ext7)

ext8 <- bindTrainTest[, 229:230]
dim(ext8)

ext9 <- bindTrainTest[, 242:243]
dim(ext9)

ext10 <- bindTrainTest[, 255:256]
dim(ext10)

ext11 <- bindTrainTest[, 268:273]
dim(ext11)

ext12 <- bindTrainTest[, 347:352]
dim(ext12)

ext13 <- bindTrainTest[, 426:431]
dim(ext13)

ext14 <- bindTrainTest[, 505:506]
dim(ext14)

ext15 <- bindTrainTest[, 518:519]
dim(ext15)

ext16 <- bindTrainTest[, 531:532]
dim(ext16)

ext17 <- bindTrainTest[, 544:545]
dim(ext17)

extractMeanStd <- cbind(ext1, ext2, ext3, ext4, ext5, ext6, ext7, 
                        ext8, ext9, ext10, ext11, ext12, ext13, ext14, ext15, ext16, ext17)

dim(extractMeanStd)

extractMeanStd[1:50, 1:5]
names(extractMeanStd)

#step # 3 and 4, label the activity
extractMeanStd$activity[extractMeanStd$activity == 1] <- "WALKING"
extractMeanStd$activity[extractMeanStd$activity == 2] <- "WALKING_UPSTAIRS"
extractMeanStd$activity[extractMeanStd$activity == 3] <- "WALKING_DOWNSTAIRS"
extractMeanStd$activity[extractMeanStd$activity == 4] <- "SITTING"
extractMeanStd$activity[extractMeanStd$activity == 5] <- "STANDING"
extractMeanStd$activity[extractMeanStd$activity == 6] <- "LAYING"

extractMeanStd[10:90, 1:4]
dim(extractMeanStd)

#step #5
#create second independent data set
#split the data set using activity and subject variables
#compute col means and transpose the data set
#check out the dimension, column name, row name
li <- list(extractMeanStd$activity, extractMeanStd$subject)
g <- split(extractMeanStd[, 3:length(extractMeanStd)], li)
splitData <- sapply(g, colMeans)

tidy <- t(splitData)
dim(tidy)
colnames(tidy)
rownames(tidy)
tidy[1:180, 1:66]

##write up the tidy data to a txt file and read the tidy data
tidyData <- write.table(tidy, "TidyData.txt", sep="\t", eol="\n", row.names=FALSE, col.names=TRUE)

data <- read.table("TidyData.txt")
data
dim(data)
