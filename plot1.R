# read the data (we are assuming that the household_power_consumption.txt file is in your working directory)
hpc <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

library(dplyr)
hpc <- tbl_df(hpc)
# Change the character vectors to date
hpc<- mutate(hpc,Date = as.Date(Date, tryFormats = c("%d-%m-%Y", "%d/%m/%Y")))

# filter for the required dates
hpc<-filter(hpc, Date >= "2007-02-01" & Date <= "2007-02-02")
# mutate to get the date and time together in date format in a single column
hpc2<-mutate(hpc, Date = paste(Date, Time, sep = " ")) %>%
  select(-Time) %>%
  hpc2<-  mutate(hpc2, Date = strptime(Date, format = "%Y-%m-%d %H:%M:%S"))

# plot 1
with(hpc2, hist(Global_active_power, main= "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)"))
dev.copy(png, file= "plot1.png")
dev.off()