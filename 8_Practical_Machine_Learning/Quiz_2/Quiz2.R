#set up dir
setwd("F:/Data Science/8. Pratical Machine Learning/Week2/Assessment")

library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)



#Q1
adData = data.frame(diagnosis,predictors)
testIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[-testIndex,]
testing = adData[testIndex,]


adData = data.frame(predictors)
trainIndex = createDataPartition(diagnosis,p=0.5,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]

training[1:10, 1:2]
dim(training)
names(training)
testing[1:10, 1:2]
dim(testing)
names(testing)


#Q2
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
head(training)
names(training)
cat <- cut(training$CompressiveStrength, breaks=3, labels=c("S", "M", "L"))
plot(training$CompressiveStrength, col = cat)

plot(training$FlyAsh)

#Q3
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

par(mfrow=c(1, 2))
hist(training$Superplasticizer)
hist(log10(training$Superplasticizer))


#Q4
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

a <- which(grepl("^IL", colnames(training), ignore.case = F))
df <- training[,a]
b <- prcomp(df[,-1])
summary(b)

preProc<-preProcess(df[, -1],method="pca", thresh=.9)
trainPC<-predict(preProc,df[, -1])
b <- prcomp(trainPC[,-1])
cumsum(b)  

#Q5
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

a <- which(grepl("^IL|diagnosis", colnames(training), ignore.case = F))
df <- training[,a]

preProc<-preProcess(df[, -1],method="pca")
trainPC<-predict(preProc,df[, -1])
b <- prcomp(trainPC[,-1])

summary(b)


preProc <- preProcess(log10(training[,-58]+1),method="pca",pcaComp=2)
trainPC <- predict(preProc,log10(training[,-58]+1))
modelFit <- train(training$type ~ .,method="glm",data=trainPC)



#Q5
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

a <- which(grepl("^IL|diagnosis", colnames(training), ignore.case = F))
df <- training[,a]

View(df)
training <- training[c(1,58:69)] 
View(training)

testing <-testing[c(1,58:69)] 
View(testing)
g1 <- train(df$diagnosis~., data=training, method="glm")
