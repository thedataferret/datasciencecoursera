# This package is awesome.
install.packages('lubridate')
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
Sub_metering_1 <- as.numeric(as.character(df_sub$Sub_metering_1))
Sub_metering_2 <- as.numeric(as.character(df_sub$Sub_metering_2))
Sub_metering_3 <- as.numeric(as.character(df_sub$Sub_metering_3))

# and now we plot - type is 'l' or line chart
plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering",xlab = "")
lines(datetime, Sub_metering_2, type = "l", col = "red")
lines(datetime, Sub_metering_3, type = "l", col = "blue")

# copy to PNG device and close off
dev.copy(png,"plot3.png")
dev.off()


