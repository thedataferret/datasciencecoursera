
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
point_chart_data <- data.frame(cbind(survey_years, point_PM25, rep("point", times = n)))
  colnames(point_chart_data) <- c("survey_years", "PM25", "type")
nonpoint_chart_data <- data.frame(cbind(survey_years, nonpoint_PM25, rep("nonpoint", times = n)))
  colnames(nonpoint_chart_data) <- c("survey_years", "PM25", "type")
onroad_chart_data <- data.frame(cbind(survey_years, onroad_PM25, rep("onroad", times = n)))
  colnames(onroad_chart_data) <- c("survey_years", "PM25", "type")
nonroad_chart_data <- data.frame(cbind(survey_years, nonroad_PM25, rep("nonroad", times = n)))
 colnames(nonroad_chart_data) <- c("survey_years", "PM25", "type")

chart_data <- rbind(point_chart_data, nonpoint_chart_data, onroad_chart_data, nonroad_chart_data)
chart_data$PM25 <- as.numeric(chart_data$PM25)

# Tidy up
rm(n, i, survey_years, NEI, 
   NEI_Baltimore, NEI_Baltimore_Point, NEI_Baltimore_Nonpoint, NEI_Baltimore_Onroad, NEI_Baltimore_Nonroad,
   nonpoint_PM25, nonroad_PM25, onroad_PM25, point_PM25)



#rep("point", times = 5)

# Start Plotting
# -----------------------------------------------
require(ggplot2, grid)

qplot(survey_years, PM25, data = chart_data, facets = .~type) +
  geom_bar(stat = "identity")



# Print the chart to PNG
dev.copy(png, file="plot3.png", width=900, height=480)
dev.off()
# -----------------------------------------------