setwd("C:/coursera/JHU/household_power_consumption/")

hpc<-read.table("household_power_consumption.txt", sep=";", header=TRUE)

goodData<-is.na(hpc[,3])
hpcGood<-hpc[!goodData,]

dateB<-hpcGood$Date == "2/1/2007" | hpcGood$Date == "2/2/2007"
hpcDate <- hpc[dateB,]
FullDateTime<-strptime(paste0(hpcDate$Date," ",hpcDate$Time), format="%m/%d/%Y %H:%M:%S")


#1
pdf("plot1.png")
hist(as.numeric(hpcDate$Global_active_power)/1000, breaks=10,main="Global Active Power",xlab="Global Active Power (kilowatts)" )
dev.copy(png,'plot1.png')
dev.off();


#2
pdf("plot2.png")
plot(strptime(paste0(hpcDate$Date," ",hpcDate$Time), format="%m/%d/%Y %H:%M:%S"), as.numeric(hpcDate$Global_active_power), type="l" ,ylab="Global Active Power (kilowatts)",xlab="")
dev.copy(png,'plot2.png')
dev.off();


#3
pdf("plot3.png")
with(hpcDate, plot(FullDateTime,Sub_metering_3,type="l",col="blue",xlab="",ylab="Energy sub metering") )
with(hpcDate, points(FullDateTime,Sub_metering_1,type="p",col="black"),xlab="",label="Sub_metering_1" )
with(hpcDate, points(FullDateTime,Sub_metering_2,type="l",col="red"),xlab="" )
dev.copy(png,'plot3.png')
dev.off();

#Multiple plots
pdf("plot4.png")
par(mfrow = c(2,2))
with(hpcDate,{
	plot(strptime(paste0(hpcDate$Date," ",hpcDate$Time), format="%m/%d/%Y %H:%M:%S"), as.numeric(hpcDate$Global_active_power), type="l",ylab="Global Active Power",xlab="" )
	plot(strptime(paste0(hpcDate$Date," ",hpcDate$Time), format="%m/%d/%Y %H:%M:%S"), as.numeric(hpcDate$Voltage), type="l" ,ylab="Voltage",xlab="")

	plot(FullDateTime,Sub_metering_3,type="l",col="blue",ylab="Energy sub metering",xlab="")
	points(FullDateTime,Sub_metering_1,type="p",col="black")
	points(FullDateTime,Sub_metering_2,type="l",col="red")

	plot(strptime(paste0(hpcDate$Date," ",hpcDate$Time), format="%m/%d/%Y %H:%M:%S"), as.numeric(hpcDate$Global_reactive_power), type="l",ylab="Global_reactive_power",xlab="" )
})
dev.copy(png,'plot4.png')

