## Read in the text file and save it as a data frame.
list.files(getwd())
Data <- read.csv2("household_power_consumption.txt", header = TRUE)

## Create a column in matrix which combines date and time.
DateTime <- strptime(paste(Data$Date, Data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
Data <- cbind(Data, DateTime)

## Reformat the the Date and Time columns into the appropriate object classes.
Data$Date <- as.Date(Data$Date, format="%d/%m/%Y")
Data$Time <- format(Data$Time, format="%H:%M:%S")

## Reformat the three sub metering columns into numeric class.
Data$Sub_metering_1 <- as.numeric(Data$Sub_metering_1)
Data$Sub_metering_2 <- as.numeric(Data$Sub_metering_2)
Data$Sub_metering_3 <- as.numeric(Data$Sub_metering_3)

## Subset the dataframe based on the two required dates in February 2007.
FebPower <- subset(Data, subset=(Data$Date == "2007-02-01" | Data$Date == "2007-02-02"))

# ## Create a plot with Days on x axis and Energy on sub metering on the y axis. 
## Add in lines for each type of sub-metering and define colours for 2 & 3.
## Define the position of the legend box and how each item in the legend is coloured and labelled.

plot(FebPower$DateTime,FebPower$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(FebPower,lines(DateTime,(Sub_metering_1)))
with(FebPower,lines(DateTime,(Sub_metering_2),col="red"))
with(FebPower,lines(DateTime,(Sub_metering_3),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Print plot to the graphic device and then turn off graphics device. 

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()