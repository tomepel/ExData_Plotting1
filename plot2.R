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
# the Global_active_power over two days. We thus create a vector
# of 2 days = 48 hours =2880 minutes
time<-1:2880

# Convert into numeric the Global_active_power column
numeric_Global_active_power<-as.numeric(paste(household$Global_active_power))

# initiate the png window with the required size
png(filename = "plot2.png",width = 480, height = 480)

# Impose only one plot
par(mfrow=c(1,1))

# Plot the required graphic
plot(time,numeric_Global_active_power,type="l", xaxt='n',ann=FALSE,yaxt='n')

# Required gradation for the x axis
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))

# Required gradation for the y axis
axis(2, at=c(0,2,4,6), labels=c(0,2,4,6))

# Required label for the y axis
title(ylab="GLobal Active Power (kilowatts)")

# We finally close the png window
dev.off()