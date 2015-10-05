#stepup directory
setwd("F:/Data Science/4. Exploratory Data Analysis/Week1/Project1")
getwd()

#load the file, extract the required data and check 
#the dimension
file <- read.table("data.txt", sep=";", header=TRUE)
data <- subset(file, as.Date(file$Date, format="%d/%m/%Y") %in% as.Date(c("2007-02-01", "2007-02-02"), format="%Y-%m-%d"))
dim(data)


#convert the required variable
m1 <- as.numeric(as.character(data$Sub_metering_1))
m2 <- as.numeric(as.character(data$Sub_metering_2))
m3 <- as.numeric(as.character(data$Sub_metering_3))

#concatenate Date and Time
#convert to POSIXlt
weekDays <- strptime(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S')

#plot 3
#plot the graph as per instruction
plot(weekDays, m1, ylim = c(1, 38), type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
par(new = T)

plot(weekDays, m2, ylim = c(1, 38), type = "l", xlab = "", ylab = "", col = "red", axes = F)
par(new = T)

plot(weekDays, m3, ylim = c(1, 38), type = "l", xlab = "", ylab = "", col = "blue", axes = F)
par(new = F)

legend("topright", lty = 1, col=c("black", "red", "blue"), legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"))

#save the plot as a png file
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()

