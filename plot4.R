# read the data
hpc <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

library(dplyr)
hpc <- tbl_df(hpc)
# Change the character vectors to date
hpc<- mutate(hpc,Date = as.Date(Date, tryFormats = c("%d-%m-%Y", "%d/%m/%Y")))

# filter for the required dates
hpc<-filter(hpc, Date >= "2007-02-01" & Date <= "2007-02-02")

hpc2<-mutate(hpc, Date = paste(Date, Time, sep = " ")) %>%
  select(-Time) %>%
  hpc2<-  mutate(hpc2, Date = strptime(Date, format = "%Y-%m-%d %H:%M:%S"))

# plot 4
par(mfrow = c(2,2),cex.lab = 0.8)
with(hpc2, plot(Date, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))
with(hpc2, plot(Date, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))
with(hpc2, plot(Date, Sub_metering_1, type = "l", ylab = "Energy sub metering"))
with(hpc2, points(Date, Sub_metering_2, type = "l", col="red"))
with(hpc2, points(Date, Sub_metering_3, type = "l", col="blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex = 0.5, bty="n")
with(hpc2, plot(Date, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))
dev.copy(png, file= "plot4.png")
dev.off()