#Code downloads required file, annotates them and creates plot 1 of assignment.

#Load dataset
powr <- read.csv("./household_power_consumption.txt", sep=";", skip = "?", stringsAsFactors=FALSE)
datedownloaded <- date()
datedownloaded

#Annotate data
powr2 <- powr[66637:69516,] ##Only need rows 2007-02-01 and 2007-02-02

#Create Plot1
hist(as.numeric(powr2$Global_active_power), xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")

#Save Plot1 png
dev.copy(png, filename="plot1.png", width=480, height=480)
dev.off()
