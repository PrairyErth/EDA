#Code downloads required files, annotates them and create the third plot figure as required by the assignment.
library(ggplot2)

#Load data set
colNames <- names(read.table("./household_power_consumption.txt", nrows = 1, header = TRUE, sep = ";"))
powr <- read.table("./household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, stringsAsFactors=FALSE, skip = grep("^[1,2]/2/2007", readLines("./household_power_consumption.txt"))-1, nrows = 2880)
names(powr) <- colNames
datedownloaded <- date()
datedownloaded

#Annotate data
y1 <- as.numeric(powr$Sub_metering_1)
y2 <- as.numeric(powr$Sub_metering_2)
y3 <- as.numeric(powr$Sub_metering_3)
powr$Date <- as.Date(powr$Date)
powr$Time <- strptime(powr$Time, format = "%H:%M:%S", tz = "")
na.omit(powr)

#Create Plot3
with(powr, plot(y1, xlab = "", ylab = "Energy sub metering", xaxt = "n", type = "l", col = "grey"))
lines(y2, type = "l", col = "red")
lines(y3, type = "l", col = "blue")
axis(1, at = c(1, 1500, 2900), labels = c("Tue", "Fri", "Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), bty = "n", lwd = c(1.5,1.5,1.5), col = c("black","blue","red"))

#Save Plot3 png
dev.copy(png, filename="plot3.png", width=480, height=480)
dev.off()
