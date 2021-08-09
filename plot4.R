# Exploratory Data Analysis Course Project 1 - Plot 2

# Load data from UCI ML Repository
if (!file.exists('data')) {dir.create('data')}
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              './data/data.zip', mode = "wb")
unzip('./data/data.zip', exdir = 'data')
library(readr)
data <- read.table('./data/household_power_consumption.txt', 
                   header = TRUE,
                   sep=";")

# Format numeric, date and time variables
data$DateTime <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y" )
data[,3:9] <- sapply(data[,3:9], as.numeric)

# Subset data to 2007-02-01 and 2007-02-02
data <- subset(data, Date == "2007-02-02" | Date == "2007-02-01")

# Initiate device
png("plot4.png", width = 480, height = 480)

# Set layout
par(mfrow= c(2,2), mar = c(4,4,2,2), oma = c(1,1,1,1))

plot(data$DateTime, data$Global_active_power, ylab="Global Active Power", xlab = "", type = "n")
lines(data$DateTime, data$Global_active_power, col = "black")

plot(data$DateTime, data$Voltage, ylab="Voltage", xlab = "datetime", type = "n")
lines(data$DateTime, data$Voltage, col = "black")

plot(data$DateTime, data$Sub_metering_1, ylab="Energy sub metering", xlab = "", type = "n")
lines(data$DateTime, data$Sub_metering_1, col = "black")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", col = c("black","red","blue"), lty = c(1,1,1), c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.75, bty = "n")

plot(data$DateTime, data$Global_reactive_power, ylab="Global Reactive Power", xlab = "datetime", type = "n")
lines(data$DateTime, data$Global_reactive_power, col = "black")

# Close device
dev.off()
