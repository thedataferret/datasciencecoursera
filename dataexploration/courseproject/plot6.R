# Load the RDS files into the global environment
# -----------------------------------------------
# National Emissions Inventory
assign("NEI", readRDS("summarySCC_PM25.rds"), envir = .GlobalEnv)
assign("SCC", readRDS("Source_Classification_Code.rds"), envir = .GlobalEnv)

# Set up data for plotting
# -----------------------------------------------

# Find indices which match Coal Combustion in SCC using grep
pattern = "Mobile - On-Road.*"
grep_MVE <- grep(pattern, SCC$EI.Sector, ignore.case=TRUE)
MVE_codes <- SCC[grep_MVE, 1]

# Subset the NEI data to just motor vehicle emissions data
MVE_NEI <- NEI[NEI$SCC %in% MVE_codes,]
MVE_NEI$SCC <- as.factor(MVE_NEI$SCC)

# Now subset to Baltimore City and Los Angeles
BC_MVE_NEI <- MVE_NEI[MVE_NEI$fips == '24510',]
LA_MVE_NEI <- MVE_NEI[MVE_NEI$fips == '06037',]

# Now create the dataframe summarised for each year
Survey_Years <- c(1999, 2002, 2005, 2008)

Baltimore_City <- numeric(length(Survey_Years))
n <- 1
for (i in Survey_Years) {
  Baltimore_City[n] <- sum(BC_MVE_NEI$Emissions[BC_MVE_NEI$year == i])
  n <- n + 1
}

Los_Angeles_County <- numeric(length(Survey_Years))
n <- 1
for (i in Survey_Years) {
  Los_Angeles_County[n] <- sum(LA_MVE_NEI$Emissions[LA_MVE_NEI$year == i])
  n <- n + 1
}


chart_data <- data.frame(cbind(Survey_Years, Baltimore_City, Los_Angeles_County))
chart_data$Survey_Years <- as.factor(chart_data$Survey_Years)

# Convert to long format data for best ggplot
chart_data_long <- melt(chart_data)
colnames(chart_data_long) <- c("Survey_Years", "City", "PM25_Emissions")

#Start Plotting!

require(ggplot2)
options(scipen = 999)

p6 <- ggplot(chart_data_long, aes(x = Survey_Years, y = PM25_Emissions, group = City, colour = City)) + 
  geom_line() + geom_point() 
  
p6 + labs(title = "Motor Vehicle PM25 Emissions: Baltimore City and Los Angeles County", xlab = "Survey Years")
  


# Print the chart to PNG
dev.copy(png, file="plot6.png", width=900, height=480)
dev.off()
# -----------------------------------------------

