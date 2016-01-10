#Code downloads data, annotates and displays plots as required by assignment
library(data.table)
library(dplyr)
library(lubridate)

#Load dataset
colNames <- names(read.table("./household_power_consumption.txt", nrows = 1, header = TRUE, sep = ";"))
powr <- read.table("./household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, stringsAsFactors=FALSE, skip = grep("^[1,2]/2/2007", readLines("./household_power_consumption.txt"))-1, nrows = 2880)
names(powr) <- colNames
datedownloaded <- date()
datedownloaded
na.omit(powr)

#Set up device
par(mfrow=c(2, 2))

#Plot1of4
plot(powr$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l", xaxt = "n")
axis(1, at = c(1, 1500, 2900), labels = c("Tue", "Fri", "Sat"))

#Plot2of4
as.numeric(powr$Voltage)
plot(powr$Voltage, xlab = "datetime", ylab = "Voltage", type = "l", xaxt = "n")
axis(1, at = c(1, 1500, 2900), labels = c("Tue", "Fri", "Sat"))

#Plot3of4
y1 <- as.numeric(powr$Sub_metering_1)
y2 <- as.numeric(powr$Sub_metering_2)
y3 <- as.numeric(powr$Sub_metering_3)
powr$Date <- as.Date(powr$Date)
powr$Time <- strptime(powr$Time, format = "%H:%M:%S", tz = "")
na.omit(powr)
with(powr, plot(y1, xlab = "", ylab = "Energy sub metering", xaxt = "n", type = "l", col = "grey"))
lines(y2, type = "l", col = "red")
lines(y3, type = "l", col = "blue")
axis(1, at = c(1, 1500, 2900), labels = c("Tue", "Fri", "Sat"))
par(new=FALSE)
legend(1500, 43, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), bty = "n", lwd = c(1.5,1.5,1.5), col = c("black","blue","red"))

#Plot4of4
powr["datetime"] <- paste(powr$Date, powr$Time)
mutate(powr$datetime = dmy_hms(paste(powr$Date, powr$Time)))
mutate(powr$Date = dmy(powr$Date))
plot(powr$datetime, powr$Global_active_power, xlab = "datetime", ylab = "Global_Active_Power", type = "l", xaxt = "n")
axis(1, at = c(1, 1500, 2900), labels = c("Tue", "Fri", "Sat"))

#Save Plot4 png
dev.copy(png, filename="plot4.png", width = 480, height = 480)
dev.off()
