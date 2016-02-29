# Read data 
epc <- read.table('./data/household_power_consumption.txt', sep=';', header=TRUE, stringsAsFactors=FALSE)
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")
cols = c(3,4,5,6,7,8,9);    
epc[,cols] = apply(epc[,cols], 2, function(x) as.numeric(as.character(x)))
epc$Time <- strptime(paste(as.character(epc$Date), epc$Time), "%Y-%m-%d %H:%M:%S")
tmp <- epc[(epc$Date >= "2007-02-01" & epc$Date <= "2007-02-02"), ] # Subset data

# Assuming data is load in the data frame tmp
png(filename = "plot1.png", width = 480, height = 480)
hist(tmp$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()