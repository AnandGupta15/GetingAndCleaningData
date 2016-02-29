# Read data 
epc <- read.table('./data/household_power_consumption.txt', sep=';', header=TRUE, stringsAsFactors=FALSE)
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")
cols = c(3,4,5,6,7,8,9);    
epc[,cols] = apply(epc[,cols], 2, function(x) as.numeric(as.character(x)))
epc$Time <- strptime(paste(as.character(epc$Date), epc$Time), "%Y-%m-%d %H:%M:%S")
tmp <- epc[(epc$Date >= "2007-02-01" & epc$Date <= "2007-02-02"), ] # Subset data

# Assuming data is load in the data frame tmp
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
# 1
hist(tmp$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
#2
with(tmp, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)") )
#2
plot( tmp$Time, tmp$Sub_metering_1, type="l", col="grey", xlab="", ylab="Energy sub metering" )
lines(tmp$Time, tmp$Sub_metering_2,col="red")
lines(tmp$Time, tmp$Sub_metering_3,col="blue")
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3') , lty=1, col=c('grey','red', 'blue'), bty='n', cex=.75)
#4
with(tmp, plot(Time, Global_reactive_power, type = "l") )
dev.off()
