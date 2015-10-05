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


#plot 1
#convert the required variable 
#plot the graph as per project instruction
h <- as.numeric(as.character(data$Global_active_power))
plot(weekDays, h, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

#save the plot as a png file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
