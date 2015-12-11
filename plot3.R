# Read the full household_power_consumption.txt file
# this might take some time
household<-read.table("household_power_consumption.txt",sep=";",header=TRUE)

# Convert the date column 
household$Date<- as.Date( household$Date,"%d/%m/%Y")

# Select the years, motnhs and days out of the dates
year<-format(as.Date( household$Date,"%d/%m/%Y"),"%Y")
month<-format(as.Date( household$Date,"%d/%m/%Y"),"%m")
day<-format(as.Date( household$Date,"%d/%m/%Y"),"%d")

# Filter the data to keep only 2007-02-01 and 2007-02-02
household<-household[year=="2007"&month=="02"&(day=="01"|day=="02"),]

# for this plot we need to follow the minute by minute 
# the 3 Energy_Sub_metering over two days. We thus create a vector
# of 2 days = 48 hours =2880 minutes
time<-1:2880

# Convert into numeric the 3 Energy_Sub_metering
Energy_Sub_metering_1<-as.numeric(paste(household$Sub_metering_1))
Energy_Sub_metering_2<-as.numeric(paste(household$Sub_metering_2))
Energy_Sub_metering_3<-as.numeric(paste(household$Sub_metering_3))

# initiate the png window with the required size
png(filename = "plot3.png",width = 480, height = 480)

# Impose only one plot
par(mfrow=c(1,1))

# Plot the first line of the required graphic
plot(time,Energy_Sub_metering_1,type="l", xaxt='n',ann=FALSE,yaxt='n')

# Plot the second line of the required graphic
lines(time,Energy_Sub_metering_2,type="l", xaxt='n',ann=FALSE,yaxt='n',col="red")

# Plot the third line of the required graphic
lines(time,Energy_Sub_metering_3,type="l", xaxt='n',ann=FALSE,yaxt='n',col="blue")

# Required gradation for the x axis
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))

# Required gradation for the y axis
axis(2, at=c(0,10,20,30), labels=c(0,10,20,30))

# Required label for the y axis
title(ylab="Energy sub metering")

# Required legend for the graphic
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","blue","red"))

# We finally close the png window
dev.off()