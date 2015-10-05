#set up dir
setwd("F:/Data Science/8. Pratical Machine Learning/Week3/Assessment")

library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

dim(segmentationOriginal)
names(segmentationOriginal)
View(segmentationOriginal)

#Q1
inTrain <- createDataPartition(y = segmentationOriginal, p = 0.7, list = F)

test_set = subset(segmentationOriginal, Case == "Test")
train_set = subset(segmentationOriginal, Case == "Train")
dim(train_set)
View(train_set)

set.seed(125)

fit <- train(Class ~ ., method = "rpart", train_set)
fit$finalModel

library(rattle)
fancyRpartPlot(fit$finalModel)

library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
mydata<-segmentationOriginal
inTrain<-createDataPartition(y=mydata$Case,p=0.7,list=FALSE)
training<-mydata[inTrain,]
testing<-mydata[-inTrain,]
dim(training);dim(testing)
modFit<-train(Case~.,method="rpart", training)
print(modFit$finalModel)
plot(modFit$finalModel,uniform=TRUE,main="Classification Tree")
text(modFit$finalModel,use.n=TRUE,all=TRUE,CEX=0.8)
library(rattle)
fancyRpartPlot(modFit$finalModel)

#Q3
library(cepp)
data(olive)
olive = olive[,-1]
dim(olive); View(olive); names(olive)


fFit <- train(Area ~ ., method = "rpart", file)
newdata = as.data.frame(t(colMeans(file)))
dim(newdata); names(newdata)
predict(fFit, newdata=newdata)

file <- read.csv("file.csv")
sum(is.na(file))
dim(file); View(file)
fFit <- train(Area ~ ., method = "rpart", file)

model.olive <- rpart(Area ~ ., data = file[,-1])

newdata = as.data.frame(t(colMeans(file)))
predict.olive <- predict(model.olive, newdata)

library(tree)
model.olive <- tree(Area ~ ., data = file[,-1])

#======================================
#Q4
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
names(trainSA)
set.seed(13234)

fitGLM <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl,
                family = "binomial", method = "glm", trainSA)

preT <- predict(fitGLM$finalModel, trainSA)
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

prediction <- predict(fitGLM$finalModel, testSA)

T <- cbind(trainSA$chd, as.numeric(preT))
T[1:5, ]


fitGLM <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl,
                family = "binomial", method = "glm", testSA)

preT <- predict(fitGLM$finalModel, testSA)
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

prediction <- predict(fitGLM$finalModel, testSA)

T <- cbind(trainSA$chd, as.numeric(preT))
T[1:5, ]

T <- cbind(testSA$chd, as.numeric(preT))


#Q5
library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

View(vowel.train);View(vowel.test)

set.seed(33833)
set.seed(12345) 
y <- factor(vowel.train$y)

fit <- train(y ~ ., method = "rf", vowel.train)
rf <- randomForest(y ~ ., vowel.train, importance=TRUE)
imp <- varImp(rf, conditional=TRUE)
order(imp)

y2 <- factor(vowel.test$y)
rf2 <- randomForest(y ~ ., vowel.test, importance=TRUE)
imp2 <- varImp(rf2, conditional=TRUE)
order(imp2)
