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

# Now subset to Baltimore City only
BC_MVE_NEI <- MVE_NEI[MVE_NEI$fips == '24510',]

# Now create the dataframe summarised for each year
Survey_Years <- c(1999, 2002, 2005, 2008)

PM25_Emissions <- numeric(length(Survey_Years))
n <- 1
for (i in Survey_Years) {
  PM25_Emissions[n] <- sum(BC_MVE_NEI$Emissions[BC_MVE_NEI$year == i])
  n <- n + 1
}


chart_data <- data.frame(cbind(Survey_Years, PM25_Emissions))
chart_data$Survey_Years <- as.factor(chart_data$Survey_Years)

#Start Plotting!

require(ggplot2)
options(scipen = 999)
qplot(Survey_Years, PM25_Emissions, data = chart_data) +
  geom_bar(stat = "identity") +
  labs(title = "Decline in PM25 Emissions from On-Road Motor Vehicle Sources: Baltimore City", xlab = "Survey Years", ylab = "PM25 Emissions (tons)")


# Print the chart to PNG
dev.copy(png, file="plot5.png", width=900, height=480)
dev.off()
# -----------------------------------------------

