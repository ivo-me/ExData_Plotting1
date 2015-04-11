# set system locale
Sys.setlocale("LC_ALL","C")

# load data
hpc.source <- "./household_power_consumption.txt"
hpc.df <- read.csv(hpc.source, header = TRUE, sep = ";", na.strings = "?")

# convert $Date from factor to date object
hpc.df$Date <- as.Date(hpc.df$Date, "%d/%m/%Y")

# subset of the specific date range
sub.hpc.df <- subset(hpc.df, Date >= "2007-02-01" & Date <= "2007-02-02")

# open device
png(file = "plot1.png")

# histogram $Global_active_power
hist(sub.hpc.df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

#close device
dev.off() 