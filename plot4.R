dataSet <- 'household_power_consumption.txt'

plot4Main <- function() {
  householdPower <- setup()
  
  #Setup for multiple plots
  par(mfrow = c(2,2))

  #Top Left Plot
  with(householdPower, plot(DateTime,Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power'))
  
  #Top Right Plot
  with(householdPower, plot(DateTime,Voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage'))
  
  #Bottom Left Plot
  with(householdPower, plot(DateTime,Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering'))
  with(householdPower, lines(DateTime, Sub_metering_2, col = 'Red'))
  with(householdPower, lines(DateTime, Sub_metering_3, col = 'Blue'))
  legend('topright', legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), lwd = 1, col = c('Black','Red','Blue'))
  
  #Bottom Right Plot
  with(householdPower, plot(DateTime,Global_reactive_power, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power'))
  
  #Save plot
  dev.print(png, width = 672,height = 672,filename = 'plot4.png')
  
  #Close window
  dev.off()
}

setup <- function() {
  
  library(data.table)
  library(lubridate)
  
  getDataSet()
  householdPower <- readDataSet()
  householdPower <- formatDataSet(householdPower)
  
  #Additional setup for dealing with RStudio quirks
  windows()
  par(bg = 'white')
  householdPower
}

getDataSet <- function() {
  if (file.exists(dataSet)) {
    return(NA)
  }
  
  zipURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  zipDest <- 'electricPowerConsumption.zip'
  
  download.file(zipURL,zipDest)
  dateDownloaded <- date()
  unzip(zipDest)
}

readDataSet <- function() {
  householdPower <- fread(dataSet, na.strings = '?')
  householdPower <- subset(householdPower, householdPower$Date == '1/2/2007' | householdPower$Date == '2/2/2007')
  householdPower$DateTime <- dmy_hms(paste(householdPower$Date, householdPower$Time))
  householdPower
}

formatDataSet <- function(householdPower) {
  householdPower$Global_active_power <- as.numeric(householdPower$Global_active_power)
  householdPower$Global_reactive_power <- as.numeric(householdPower$Global_reactive_power)
  householdPower$Voltage <- as.numeric(householdPower$Voltage)
  householdPower$Sub_metering_1 <- as.numeric(householdPower$Sub_metering_1)
  householdPower$Sub_metering_2 <- as.numeric(householdPower$Sub_metering_2)
  householdPower$Sub_metering_3 <- as.numeric(householdPower$Sub_metering_3)
  householdPower
}