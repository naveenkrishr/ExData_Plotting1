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

rel_pwr_data$DateTms <- ymd_hms(paste(rel_pwr_data$Date,rel_pwr_data$Time))

# Plotting # 2

# Open the second plot file
png("plot2.png")
# create the line plot
with(rel_pwr_data,plot(DateTms,Global_active_power,type = "l",xlab="",ylab="Global Active Power(kilowatts)"))
# close the png file
dev.off()
