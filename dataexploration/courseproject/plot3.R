require(ggplot2)
require(reshape2)

# Load the RDS files into the global environment
# -----------------------------------------------
# National Emissions Inventory
assign("NEI", readRDS("summarySCC_PM25.rds"), envir = .GlobalEnv)


# Set up data for plotting
# -----------------------------------------------

# Get NEI data just for Baltimore
plot_3 <- subset(NEI, fips == "24510", c("Emissions", "year","type"))


# Reorganise the data for plotting

plot_3 <- melt(plot_3, id=c("year", "type"), measure.vars=c("Emissions"))
plot_3 <- dcast(plot_3, year + type ~ variable, sum)


# Start Plotting
# -----------------------------------------------
require(grid)

p <- qplot(year, Emissions, data = plot_3, facets = .~type) +
  geom_bar(stat = "identity")

p + labs(title = "Baltimore City PM25 Emissions by Type")



# Print the chart to PNG
dev.copy(png, file="plot3.png", width=900, height=480)
dev.off()
# -----------------------------------------------
