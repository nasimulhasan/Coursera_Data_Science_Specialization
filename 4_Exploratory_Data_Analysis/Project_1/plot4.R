#stepup directory
setwd("F:/Data Science/4. Exploratory Data Analysis/Week1/Project1")
getwd()

#load the file, extract the required data and check 
#the dimension
file <- read.table("data.txt", sep=";", header=TRUE)
data <- subset(file, as.Date(file$Date, format="%d/%m/%Y") %in% as.Date(c("2007-02-01", "2007-02-02"), format="%Y-%m-%d"))
dim(data)

#concatenate Date and Time
#convert to POSIXlt
weekDays <- strptime(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S')

#convert the required variable
m1 <- as.numeric(as.character(data$Sub_metering_1))
m2 <- as.numeric(as.character(data$Sub_metering_2))
m3 <- as.numeric(as.character(data$Sub_metering_3))

#drawing multiple plot per page
n.col <- 2
n.row <- 2
par(mfrow = c(n.col, n.row))

#upper left plot
#convert the required variable 
#plot the histogram as per project instruction
h <- as.numeric(as.character(data$Global_active_power))
plot(weekDays, h, type = "l", xlab = "", ylab = "Global Active Power")

#upper right plot
v <- as.numeric(as.character(data$Voltage))
plot(weekDays, v, type = "l", xlab = "datetime", ylab = "Voltage")

#lower left plot
#plot the graph as per instruction
plot(weekDays, m1, ylim = c(1, 38), type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
par(new = T)

plot(weekDays, m2, ylim = c(1, 38), type = "l", xlab = "", ylab = "", col = "red", axes = F)
par(new = T)

plot(weekDays, m3, ylim = c(1, 38), type = "l", xlab = "", ylab = "", col = "blue", axes = F)
par(new = F)

legend("topright", cex = .6, bty = "n", lty = 1, col=c("black", "red", "blue"), legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"))

#lower right plot
r <- as.numeric(as.character(data$Global_reactive_power))
plot(weekDays, r, type = "n", xlab = "datetime", ylab = "Global_reactive_power")

#save the plot as a png file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

