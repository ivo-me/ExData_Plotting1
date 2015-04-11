# set system locale
Sys.setlocale("LC_ALL","C")

# load libraries
library(lubridate)
library(ggplot2)
library(scales)

# load data
hpc.source <- "./household_power_consumption.txt"
hpc.df <- read.csv(hpc.source, header = TRUE, sep = ";", na.strings = "?")

# convert $Date from factor to date object
hpc.df$Date <- as.Date(hpc.df$Date, "%d/%m/%Y")

# subset of the specific date range
sub.hpc.df <- subset(hpc.df, Date >= "2007-02-01" & Date <= "2007-02-02")

# add DateTime variable
sub.hpc.df$DateTime <- strptime(paste(sub.hpc.df$Date, sub.hpc.df$Time), "%Y-%m-%d %H:%M:%S")

# plot $DateTime and $Global_active_power
plot2 <- qplot(DateTime, Global_active_power, data = sub.hpc.df, geom = "line", ylab = "Global Active Power (kilowatts)")

# format plot
plot2 <- plot2 + 
        scale_x_datetime(xlab(""), labels = date_format("%a"), breaks = date_breaks("day")) +
        theme(
                panel.background = element_blank(),
                panel.border = element_rect(colour = "black", fill = NA),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.text = element_text(size = 14, colour = "black"),
                axis.title.y = element_text(size = 14, vjust = 2))

# save plot
ggsave(plot2, file="plot2.png", scale = 1, width = 6.667, height = 6.667, units = c("in"), dpi = 72)
