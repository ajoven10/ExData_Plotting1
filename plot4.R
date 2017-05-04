if(!file.exists("household_power_consumption.txt")) {
    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile="./ejercicioEXpl.zip") 
    unzip("./ejercicioExpl.zip")
    
}

library(sqldf)
library(lubridate)

datos1 <- read.csv.sql("household_power_consumption.txt", 
                       sql = "select * from file where Date
                       == '1/2/2007' ", 
                       header = TRUE, sep = ";")
datos2 <- read.csv.sql("household_power_consumption.txt", 
                       sql = "select * from file where Date
                       == '2/2/2007' ", 
                       header = TRUE, sep = ";")

datos <- rbind(datos1, datos2)
datos$fechahora <- paste(datos$Date, datos$Time)
datos$Time <-  dmy_hms(datos$fechahora)

oldpar=par()
par(mfrow = c(2,2))

plot(datos$Time, datos$Global_active_power, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

plot(datos$Time, datos$Voltage, type="l", xlab="datetime",
     ylab="Voltage")

plot(datos$Time, datos$Sub_metering_1, type = "l",
     ylab ="Energy sub metering", xlab = "",
     col ="black")
points(datos$Time, datos$Sub_metering_2, type = "l",
       col ="red")
points(datos$Time, datos$Sub_metering_3, type = "l",
       col ="blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
        "Sub_metering_3"), col=c("black", "red", "blue"),
       cex=0.4,  lwd=c(1,1,1 ), bty="n")

plot(datos$Time, datos$Global_reactive_power, type="l", 
     xlab="datetime",  ylab="Global_reactive_power")

dev.copy(png, filename = "plot4.png")
dev.off()

par=oldpar
