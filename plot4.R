setwd("C:/coursera/JHU/household_power_consumption/")

hpc<-read.table("household_power_consumption.txt", sep=";", header=TRUE)

goodData<-is.na(hpc[,3])
hpcGood<-hpc[!goodData,]

dateB<-hpcGood$Date == "2/1/2007" | hpcGood$Date == "2/2/2007"
hpcDate <- hpc[dateB,]

#1
pdf("plot1.png")
hist(as.numeric(hpcDate$Global_active_power)/1000, breaks=10)
dev.copy(png,'plot1.png')
dev.off();


#2
pdf("plot2.png")
plot(strptime(paste0(hpcDate$Date," ",hpcDate$Time), format="%m/%d/%Y %H:%M:%S"), as.numeric(hpcDate$Global_active_power), type="l" )
dev.copy(png,'plot2.png')
dev.off();


#3
pdf("plot3.png")
with(hpcDate, plot(FullDateTime,Sub_metering_3,type="l",col="blue") )
with(hpcDate, points(FullDateTime,Sub_metering_1,type="p",col="yellow") )
with(hpcDate, points(FullDateTime,Sub_metering_2,type="l",col="red") )
dev.copy(png,'plot3.png')
dev.off();

#Multiple plots
pdf("plot4.png")
par(mfrow = c(2,2))
with(hpcDate,{
	plot(strptime(paste0(hpcDate$Date," ",hpcDate$Time), format="%m/%d/%Y %H:%M:%S"), as.numeric(hpcDate$Global_active_power), type="l" )
	plot(strptime(paste0(hpcDate$Date," ",hpcDate$Time), format="%m/%d/%Y %H:%M:%S"), as.numeric(hpcDate$Voltage), type="l" )

	plot(FullDateTime,Sub_metering_3,type="l",col="blue")
	points(FullDateTime,Sub_metering_1,type="p",col="yellow")
	points(FullDateTime,Sub_metering_2,type="l",col="red")

	plot(strptime(paste0(hpcDate$Date," ",hpcDate$Time), format="%m/%d/%Y %H:%M:%S"), as.numeric(hpcDate$Global_reactive_power), type="l" )
})
dev.copy(png,'plot4.png')

