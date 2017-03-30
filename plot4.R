# Load the library

library(lubridate)
# Read the table data

pwr_data <- read.table("household_power_consumption.txt",sep=";",header=TRUE)

# Convert the date 
pwr_data$Date <-  dmy(pwr_data$Date)
# select only the relevent data

rel_pwr_data <- subset(pwr_data,pwr_data$Date == ymd("2007-02-01") | pwr_data$Date == ymd("2007-02-02") )

# remove the huge dataset

rm(pwr_data)
# Covert the Active power variable
rel_pwr_data$Global_active_power <- as.numeric(as.character(rel_pwr_data$Global_active_power))

# Create a new variable for Date and timestamp
rel_pwr_data$DateTms <- ymd_hms(paste(rel_pwr_data$Date,rel_pwr_data$Time))

rel_pwr_data$Sub_metering_1 <- as.numeric(as.character(rel_pwr_data$Sub_metering_1))
rel_pwr_data$Sub_metering_2 <- as.numeric(as.character(rel_pwr_data$Sub_metering_2))
rel_pwr_data$Sub_metering_3 <- as.numeric(as.character(rel_pwr_data$Sub_metering_3))
rel_pwr_data$Voltage <- as.numeric(as.character(rel_pwr_data$Voltage))
rel_pwr_data$Global_reactive_power <- as.numeric(as.character(rel_pwr_data$Global_reactive_power))



# Open the fourth plot file
png("plot4.png")
par(mfrow=c(2,2))
# creating the plot 1
with(rel_pwr_data,plot(DateTms,Global_active_power,type = "l",xlab="",ylab="Global Active Power"))
# creating the plot 2
with(rel_pwr_data,plot(DateTms,Voltage,type = "l",xlab="datetime",ylab="Voltage"))

# creating the plot 3
with(rel_pwr_data,plot(DateTms,rel_pwr_data$Sub_metering_1,type = "l",xlab="",ylab="Energy Sub metering"))
with(rel_pwr_data,points(DateTms,rel_pwr_data$Sub_metering_2,type="l",col="red"))
with(rel_pwr_data,points(DateTms,rel_pwr_data$Sub_metering_3,type="l",col="blue"))
# create the legend
legend("topright",lty =  c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# creating the plot 4
with(rel_pwr_data,plot(DateTms,Global_reactive_power,type = "l",xlab="datetime",ylab="Global_reactive_power"))
# close the png file
dev.off()
