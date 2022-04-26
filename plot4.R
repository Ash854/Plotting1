## Read in the text file and save it as a data frame.
list.files(getwd())
Data <- read.csv2("household_power_consumption.txt", header = TRUE)

## Create a column in matrix which combines date and time.
DateTime <- strptime(paste(Data$Date, Data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
Data <- cbind(Data, DateTime)

## Reformat the the Date and Time columns into the appropriate object classes.
Data$Date <- as.Date(Data$Date, format="%d/%m/%Y")
Data$Time <- format(Data$Time, format="%H:%M:%S")

## Reformat the four y-axis variable columns into numeric class.
Data$Global_active_power <- as.numeric(Data$Global_active_power)
Data$Voltage <- as.numeric(Data$Voltage)
Data$Sub_metering_1 <- as.numeric(Data$Sub_metering_1)
Data$Sub_metering_2 <- as.numeric(Data$Sub_metering_2)
Data$Sub_metering_3 <- as.numeric(Data$Sub_metering_3)
Data$Global_reactive_power <- as.numeric(Data$Global_reactive_power)


## Subset the dataframe based on the two required dates in February 2007.
FebPower <- subset(Data, subset=(Data$Date == "2007-02-01" | Data$Date == "2007-02-02"))

## Create a plot with 2 rows and 2 columns.
par(mfrow = c(2,2))

##  Plot the four graphs.
with(FebPower, {
  plot(FebPower$DateTime,FebPower$Global_active_power,type="l",xlab="",ylab="Global Active Power")
  plot(FebPower$DateTime,FebPower$Voltage,type="l",xlab="datetime",ylab="Voltage")
  plot(FebPower$DateTime,FebPower$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(FebPower,lines(DateTime,(Sub_metering_1)))
  with(FebPower,lines(DateTime,(Sub_metering_2),col="red"))
  with(FebPower,lines(DateTime,(Sub_metering_3),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(FebPower$DateTime,FebPower$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
  })

## Print the four multiple plots to the graphic device and then turn off graphics device. 

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
