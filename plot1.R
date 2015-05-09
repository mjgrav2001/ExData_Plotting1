#-----------------------------------------------------------
elpowcon <- read.table("./data/household_power_consumption.txt", sep = ";", skip = 66637, nrows=2881)
elpowcon_data <- na.omit(elpowcon)

par(mfrow = c(1,1))
hist(elpowcon_data$V3, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()
