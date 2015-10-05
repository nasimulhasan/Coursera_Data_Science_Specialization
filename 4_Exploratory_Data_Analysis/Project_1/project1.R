#setup directory
setwd("F:/Data Science/4. Exploratory Data Analysis/Week1/Project1")
getwd()

file <- read.table("data.txt", sep=";", header=TRUE)
data <- subset(file, as.Date(file$Date, format="%d/%m/%Y") %in% as.Date(c("2007-02-01", "2007-02-02"), format="%Y-%m-%d"))
dim(data)

#plot 1
h <- as.numeric(as.character(data$Global_active_power))
hist(h, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

hV <- as.numeric(as.character(data$Global_active_power))

weekDays <- strptime(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S')
plot(weekDays, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

