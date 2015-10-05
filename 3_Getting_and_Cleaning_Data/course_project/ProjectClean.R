url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- download.file(url, destfile="./data.csv")


setwd("F:/Data Science/3. Getting and Cleaning Data/Week4/Project")

X_train <- read.table("X_train.txt")
colnames(X_train) = features[, 2]
dim(X_train)
summary(X_train)

y_train <- read.table("y_train.txt")
colnames(y_train) = c("activityLabels")
dim(y_train)

##step #1
#combine (X_train) and (y_train)
bind1 <- cbind(X_train, y_train)
dim(bind1)

X_test <- read.table("X_test.txt")
dim(X_test)
summary(X_test)

y_test <- read.table("y_test.txt")
dim(y_test)

#combine (X_test) and (y_test)
bind2 <- cbind(X_test, y_test)
dim(bind2)

#combine (bind1) and (bind2)
Bind <- rbind(bind1, bind2)
dim(Bind)
head(Bind)

##step #2
#Extracts only the measurements on the mean and
#standard deviation for each measurement. 
ext1 <- Bind[, 1:6]
dim(ext1)

ext2 <- Bind[, 41:46]
dim(ext2)

ext3 <- Bind[, 81:86]
dim(ext3)

ext4 <- Bind[, 121:126]
dim(ext4)

ext5 <- Bind[, 161:166]
dim(ext5)

ext6 <- Bind[, 201:202]
dim(ext6)

ext7 <- Bind[, 214:215]
dim(ext7)

ext8 <- Bind[, 227:228]
dim(ext8)

ext9 <- Bind[, 240:241]
dim(ext9)

ext10 <- Bind[, 253:254]
dim(ext10)

ext11 <- Bind[, 266:271]
dim(ext11)

ext12 <- Bind[, 345:350]
dim(ext12)

ext13 <- Bind[, 424:429]
dim(ext13)

ext14 <- Bind[, 503:504]
dim(ext14)

ext15 <- Bind[, 516:517]
dim(ext15)

ext16 <- Bind[, 529:530]
dim(ext16)

ext17 <- Bind[, 542:543]
dim(ext17)

extractMeanStd <- cbind(ext1, ext2, ext3, ext4, ext5, ext6, ext7, 
      ext8, ext9, ext10, ext11, ext12, ext13, ext14, ext15, ext16, ext17)

dim(extractMeanStd)

extractMeanStd[1:50, 29:33]
names(extractMeanStd)

##step #3
numericLabels <- c(1,2,1,3,2,4)
exampledf <- data.frame(numericLabels)
exampledf$descriptiveLabels <- "unset"
exampledf$descriptiveLabels[exampledf$numericLabels == 1] <- "ardvark"
exampledf$descriptiveLabels[exampledf$numericLabels == 2] <- "baboon"
exampledf$descriptiveLabels[exampledf$numericLabels == 3] <- "cat"
exampledf$descriptiveLabels[exampledf$numericLabels == 4] <- "dog"
exampledf$descriptiveLabels <- as.factor(exampledf$descriptiveLabels)
exampledf

features <- read.table("features.txt")

activity <- read.table("activity_labels.txt")
c(actibity)
activity[1]
aL <- list(activity[, 1], activity[, 2])

g <- split(extractMeanStd[, 1:65], aL)
