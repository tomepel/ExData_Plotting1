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

# Convert into numeric the Global_active_power column
numeric_Global_active_power<-as.numeric(paste(household$Global_active_power))

# initiate the png window with the required size
png(filename = "plot1.png",width = 480, height = 480)

# Impose only one plot
par(mfrow=c(1,1))

# plot the required histogram, correct labels
hist(numeric_Global_active_power,xlab="GLobal Active Power (kilowatts)",
     ylab = "Frequency",main="Global Active Power",
     col="red",ylim=c(0,1200),xaxt='n')
# Required gradation for the x axis
axis(1, at=c(0,2,4,6), labels=c(0,2,4,6))

# We finally close the png window
dev.off()