# setup directory
setwd("F:/Data Science/4. Exploratory Data Analysis/Week3/Project2")
getwd()

#load the datasets
file <- readRDS("Source_Classification_Code.rds")
sFile <- readRDS("summarySCC_PM25.rds")

colnames(file)
dim(file)

dim(sFile)
colnames(sFile)
unique(sFile$type)

# extract the SCC data from file dataset
motorVehicle <- file[grepl("Vehicles",file$EI.Sector),]$SCC
head(motorVehicle)
motorVehicle

#extract Baltimore city, Maryland data
baltimoreCity <- sFile[sFile$fips == "24510", ]
dim(baltimoreCity)

#extract Los Angeles County, California data
LACounty <- sFile[sFile$fips == "06037", ]
dim(LACounty)

#subset baltimoreCity data set based on motorVehicle
subset <- baltimoreCity[baltimoreCity$SCC %in% motorVehicle, ]
dim(subset)

#group the data based on year
group <- tapply(baltimoreCity$Emissions, baltimoreCity$year, sum, na.rm = T)
group

#from the grouped data
totalEmissions <- c(3274.180, 2453.916, 3091.354, 1862.282)
year <- c(1999, 2002, 2005,2008)

#create data frame
baltimoreDF <- data.frame(totalEmissions, year)
baltimoreDF

#subset Los Angeles County, California data set based on motorVehicle
subsetLA <- LACounty[LACounty$SCC %in% motorVehicle, ]
dim(subsetLA)

#group the data based on year
groupLA <- tapply(LACounty$Emissions, LACounty$year, sum, na.rm = T)
groupLA

#from the grouped data
totalEmissionsLA <- c(47103.19, 26968.79, 22939.78, 32135.48)
year <- c(1999, 2002, 2005,2008)

#create data frame
LA_DF <- data.frame(totalEmissionsLA, year)
LA_DF

#compare the data frames
baltimoreDF
LA_DF

#plot the data frames on a single plotting window
par(mfrow = c(1, 2))

#baltimore city plot
plot(totalEmissions ~ year, data = baltimoreDF, type = "b", col = "green", lwd = 3, pch = 16, 
     main = "Emissions in Baltimore City",
     xlab = "Years",
     ylab = "Total Emissions from motor vehicle srcs / year")

# Los Angeles County plot
plot(totalEmissionsLA ~ year, data = LA_DF, type = "b", col = "red", lwd = 3, pch = 16, 
     main = "Emissions in Los Angeles",
     xlab = "Years",
     ylab = "Total Emissions from motor vehicle srcs / year")

#save the plot as a png file
dev.copy(png, file = "plot6.png", width = 700, height = 520)
dev.off()

