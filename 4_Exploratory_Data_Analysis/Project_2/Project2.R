# setup directory
setwd("F:/Data Science/4. Exploratory Data Analysis/Week3/Project2")
getwd()

#load the datasets
file <- readRDS("Source_Classification_Code.rds")
sFile <- readRDS("summarySCC_PM25.rds")
# Basic analysis
dim(file)
colnames(file)
head(file)
str(file)

dim(sFile)
colnames(sFile)
sFile[1:50, ]

# plot 1
total <- tapply(sFile$Emissions, sFile$year, sum, na.rm = TRUE)
total
plot(total)
