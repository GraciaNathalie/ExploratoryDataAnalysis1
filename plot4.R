#read the data  after setting the wd
mydata <- "household_power_consumption.txt"
data1 <- read.csv(mydata, sep = ";")
#check & define  the name
head(data1)
names(data1) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                  "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                  "Sub_metering_3")
#subset data & check again
subdata1 <- subset(data1, data1$Date == "1/2/2007" | data1$Date == "2/2/2007" )
head(data1)
tail(data1)

#change date and time format
subdata1$Date <- as.Date(subdata1$Date, format =  "%d/%m/%Y")
subdata1$Time <- strptime(subdata1$Time, format =  "%H:%M:%S")
subdata1[1:1440, "Time"] <- format(subdata1[1:1440, "Time"], "2007-02-01 %H:%M:%S")
subdata1[1441:2880, "Time"] <- format(subdata1[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
with(subdata1,{
        plot(subdata1$Time,as.numeric(as.character(subdata1$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
        plot(subdata1$Time,as.numeric(as.character(subdata1$Voltage)), type="l",xlab="datetime",ylab="Voltage")
        plot(subdata1$Time,subdata1$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
        with(subdata1,lines(Time,as.numeric(as.character(Sub_metering_1))))
        with(subdata1,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
        with(subdata1,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
        legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
        plot(subdata1$Time,as.numeric(as.character(subdata1$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
        })

dev.off()