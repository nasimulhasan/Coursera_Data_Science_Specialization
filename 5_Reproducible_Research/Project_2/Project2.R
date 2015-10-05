# setup directory
setwd("F:/Data Science/5. Reproducible Research/Week3/Project2")
getwd()


data <- read.csv("StormData.csv", quote = '')
dim(data)
names(data)
head(data)

unique(data$X.EVTYPE.)

f <- factor(data[, 8])
unique(f)

event <- data[, 8]
fatalities <- data[, 23]
injuries <- data[, 24]

#====================================
event <- data[, 8]
propertyDamage <- data[, 25]
propertyDamageExp <- data[, 26]
cropDamage <- data[, 27]
cropDamageExp <- data[, 28]

event <- as.character(event)
propertyDamage <- as.numeric(as.character(propertyDamage, na.rm = T))
propertyDamageExp <- as.numeric(as.character(propertyDamageExp))
cropDamage <- as.numeric(as.character(cropDamage, na.rm =T))
cropDamageExp <- as.numeric(as.character(cropDamageExp))

dfPC <- data.frame(event, propertyDamage, propertyDamageExp, cropDamage, cropDamageExp)
dim(dfPC)

dfPC <- dfPC[dfPC$propertyDamage > 0, ]
dfPC <- dfPC[dfPC$cropDamage > 0, ]

totalPropertyDamage <- tapply(as.numeric(dfPC$propertyDamage), as.character(dfPC$event), sum, na.rm = T)
dim(totalPropertyDamage)

totalPropertyDamage <- sort(totalPropertyDamage, decreasing=T)

totalCropDamage <- tapply(as.numeric(dfPC$cropDamage), as.character(dfPC$event), sum, na.rm = T)
dim(totalCropDamage)

totalCropDamage <- sort(totalCropDamage, decreasing=T)

economicConsequences <- data.frame(totalPropertyDamage, totalCropDamage)
#==========================================
event <- as.character(event)
fatalities <- as.numeric(as.character(fatalities, na.rm = T))
injuries <- as.numeric(as.character(injuries, na.rm = T))

dfEFI <- data.frame(event, fatalities, injuries)
dfEFI <- dfEFI[dfEFI$injuries > 0, ]
dfEFI <- dfEFI[dfEFI$fatalities > 0, ]
dim(dfEFI)

head(dfEFI)
tail(dfEFI)
testSet <- dfEFI[30000:30060, ]
summary(dfEFI)

# sum of injuries grouped by event
totalInjuries <- tapply(as.numeric(dfEFI$injuries), as.character(dfEFI$event), sum, na.rm = T)

dim(totalInjuries)
head(totalInjuries)

# most harmful with respect to population health
harmfulEvent <- sort(totalInjuries, decreasing=T)

totalFatalities <- tapply(as.numeric(dfEFI$injuries), as.character(dfEFI$fatalities), sum, na.rm = T)
dim(totalFatalities)
totalFatalities


