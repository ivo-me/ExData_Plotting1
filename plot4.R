## set system locale
Sys.setlocale("LC_ALL","C")

## load libraries
library(lubridate)
library(ggplot2)
library(gridExtra)
library(scales)

## load data
hpc.source <- "./household_power_consumption.txt"
hpc.df <- read.csv(hpc.source, header = TRUE, sep = ";", na.strings = "?")

## convert $Date from factor to date object
hpc.df$Date <- as.Date(hpc.df$Date, "%d/%m/%Y")

## subset of the specific date range
sub.hpc.df <- subset(hpc.df, Date >= "2007-02-01" & Date <= "2007-02-02")

## add DateTime variable
sub.hpc.df$DateTime <- strptime(paste(sub.hpc.df$Date, sub.hpc.df$Time), "%Y-%m-%d %H:%M:%S")

## PLOTS
# plots
plot4.1 <- qplot(DateTime, Global_active_power, data = sub.hpc.df, geom = "line", ylab = "Global Active Power")
plot4.2 <- qplot(DateTime, Voltage, data = sub.hpc.df, geom = "line", ylab = "Voltage")
plot4.3 <- ggplot(
        sub.hpc.df, aes(DateTime, y)) + 
        geom_line(aes(y = Sub_metering_1, col = "Sub_metering_1")) + 
        geom_line(aes(y = Sub_metering_2, col = "Sub_metering_2"))+
        geom_line(aes(y = Sub_metering_3, col = "Sub_metering_3")
        )
plot4.4 <- qplot(DateTime, Global_reactive_power, data = sub.hpc.df, geom = "line")

# format plots
plot4.1 <- plot4.1 + 
        scale_x_datetime(xlab(""), labels = date_format("%a"), breaks = date_breaks("day")) +
        theme(
                panel.background = element_blank(),
                panel.border = element_rect(colour = "black", fill = NA),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.text = element_text(colour = "black"),
                axis.title.y = element_text(vjust = 2))

plot4.2 <- plot4.2 + 
        scale_x_datetime(xlab("datetime"), labels = date_format("%a"), breaks = date_breaks("day")) +
        theme(
                panel.background = element_blank(),
                panel.border = element_rect(colour = "black", fill = NA),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.text = element_text(colour = "black"),
                axis.title.y = element_text(vjust = 2))

plot4.3 <- plot4.3 + 
        xlab("") +
        ylab("Energy sub meterings") + 
        scale_colour_manual(values = c("black", "darkorange2", "mediumblue")) +
        scale_x_datetime(labels = date_format("%a"), breaks = date_breaks("day")) +
        theme(
                panel.background = element_blank(),
                panel.border = element_rect(colour = "black", fill = NA),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.text = element_text(colour = "black"),
                axis.title.y = element_text(vjust = 2),
                legend.position = c(0.695, 0.75),
                legend.background = element_rect(fill = "white"),
                legend.key = element_rect(fill = "white"),
                legend.title = element_blank())

plot4.4 <- plot4.4 +
        scale_x_datetime(xlab("datetime"), labels = date_format("%a"), breaks = date_breaks("day")) +
        theme(
                panel.background = element_blank(),
                panel.border = element_rect(colour = "black", fill = NA),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.text = element_text(colour = "black"),
                axis.title.y = element_text(vjust = 2))

# open device
png(file = "plot4.png")

# put all plots in a grid
grid.arrange(plot4.1, plot4.2, plot4.3, plot4.4, nrow = 2, ncol = 2, heights = unit(rep(2.76, 1), "in"))

#close device
dev.off() 