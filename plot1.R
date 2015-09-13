# load file. keep variable name short for easier reference 
y <- read.csv("household_power_consumption.txt", header=TRUE, sep=";",
                                        colClasses = c("character","character","character","character","character","character","character","character","character"))
# convert Date and Time
y$DateTime <- paste(y$Date, y$Time, sep=" ")
y$DateTime <- strptime(y$DateTime, "%d/%m/%Y %H:%M:%S")
y$Date <- as.Date(y$Date, "%d/%m/%Y")

# select data in the date range 2/1/2007 to 2/2/2007
x <- y[y$Date >= "2007-02-01" & y$Date <= "2007-02-02", ]

# plot 1
plot.new()
hist(as.numeric(x$Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", xlim=c(0,6), ylim=c(0,1200))
dev.copy(png,"plot1.png", width=480, height=480, units="px")
dev.off()
