# read the data
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

# plot 2
with(hpc2, plot(Date, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file= "plot2.png")
dev.off()
