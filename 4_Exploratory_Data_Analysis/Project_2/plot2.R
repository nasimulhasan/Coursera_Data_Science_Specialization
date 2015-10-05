# setup directory
setwd("F:/Data Science/4. Exploratory Data Analysis/Week3/Project2")
getwd()

#load the datasets
file <- readRDS("Source_Classification_Code.rds")
sFile <- readRDS("summarySCC_PM25.rds")

dim(sFile)
colnames(sFile)

# compute the total emissions of each year of Baltimore city
baltimoreCity <- sFile[sFile$fips == "24510", ]
dim(baltimoreCity)

total <- tapply(baltimoreCity$Emissions, baltimoreCity$year, sum, na.rm = TRUE)
total

#plot 2
totalEmissions <- as.numeric(as.character(total))
years <- as.numeric(as.character(unique(baltimoreCity$year)))

plot(years, totalEmissions, col = "blue", pch = 16, type = "b", lwd = 2,
     xlab = "Years",
     ylab = "The total PM2.5 emission per year", 
     main = "PM2.5 emission in the Baltimore City, Maryland"
     )


#save the plot as a png file
dev.copy(png, file = "plot.png", width = 480, height = 480)
dev.off()

