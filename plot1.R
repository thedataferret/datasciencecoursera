# loading the data
df_all <- read.csv2("household_power_consumption.txt")

#converting the dates and times to actual dates and times
df_all$Date <- as.Date(df_all$Date, "%d/%m/%Y")
df_all$Time <- strptime(df_all$Time, '%H:%M:%S')

# subsetting down to the relevant 2 days
df_sub <- df_all[df_all$Date %in% as.Date(c('2007/02/01', '2007/02/02')),]

# converting specific columns to numeric, then to kilowatts
df_sub$Global_active_power <- as.numeric(df_sub$Global_active_power)
df_sub$Global_active_power <- df_sub$Global_active_power/1000

# Note that in this dataset missing values are coded as ?.
# drawing the histogram

hist(df_sub$Global_active_power, 
     col = 'red', 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# And now printing it as a png

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()


