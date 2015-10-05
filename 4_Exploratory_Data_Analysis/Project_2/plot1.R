# setup directory
setwd("F:/Data Science/4. Exploratory Data Analysis/Week3/Project2")
getwd()

#load the datasets
file <- readRDS("Source_Classification_Code.rds")
sFile <- readRDS("summarySCC_PM25.rds")

dim(sFile)
colnames(sFile)

# compute the total of each year
total <- tapply(sFile$Emissions, sFile$year, sum, na.rm = TRUE)
total

#plot 1
totalEmissions <- as.numeric(as.character(total))
years <- as.numeric(as.character(unique(sFile$year)))
plot(years, totalEmissions, col = "red", pch = 16, type = "b", lwd = 2, 
     xlab = "Years",
     ylab = "The total PM2.5 emission per year", 
     main = "PM2.5 emission of all sources")

#save the plot as a png file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

