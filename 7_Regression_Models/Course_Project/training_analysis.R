---
title: "Training set: clean up"
output: pdf_document
---
        
Training set Analysis
================
        
Load the dataset
==================================
setwd("F:/Introduction to Data Science/Week5/Assessment/Kaggle_Higgs_Boson_Machine_Learning_Challenge")
getwd()

training <- read.csv("training.csv")


Analyze the structure of the data set
===========================

dim(training)
names(training)
str(training)
summary(training)
print(object.size(training), units = "MB")

tidy <- training[, 2:31]
Label <- training[, 33]
tidy <- cbind(tidy, Label)
# Differencing particles
total <- which(grepl("^mass", 
                     colnames(training), 
                     ignore.case = F))

mass <- training[, total]

library(caret)
library(kernlab)
library(ipred)
library(plyr)

set.seed(100)
partionData <- createDataPartition(y = tidy$Label,
                                   p = 0.1,
                                   list = FALSE)
print(object.size(partionData), units = "Mb")
trainData.DER <- tidy[partionData, ]
testData.DER <- tidy[-partionData, ]

ctrl <- trainControl(method = "cv", 
                     number = 4
)


modelFit.rf <- train(Label~ ., 
                     method = "rf",
                     data = trainData.DER,
                     
                     nodesize = 15,
                     tuneLength = 15, #how many candidate are evaluated
                     trControl = ctrl
)
#0.827

rf.predict.DER <- predict(modelFit.rf,
                               #training.elimNA[1:90000, ]
                               testData.DER
                               #type = "prob" #compute class probabilities from the model
)
imp <- varImp(modelFit.rf)
# > imp
# rf variable importance
# 
# only 20 most important variables shown (out of 30)
# 
# Overall
# DER_mass_MMC                100.000
# DER_mass_transverse_met_lep  62.602
# DER_mass_vis                 43.634
# PRI_tau_pt                   31.342
# DER_met_phi_centrality       27.497
# DER_pt_ratio_lep_tau         23.699
# DER_deltar_tau_lep           20.409
# PRI_met                      17.145
# DER_pt_h                     13.292
# DER_pt_tot                   10.624
# DER_deltaeta_jet_jet         10.534
# PRI_lep_pt                   10.214
# DER_sum_pt                   10.157
# PRI_lep_eta                   8.808
# PRI_met_sumet                 8.577
# PRI_tau_eta                   8.198
# DER_mass_jet_jet              8.061
# PRI_tau_phi                   7.846
# DER_lep_eta_centrality        7.649
# PRI_lep_phi                   7.524

confusionMatrix(treebag.predict.DER, testData.DER$Label)

L <- as.numeric(testData.DER$Label) - 1
p <- as.numeric(treebag.predict.DER) - 1
accuracy.train.test <- sum(p == L) / length(p)


threshold <- 0.002

predicted <- rep("b",199999)
predicted[p >= threshold] <- "s"
AMS(pred=predicted,real=testData.DER$Label,weight=testData.DER$Weight)
AMS(pred=predicted,
    real=training.elimNA$Label, 
    weight=training.elimNA$Weight)

# 2.61082 svm
# [1] 2.636187 gbm
#     2.846631 gbm[train 50000]
#     2.87835 gbm[train 75000]
#     3.184704 treebag [50000]
#     3.563175 treebag [125000]

AMS = function(pred,real,weight)
{
        #a = table(pred,real)
        pred_s_ind = which(pred=="s")                          # Index of s in prediction
        real_s_ind = which(real=="s")                          # Index of s in actual
        real_b_ind = which(real=="b")                          # Index of b in actual
        s = sum(weight[intersect(pred_s_ind,real_s_ind)])      # True positive rate
        b = sum(weight[intersect(pred_s_ind,real_b_ind)])      # False positive rate
        
        b_tau = 10                                             # Regulator weight
        ans = sqrt(2 * ((s+b+b_tau) * log(1 + s / (b+b_tau)) - s))
        return(ans)
}

#load the updated test data
testData <- read.csv("test.csv")
dim(testData)
View(testData)
names(testData)

predict.test <- predict(modelFit.rf,
                        #training.elimNA[1:90000, ]
                        testData
                        #type = "prob" #compute class probabilities from the model
                        )
pred <- as.numeric(predict.test) - 1
predicted=rep("b",550000)
predicted[predict.test>=threshold]="s"
weightRank = rank(predict.test, ties.method= "random")


submission = data.frame(EventId = testData$EventId, 
                        RankOrder = weightRank, 
                        Class = predict.test)
write.csv(submission, "submission_version4.csv", row.names=FALSE)


Plot the features
================
        
library(ggplot2)
par(mfrow = c(34, 2))
qplot(DER_deltar_tau_lep,
      DER_pt_ratio_lep_tau,
      col = Label, 
      data = training
)

qplot(PRI_jet_all_pt, 
      PRI_jet_leading_pt, 
      
      col = Label, 
      data = training
)

qplot(DER_mass_vis, 
      Weight, 
      col = Label, 
      data = training
)

qplot(DER_pt_h, 
      Weight, 
      col = Label, 
      data = training
)

qplot(DER_deltaeta_jet_jet, 
      Weight, 
      col = Label, 
      data = training
)

qplot(DER_mass_jet_jet, 
      Weight, 
      col = Label, 
      data = training
)

qplot(DER_prodeta_jet_jet, 
      Weight, 
      col = Label, 
      data = training
)

qplot(DER_prodeta_jet_jet, 
      Weight, 
      col = Label, 
      data = training
)

qplot(DER_deltar_tau_lep, 
      Weight, 
      col = Label, 
      data = training
)

qplot(DER_pt_tot, 
      Weight, 
      col = Label, 
      data = training
)

qplot(DER_sum_pt, 
      Weight, 
      col = Label, 
      data = training
)

qplot(DER_pt_ratio_lep_tau, 
      Weight, 
      col = Label, 
      data = training
)

qplot(DER_met_phi_centrality, 
      Weight, 
      col = Label, 
      data = training
)

qplot(DER_lep_eta_centrality, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_tau_pt, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_tau_eta, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_tau_phi, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_lep_pt, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_lep_eta, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_lep_phi, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_met, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_met_phi, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_met_sumet, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_jet_num, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_jet_leading_pt, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_jet_leading_eta, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_jet_leading_phi, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_jet_subleading_pt, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_jet_subleading_eta, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_jet_subleading_phi, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_jet_all_pt, 
      Weight, 
      col = Label, 
      data = training
)

qplot(PRI_tau_pt, 
      PRI_jet_all_pt, 
      col = Label, 
      data = training,
      geom = c("point", "smooth")
)

qplot(PRI_lep_pt, 
      PRI_tau_pt, 
      col = Label, 
      data = training
)





