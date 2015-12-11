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
# several quantities of the  household dataframe over two days.
# We thus create a vector of 2 days = 48 hours =2880 minutes
time<-1:2880

# Convert into numeric the Global_active_power column for the top left plot
numeric_Global_active_power<-as.numeric(paste(household$Global_active_power))

# Convert into numeric the Voltage column for the top right plot
Voltage<-as.numeric(paste(household$Voltage))

# Convert into numeric the 3 Energy_Sub_metering for the bottom left plot
Energy_Sub_metering_1<-as.numeric(paste(household$Sub_metering_1))
Energy_Sub_metering_2<-as.numeric(paste(household$Sub_metering_2))
Energy_Sub_metering_3<-as.numeric(paste(household$Sub_metering_3))

# Convert into numeric the Global_reactive_power column for the bottom right plot
numeric_Global_reactive_power<-as.numeric(paste(household$Global_reactive_power))

# initiate the png window with the required size
png(filename = "plot4.png",width = 480, height = 480)

# Impose four plots arranged as a 2X2 matrix
par(mfrow=c(2,2))

### TOP LEFT PLOT ###
# this is just the same as our plot 2
plot(time,numeric_Global_active_power,type="l", xaxt='n',ann=FALSE,yaxt='n')
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))
axis(2, at=c(0,2,4,6), labels=c(0,2,4,6))
title(ylab="GLobal Active Power",cex.lab=0.7)

### TOP RIGHT PLOT ###
# this is very similar to our plot 2 for a different quantity:
# VOLTAGE
plot(time,Voltage,type="l", xaxt='n',ann=FALSE,yaxt='n')
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))
axis(2, at=c(234,238,242,246), labels=c(234,238,242,246))
title(ylab="Voltage",cex.lab=0.7)
title(xlab="Datetime",cex.lab=0.7)

### BOTTOM LEFT PLOT ###
# this is just the same as our plot 3
plot(time,Energy_Sub_metering_1,type="l", xaxt='n',ann=FALSE,yaxt='n')
lines(time,Energy_Sub_metering_2,type="l", xaxt='n',ann=FALSE,yaxt='n',col="red")
lines(time,Energy_Sub_metering_3,type="l", xaxt='n',ann=FALSE,yaxt='n',col="blue")
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))
axis(2, at=c(0,10,20,30), labels=c(0,10,20,30))
title(ylab="Energy sub metering",cex.lab=0.7)
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","blue","red"),cex=0.7)

### BOTTOM RIGHT PLOT ###
# this is very similar to our plot 2 for a different quantity:
# Global_reactive_power
plot(time,numeric_Global_reactive_power,type="l", xaxt='n',ann=FALSE,yaxt='n')
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))
title(xlab="Datetime",cex.lab=0.7)
axis(2, at=seq(0,0.5,by=0.1), labels=seq(0,0.5,by=0.1),cex.axis=0.7)
title(ylab="GLobal-reactive_power",cex.lab=0.7)

# We finally close the png window
dev.off()