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

# Draw Plot 2 using R Basic Plotting System
plot(rawdatasubset$datetime, as.numeric(rawdatasubset$Global_active_power), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
# Copy plot to a PNG file
dev.copy(png, file = "plot2.png") 
# Close the PNG device!
dev.off() 

