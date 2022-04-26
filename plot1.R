## Read in the text file and save it as a data frame.

list.files(getwd())
powerdata <- read.csv2("household_power_consumption.txt", header = TRUE)

## Reformat the the Date and Time columns into the appropriate object classes.
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
powerdata$Time <- strptime(powerdata$Time, "%H:%M:%S")

## Subset the dataframe based on the two required dates in February 2007.
febpower <- subset(powerdata, subset=(powerdata$Date >= "2007-02-01" & powerdata$Date <= "2007-02-02"))

## Reformat the Global Active Power column data into numeric class.
febpower$Global_active_power <- as.numeric(febpower$Global_active_power)

## Create the histogram and format as per plot example title, axis labels and colour.

hist(febpower$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Print to the graphic device and then turn off graphics device. 

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()