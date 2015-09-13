# clean up 
rm(list=ls())

#load file. keep variable name short for easier reference 
y <- read.csv("household_power_consumption.txt", header=TRUE, sep=";",
              colClasses = c("character","character","character","character","character","character","character","character","character"))
# convert Date and Time
y$DateTime <- paste(y$Date, y$Time, sep=" ")
y$DateTime <- strptime(y$DateTime, "%d/%m/%Y %H:%M:%S")
y$Date <- as.Date(y$Date, "%d/%m/%Y")

# select data in the date range 2/1/2007 to 2/2/2007
x <- y[y$Date >= "2007-02-01" & y$Date <= "2007-02-02", ]

# convert columns to numeric for plotting
x$Global_active_power <- as.numeric(x$Global_active_power)
x$Voltage <- as.numeric(x$Voltage)
x$Sub_metering_1 <- as.numeric(x$Sub_metering_1)
x$Sub_metering_2 <- as.numeric(x$Sub_metering_2)
x$Sub_metering_3 <- as.numeric(x$Sub_metering_3)
x$Global_reactive_power <- as.numeric(x$Global_reactive_power)

#plot 4
plot.new()
par(mfrow=c(2,2))
# (1,1)
plot(x$DateTime, x$Global_active_power, "l", xlab = "", ylab="Global Active Power (kilowatts)")
# (1,2)
plot(x$DateTime, x$Voltage, "l", xlab = "datetime", ylab="Voltage")
# (2,1)
plot(x$DateTime, x$Sub_metering_1, "l", xlab="", ylab="Energy sub metering")
lines(x$DateTime, x$Sub_metering_2, col="red")
lines(x$DateTime, x$Sub_metering_3, col="blue")
leg.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", bty="n", leg.txt, lwd=c(2.5,2.5,2.5), col=c("black", "red", "blue"), cex=0.6)
# (2,2)
plot(x$DateTime, x$Global_reactive_power, "l", xlab = "datetime", ylab="Global Reactive Power")
dev.copy(png,"plot4.png", width=480, height=480, units="px")
par(mfrow=c(1,1))
dev.off()

