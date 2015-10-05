setwd("F:/Data Science/8. Pratical Machine Learning/Week3/Assessment/Project")
getwd()

#different reading format
trainRawData <- read.csv("pml-training.csv", na.strings=c("NA",""))
dim(trainRawData)
#discard NA
NAs2 <- apply(trainRawData, 2, 
             function(x) { sum(is.na(x))})

validData2 <- trainRawData[, which(NAs2 == 0)]
dim(validData2)

#make trianing set
library(caret)
training <- createDataPartition(y = validData2$classe,
                                p = 0.2,
                                list = FALSE)
trainData <- validData2[training, ]
dim(trainData); View(trainData)


#discard useless predictors
removeIndex <- grep("timestamp|X|user_name|new_window",names(trainData))
dim(removeIndex); View(trainData)
trainData <- trainData[,-removeIndex]
dim(trainData); View(trainData)

#total accel features
total <- which(grepl("^total", 
                 colnames(trainData), 
                 ignore.case = F))

totalAccel <- trainData[, total]

featurePlot(x = totalAccel,
            y = trainData$classe,
            pch = 19,
            main = "Feature plot",
            plot = "pairs")

#save the plot as a png file
dev.copy(png, file = "plotFeature.png", width = 720, height = 720)
dev.off()

#plot the final features
featurePlot(x = trainData[, 1:4],
            y = trainData$classe,
            plot = "pairs")

#train control
trControl <- trainControl(method = "cv", number = 4)
#make model
modelFit.rpart <- train(trainData$classe ~., 
                  method = "rpart",
                  trainData)

modelFit.svm <- train(trainData$classe ~., 
                        method = "svmRadial",
                        trainData)

modelFit.rf <- train(trainData$classe ~., 
                        method = "rf",
                        trControl = trControl,
                        trainData)

# Random Forest 
# 
# 3927 samples
# 53 predictors
# 5 classes: 'A', 'B', 'C', 'D', 'E' 
# 
# No pre-processing
# Resampling: Cross-Validated (4 fold) 
# 
# Summary of sample sizes: 2944, 2946, 2946, 2945 
# 
# Resampling results across tuning parameters:
#         
#         mtry  Accuracy  Kappa  Accuracy SD  Kappa SD
# 2     0.972     0.965  0.0109       0.0138  
# 27    0.983     0.979  0.00458      0.0058  
# 53    0.979     0.974  0.00565      0.00716 
# 
# Accuracy was used to select the optimal model using  the
# largest value.
# The final value used for the model was mtry = 27. 

sampleErrorTestData <- validData2[5000:5005, ]
removeIndexSam <- grep("timestamp|X|user_name|new_window",names(validData2))
sampleErrorTestData <- sampleErrorTestData[, -removeIndexSam]
dim(sampleErrorTestData)

f <- train(sampleErrorTestData$classe ~., 
           method = "rf",
           trControl = trControl,
           sampleErrorTestData)
predict.outOfsampleError <- predict(modelFit.rf, sampleErrorTestData, se.fit=TRUE)
# =============================================
#testing data set
testRawData <- read.csv("pml-testing.csv", na.strings=c("NA",""))
dim(testRawData)

#discard NA
NAs <- apply(testRawData, 2, 
             function(x) { sum(is.na(x))})

validDataT <- testRawData[, which(NAs == 0)]
dim(validDataT); View(validDataT)

NAs2 <- apply(trainRawData, 2, 
              function(x) { sum(is.na(x))})

validData2 <- trainRawData[, which(NAs2 == 0)]
dim(validData2)

testing <- createDataPartition(y = validDataT$classe,
                                p = 0.2,
                                list = FALSE)
#discard useless predictors
removeIndex <- grep("timestamp|X|user_name|new_window",names(validDataT))
dim(removeIndex); View(validDataT)
testData <- validDataT[,-removeIndex]
dim(testData); View(testData)

#prediction
model.predict <- predict(modelFit.rf, testData)


#write up
pml_write_files = function(x){
        n = length(x)
        for(i in 1:n){
                filename = paste0("problem_id_",i,".txt")
                write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
        }
}

chr <- c(as.character(model.predict))
length(chr)

pml_write_files(chr)