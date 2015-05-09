#-----------------------------------------------------------
install.packages("lubridate")
library(lubridate)

elpowcon <- read.table("./data/household_power_consumption.txt", sep = ";", skip = 66637, nrows=2881)
elpowcon_data <- na.omit(elpowcon)

elpowcon_data[,2] <- paste(as.Date(elpowcon_data[,1], "%d/%m/%Y"), elpowcon_data[,2])
elpowcon_data[,1] <- weekdays(as.Date(elpowcon_data[,1], "%d/%m/%Y"))
elpowcon_data[,2] <- sapply(elpowcon_data[,2], function (x) minute(x) + 60*hour(x) + 60*24*(day(x)-1))

par(mfrow = c(2,2))
par(mar = c(4,4,2,2))

plot(elpowcon_data$V2, elpowcon_data$V3, pch = "", type="o", xaxt ="n", ann = FALSE)
axis(1, at=c(0,1440,2880), lab=c("Thu","Fri","Sat"))
title(ylab = "Global Active Power (kilowatts)")

plot(elpowcon_data$V2, elpowcon_data$V5, pch = "", type="o", xaxt ="n", ann = FALSE)
axis(1, at=c(0,1440,2880), lab=c("Thu","Fri","Sat"))
title(ylab = "Voltage")
title(xlab = "datetime")

with(elpowcon_data, plot(V2, V7, pch="", col = "black", type = "o", xaxt ="n", ann = FALSE))
with(elpowcon_data, lines(V2, V8, pch="", col = "red", type = "o", xaxt = "n", ann = FALSE))
with(elpowcon_data, lines(V2, V9, pch="", col = "blue", type = "o", xaxt = "n", ann = FALSE))
axis(1, at=c(0,1440,2880), lab=c("Thu","Fri","Sat"))
title(ylab = "Energy sub metering")
legend("topright", col = c("black", "red", "blue"), cex = 0.8, pch ="", lty=1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(elpowcon_data$V2, elpowcon_data$V4, pch = "", type="o", xaxt ="n", ann = FALSE)
axis(1, at=c(0,1440,2880), lab=c("Thu","Fri","Sat"))
title(ylab = "Global_reactive_power")
title(xlab = "datetime")
dev.copy(png, file = "plot4.png")
dev.off()
