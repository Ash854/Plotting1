## Read in the text file and save it as a data frame.
list.files(getwd())
PowerData <- read.csv2("household_power_consumption.txt", header = TRUE)

## Create a column in matrix which combines date and time.
DateTime <- strptime(paste(PowerData$Date, PowerData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
Data <- cbind(PowerData, DateTime)

## Reformat the the Date and Time columns into the appropriate object classes.
Data$Date <- as.Date(Data$Date, format="%d/%m/%Y")
Data$Time <- format(Data$Time, format="%H:%M:%S")

## Reformat the Global Active Power column data into numeric class.
Data$Global_active_power <- as.numeric(Data$Global_active_power)

## Subset the dataframe based on the two required dates in February 2007.
FebPower <- subset(Data, subset=(Data$Date == "2007-02-01" | Data$Date == "2007-02-02"))

## Create a plot with Days on x axis and Global Active power on the y axis.

with(FebPower, plot(DateTime, Global_active_power, type="l", xlab=" ", ylab="Global Active Power (kilowatts)"))

## Print plot to the graphic device and then turn off graphics device. 

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()