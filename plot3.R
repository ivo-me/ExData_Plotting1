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

# plot $DateTime and $Sub_metering_*
plot3 <- ggplot(
                sub.hpc.df, aes(DateTime, y)) + 
                geom_line(aes(y = Sub_metering_1, col = "Sub_metering_1")) + 
                geom_line(aes(y = Sub_metering_2, col = "Sub_metering_2"))+
                geom_line(aes(y = Sub_metering_3, col = "Sub_metering_3")
                )

# format plot
plot3 <- plot3 + 
        xlab("") +
        ylab("Energy sub meterings") + 
        scale_colour_manual(values = c("black", "darkorange2", "mediumblue")) +
        scale_x_datetime(labels = date_format("%a"), breaks = date_breaks("day")) +
        theme(
                panel.background = element_blank(),
                panel.border = element_rect(colour = "black", fill = NA),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.text = element_text(size = 14, colour = "black"),
                axis.title.y = element_text(size = 14, vjust = 2),
                legend.position = c(0.871, 0.924),
                legend.background = element_rect(colour = "black", fill = "white"),
                legend.key = element_rect(fill = "white"),
                legend.title = element_blank())

# save plot
ggsave(plot3, file="plot3.png", scale = 1, width = 6.667, height = 6.667, units = c("in"), dpi = 72)
