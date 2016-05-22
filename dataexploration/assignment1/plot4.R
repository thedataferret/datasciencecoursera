# This package is awesome.
# install.packages('lubridate')
library(lubridate)

# loading the data
df_all <- read.csv2("household_power_consumption.txt")

# getting the subset of data - 1st and 2nd Feb 2007
df_sub1 <- subset(df_all, dmy(df_all$Date) == "2007-02-01")
df_sub2 <- subset(df_all, dmy(df_all$Date) == "2007-02-02")

df_sub <- rbind(df_sub1,df_sub2)

# Tidying up
rm(df_sub1, df_sub2, df_all)

# wizardry with the datetime - creating a separate date vector
datetime <- strptime(paste(df_sub$Date,df_sub$Time,sep = " "), "%d/%m/%Y %H:%M:%S")

# creating separate values vectors (coercing to numeric, since they were factors in the df)
Global_active_power <- as.numeric(as.character(df_sub$Global_active_power))
Global_reactive_power <- as.numeric(as.character(df_sub$Global_reactive_power))
Voltage <- as.numeric(as.character(df_sub$Voltage))
Sub_metering_1 <- as.numeric(as.character(df_sub$Sub_metering_1))
Sub_metering_2 <- as.numeric(as.character(df_sub$Sub_metering_2))
Sub_metering_3 <- as.numeric(as.character(df_sub$Sub_metering_3))

# Now to run the plot

par(mfrow = c(2,2))

# Global Active Power - Plot2
plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power",xlab = "Global Active Power (kilowatts)")

# Voltage - new plot
plot(datetime, Voltage, type = "l", ylab = "Voltage",xlab = "datetime")

# Energy sub metering - Plot3
plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering",xlab = "")
lines(datetime, Sub_metering_2, type = "l", col = "red")
lines(datetime, Sub_metering_3, type = "l", col = "blue")

# Global_reactive_power (new plot)
plot(datetime, Global_reactive_power, type = "l", ylab = "Global_reactive_power",xlab = "datetime")






# copy to PNG device and close off
dev.copy(png,"plot4.png")
dev.off()


