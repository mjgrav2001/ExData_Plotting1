#-----------------------------------------------------------
install.packages("lubridate")
library(lubridate)

elpowcon <- read.table("./data/household_power_consumption.txt", sep = ";", skip = 66637, nrows=2881)
elpowcon_data <- na.omit(elpowcon)

elpowcon_data[,2] <- paste(as.Date(elpowcon_data[,1], "%d/%m/%Y"), elpowcon_data[,2])
elpowcon_data[,1] <- weekdays(as.Date(elpowcon_data[,1], "%d/%m/%Y"))
elpowcon_data[,2] <- sapply(elpowcon_data[,2], function (x) minute(x) + 60*hour(x) + 60*24*(day(x)-1))

plot(elpowcon_data$V2, elpowcon_data$V3, pch = "", type="o", xaxt ="n", ann = FALSE)
axis(1, at=c(0,1440,2880), lab=c("Thu","Fri","Sat"))
title(ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png")
dev.off()
