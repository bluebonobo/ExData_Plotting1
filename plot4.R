# TO run this file, Set working directory to folder where R file and source data file are located

# Read the file
rawdata<-read.csv("./household_power_consumption.txt", header=TRUE, sep = ";", stringsAsFactors=FALSE)
dim_rawdata <- dim(rawdata) 

# Add a new datetime column
colx <- paste(rawdata$Date, rawdata$Time)
datetime<-strptime(colx, "%d/%m/%Y %H:%M:%S")
rawdata_withdatetime <- cbind(rawdata,datetime)

# Subset data set for dates between 2007/02/01 and 2007/02/03
start_datetime <- as.POSIXlt("2007/02/01 00:00:00")
end_datetime <- as.POSIXlt("2007/02/03 00:00:00")
rawdatasubset <- subset(rawdata_withdatetime, rawdata_withdatetime$datetime>=start_datetime & rawdata_withdatetime$datetime<end_datetime)


# Open PNG graphic device
png('plot4.png')

# Draw Plot 4 using R Basic Plotting System
# note that legend param bty="n". This is to remove legend border in Sub_metering plot
par(mfrow=c(2,2))
with(rawdatasubset, {
  plot(rawdatasubset$datetime, as.numeric(rawdatasubset$Global_active_power), type = "l", xlab = "", ylab = "Global Active Power")
  plot(rawdatasubset$datetime, as.numeric(rawdatasubset$Voltage), type = "l", xlab = "datetime", ylab = "Voltage")
  plot(rawdatasubset$datetime, as.numeric(rawdatasubset$Sub_metering_1), xlab="", ylab="Energy sub metering", type="l")
  lines(rawdatasubset$datetime, as.numeric(rawdatasubset$Sub_metering_2), col="red")
  lines(rawdatasubset$datetime, as.numeric(rawdatasubset$Sub_metering_3), col="blue")
  legend("topright", lwd=1, bty="n", col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(rawdatasubset$datetime, as.numeric(rawdatasubset$Global_reactive_power), type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})

# Close the PNG device
dev.off() 

