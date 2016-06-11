
# Load the RDS files into the global environment
# -----------------------------------------------
# National Emissions Inventory
assign("NEI", readRDS("summarySCC_PM25.rds"), envir = .GlobalEnv)


# Set up data for plotting
# -----------------------------------------------

#Get NEI data just for Baltimore
NEI_Baltimore <- NEI[NEI$fips == '24510',]
  
survey_years <- c(1999, 2002, 2005, 2008)


#-------------------------
# Data for "point" PM25
NEI_Baltimore_Point <- NEI_Baltimore[NEI_Baltimore$type == "POINT",]
# Create a vector of zeroes to contain the sums for each year
point_PM25 <- numeric(length(survey_years))
n <- 1
for (i in survey_years) {
  point_PM25[n] <- sum(NEI_Baltimore_Point$Emissions[NEI_Baltimore_Point$year == i])
  n <- n + 1
}


#-------------------------
# Data for "nonpoint" PM25
NEI_Baltimore_Nonpoint <- NEI_Baltimore[NEI_Baltimore$type == "NONPOINT",]
# Create a vector of zeroes to contain the sums for each year
nonpoint_PM25 <- numeric(length(survey_years))
n <- 1
for (i in survey_years) {
  nonpoint_PM25[n] <- sum(NEI_Baltimore_Nonpoint$Emissions[NEI_Baltimore_Nonpoint$year == i])
  n <- n + 1
}


#-------------------------
# Data for "onroad" PM25
NEI_Baltimore_Onroad <- NEI_Baltimore[NEI_Baltimore$type == "ON-ROAD",]
# Create a vector of zeroes to contain the sums for each year
onroad_PM25 <- numeric(length(survey_years))
n <- 1
for (i in survey_years) {
  onroad_PM25[n] <- sum(NEI_Baltimore_Onroad$Emissions[NEI_Baltimore_Onroad$year == i])
  n <- n + 1
}


#-------------------------
# Data for "nonroad" PM25
NEI_Baltimore_Nonroad <- NEI_Baltimore[NEI_Baltimore$type == "NON-ROAD",]
# Create a vector of zeroes to contain the sums for each year
nonroad_PM25 <- numeric(length(survey_years))
n <- 1
for (i in survey_years) {
  nonroad_PM25[n] <- sum(NEI_Baltimore_Nonroad$Emissions[NEI_Baltimore_Nonroad$year == i])
  n <- n + 1
}


# Create a dataframe for what we want to use in the chart
point_chart_data <- data.frame(cbind(survey_years, point_PM25))
nonpoint_chart_data <- data.frame(cbind(survey_years, nonpoint_PM25))
onroad_chart_data <- data.frame(cbind(survey_years, onroad_PM25))
nonroad_chart_data <- data.frame(cbind(survey_years, nonroad_PM25))

# Tidy up
rm(n, i, survey_years, NEI, 
   NEI_Baltimore, NEI_Baltimore_Point, NEI_Baltimore_Nonpoint, NEI_Baltimore_Onroad, NEI_Baltimore_Nonroad,
   nonpoint_PM25, nonroad_PM25, onroad_PM25, point_PM25)





# Start Plotting
# -----------------------------------------------
require(ggplot2, grid)
# Plot 1: Point Emissions

# P1 <- ggplot(point_chart_data, aes(x = survey_years, y = point_PM25))
p1 <- qplot(survey_years, point_PM25, data = point_chart_data, geom = c("point", "smooth"))
p2 <- qplot(survey_years, nonpoint_PM25, data = nonpoint_chart_data, geom = c("point", "smooth"))
p3 <- qplot(survey_years, onroad_PM25, data = onroad_chart_data, geom = c("point", "smooth"))
p4 <- qplot(survey_years, nonroad_PM25, data = nonroad_chart_data, geom = c("point", "smooth"))

library(grid)
multiplot(p1, p2, p3, p4, cols=2)


# Print the chart to PNG
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
# -----------------------------------------------
