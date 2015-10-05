setwd("F:/Data Science/8. Pratical Machine Learning/Week4/Assessment")

library(caret)
#Q1
library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

View(vowel.train)
View(vowel.test)

y2 <- factor(vowel.train$y)
y3 <- factor(vowel.test$y)

set.seed(33833)

fit2 <- train(y2 ~ ., method = "rf", vowel.train)
fit3 <- train(y2 ~ ., method = "gbm", vowel.train)

predictRF <- predict(fit2, vowel.test)
predictGBM <- predict(fit3, vowel.test)

predictGBM == predictRF


length(predictRF)
length(predictGBM)

accuracy.rf <- (vowel.test$y == predictRF)
sum(accuracy.rf) / length(accuracy.rf[accuracy.rf == TRUE])

accuracy.gbm <- sum(predictGBM == factor(vowel.test$y))/length(predictRF)
sum(accuracy.gbm) / length(acc)
#Q2
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
View(testing)
set.seed(62433)
names(training); View(training)

#random forest model
fit.rf <- train(diagnosis ~ ., 
               method = "rf", 
               training,
               trControl = trainControl(method="cv"),
               number=3
               )

#boosted tree model
fit.gbm <- train(diagnosis ~ ., 
                method = "gbm", 
                training)

# linear discriminant analysis ("lda") 
fit.lda <- train(diagnosis ~ ., 
                method = "lda", 
                training)


#stack
 ...

#predict models
predict.rf <- predict(fit.rf, testing)
predict.gbm <- predict(fit.gbm, testing)
predict.lda <- predict(fit.lda, testing)


#Accuracy
errorRate.rf <- sum(predict.rf == testing$diagnosis) / length(testing$diagnosis)
accuracy.rf <- 1 - errorRate.rf

errorRate.gbm <- sum(predict.gbm == testing$diagnosis) / length(testing$diagnosis)
accuracy.gbm <- 1 - errorRate.gbm

errorRate.lda <- sum(predict.lda == testing$diagnosis) / length(testing$diagnosis)
accuracy.lda <- 1 - errorRate.lda

t.stack <-data.frame(predict.rf, predict.gbm, predict.lda, testing$diagnosis)
dim(t.stack)
View(t.stack)

model.stack <- train(testing$diagnosis ~ ., 
                     method = "rf",
                     data = t.stack)

predict.stack <- predict(model.stack, t.stack)

lookUp <- cbind(t.stack, predict.stack)
sum(predict.stack == predict.lda) / length(predict.lda)
#Q3
set.seed(233)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

dim(training)
dim(testing)


model.lasso<-train(CompressiveStrength~.,
              data=training, 
              method="lasso")

object <- enet(x=as.matrix(subset(training, 
                                  select=-c(CompressiveStrength))),
               y=training$CompressiveStrength,
               lambda=0)

plot.enet(object,xvar=c("penalty"))

#Q4
library(lubridate)
dat = read.csv("gaData.csv")
training = dat[year(dat$date) == 2011,]
tstrain = ts(training$visitsTumblr)
dim(training)
dim(tstrain)

s <- sum(testing$visitsTumblr>pred$upper[,2]) / length(testing$visitsTumblr)
1 - s

testing = testing = dat[year(dat$date)>2011,]

model.bats <- bats(tstrain)
pred <- forecast(model.bats, 
                 h=length(testing$visitsTumblr),
                 level=c(80,95))

accuracy <- 1-sum(testing$visitsTumblr>pred$upper[,2])/length(testing$visitsTumblr)

accuracy(pred, testing$visitsTumblr)
read.q4 <- read.csv("gaData.csv")
dim(read.q4)
View(read.q4)

#Q5
set.seed(3523)
set.seed(325)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training <- concrete[ inTrain,]
testing <- concrete[-inTrain,]


model.svm <- svm(CompressiveStrength ~ .,
                 data = training
                 )

predict.svm <- predict(model.svm, testing)

library(forecast)
accuracy(predict.svm, testing$CompressiveStrength)
