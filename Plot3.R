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

png(filename = "plot3.png", width = 480, height=480)
plot(subdata1$Time, subdata1$Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering")
with(subdata1, lines(Time, subdata1$Sub_metering_2, type="l",col= "red"))
with(subdata1, lines(Time, subdata1$Sub_metering_3, type="l",col= "blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main = "Energy  sub-metering")
dev.off()

