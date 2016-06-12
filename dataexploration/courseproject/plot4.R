
# Load the RDS files into the global environment
# -----------------------------------------------
# National Emissions Inventory
assign("NEI", readRDS("summarySCC_PM25.rds"), envir = .GlobalEnv)
assign("SCC", readRDS("Source_Classification_Code.rds"), envir = .GlobalEnv)

# Set up data for plotting
# -----------------------------------------------

# Find indices which match Coal Combustion in SCC using grep
pattern = "comb.*coal"
grep_coal <- grep(pattern, SCC$EI.Sector, ignore.case=TRUE)
coal_codes <- SCC[grep_coal, 1]

# Subset the NEI data to just coal consumption data
coalNEI <- NEI[NEI$SCC %in% coal_codes,]
coalNEI$SCC <- as.factor(coalNEI$SCC)


survey_years <- c(1999, 2002, 2005, 2008)

# Tidy up
rm(NEI, SCC, coal_codes, pattern, grep_coal)


#-------------------------
# Create a vector of zeroes to contain the sums for each year
PM25 <- numeric(length(survey_years))
n <- 1
for (i in survey_years) {
  PM25[n] <- sum(coalNEI$Emissions[coalNEI$year == i])
  n <- n + 1
}


chart_data <- data.frame(cbind(survey_years, PM25))
chart_data$survey_years <- as.factor(chart_data$survey_years)



# Start Plotting
# -----------------------------------------------
require(ggplot2)
options(scipen = 999)
qplot(survey_years, PM25, data = chart_data) +
  geom_bar(stat = "identity") +
  labs(title = "PM25 Emissions from Coal Combusions Sources", xlab = "Survey Year", ylab = "PM25 Emissions (tons)")



# Print the chart to PNG
dev.copy(png, file="plot4.png", width=900, height=480)
dev.off()
# -----------------------------------------------
