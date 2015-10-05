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
DF <- data.frame(totalEmissions, year)
DF

#plot the group data
plot(totalEmissions ~ year, data = DF, type = "b", col = "pink", lwd = 2, pch = 16, 
     main = "Emissions from motor vehicle sources in Baltimore City",
     xlab = "Years",
     ylab = "Total Emission per year")

#save the plot as a png file
dev.copy(png, file = "plot5.png", width = 550, height = 480)
dev.off()
