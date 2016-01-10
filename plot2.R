#Code downloads required files, annotates them and create the second plot figure as required by the assignment.

#Load dataset
colNames <- names(read.table("./household_power_consumption.txt", nrows = 1, header = TRUE, sep = ";"))
powr <- read.table("./household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, stringsAsFactors=FALSE, skip = grep("^[1,2]/2/2007", readLines("./household_power_consumption.txt"))-1, nrows = 2880)
names(powr) <- colNames
datedownloaded <- date()
datedownloaded

#Annotate data
powr$Global_active_power <- as.numeric(powr$Global_active_power)
powr$Date <- as.Date(powr$Date)
powr$Time <- strptime(powr$Time, format = "%H:%M:%S", tz = "")
na.omit(powr)

#Create Plot2
plot(powr$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l", xaxt = "n")
axis(1, at = c(1, 1500, 2900), labels = c("Tue", "Fri", "Sat"))

#Save Plot2 png
dev.copy(png, filename = "plot2.png", width=480, height=480)
dev.off()
