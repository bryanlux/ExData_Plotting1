#load file. keep variable name short for easier reference  
y <- read.csv("household_power_consumption.txt", header=TRUE, sep=";",
              colClasses = c("character","character","character","character","character","character","character","character","character"))
# convert Date and Time
y$DateTime <- paste(y$Date, y$Time, sep=" ")
y$DateTime <- strptime(y$DateTime, "%d/%m/%Y %H:%M:%S")
y$Date <- as.Date(y$Date, "%d/%m/%Y")

# select data in the date range 2/1/2007 to 2/2/2007
x <- y[y$Date >= "2007-02-01" & y$Date <= "2007-02-02", ]

#plot 3
plot.new()
plot(x$DateTime, as.numeric(x$Sub_metering_1), "l", xlab="", ylab="Energy sub metering")
lines(x$DateTime, as.numeric(x$Sub_metering_2), col="red")
lines(x$DateTime, as.numeric(x$Sub_metering_3), col="blue")
leg.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", leg.txt, lwd=c(2.5,2.5,2.5), col=c("black", "red", "blue"))
dev.copy(png,"plot3.png", width=480, height=480, units="px")
dev.off()
