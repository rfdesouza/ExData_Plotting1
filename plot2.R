dataSet <- 'household_power_consumption.txt'

plot2Main <- function() {
  householdPower <- setup()
  
  #Plot2
  with(householdPower, plot(DateTime,Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)'))
  
  #Save plot
  dev.print(png, width = 480,height = 480,filename = 'plot2.png')
  
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