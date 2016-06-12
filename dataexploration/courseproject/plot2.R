
# Load the RDS files into the global environment
# -----------------------------------------------

# National Emissions Inventory
assign("NEI", readRDS("summarySCC_PM25.rds"), envir = .GlobalEnv)


# Set up data for plotting
# -----------------------------------------------

#Get NEI data just for Baltimore
NEI_Baltimore <- NEI[NEI$fips == '24510',]
  
survey_years <- c(1999, 2002, 2005, 2008)
# Create a vector of zeroes to contain the sums for each year
total_annual_PM25 <- numeric(length(survey_years))
s <- 1
 
for (i in survey_years) {
  total_annual_PM25[s] <- sum(NEI_Baltimore$Emissions[NEI_Baltimore$year == i])
  s <- s+1
}

# Create a dataframe for what we want to use in the chart
chart_data <- data.frame(cbind(survey_years, total_annual_PM25))

# Tidy up
rm(s, i, survey_years, total_annual_PM25)

# Start Plotting
# -----------------------------------------------
# Make a quick trend line with simple lm() so that we can have a trend line.
trend <- lm(total_annual_PM25 ~ survey_years, data = chart_data)

# Make the line plot using base package
plot(chart_data,
     ylab = "Total Emissions (tons)",
     xlab = "Year of Survey",
     pch = 19,
     cex = 1.5,
     xaxt = 'n')
axis(1, tck = 1, lty = 3, lwd = 1, at = seq(1999, 2008, by = 3), las=1)
title("PM25 Emissions - Baltimore City, MD", sub = "Source: National Emissions Inventory",
      cex.main = 2,   font.main= 2,
      cex.sub = 0.75, font.sub = 3, col.sub = "red")
#lines(chart_data, lty = 3, lwd = 1)
abline(trend, col = "red", lty = 3, lwd = 2)
options(scipen=10)

# Print the chart to PNG
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
# -----------------------------------------------
