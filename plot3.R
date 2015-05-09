#-----------------------------------------------------------
install.packages("lubridate")
library(lubridate)

elpowcon <- read.table("./data/household_power_consumption.txt", sep = ";", skip = 66637, nrows=2881)
elpowcon_data <- na.omit(elpowcon)

elpowcon_data[,2] <- paste(as.Date(elpowcon_data[,1], "%d/%m/%Y"), elpowcon_data[,2])
elpowcon_data[,1] <- weekdays(as.Date(elpowcon_data[,1], "%d/%m/%Y"))
elpowcon_data[,2] <- sapply(elpowcon_data[,2], function (x) minute(x) + 60*hour(x) + 60*24*(day(x)-1))

par(mfrow = c(1,1))
with(elpowcon_data, plot(V2, V7, pch="", col = "black", type = "o", xaxt ="n", ann = FALSE))
with(elpowcon_data, lines(V2, V8, pch="", col = "red", type = "o", xaxt = "n", ann = FALSE))
with(elpowcon_data, lines(V2, V9, pch="", col = "blue", type = "o", xaxt = "n", ann = FALSE))
axis(1, at=c(0,1440,2880), lab=c("Thu","Fri","Sat"))
title(ylab = "Energy sub metering")
legend("topright", col = c("black", "red", "blue"), cex = 0.8, pch ="", lty=1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png")
dev.off()

