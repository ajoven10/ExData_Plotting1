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

plot(datos$Time, datos$Sub_metering_1, type = "l",
     ylab ="Energy sub metering", xlab = "",
     col ="black")
points(datos$Time, datos$Sub_metering_2, type = "l",
       col ="red")
points(datos$Time, datos$Sub_metering_3, type = "l",
       col ="blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
            "Sub_metering_3"), col=c("black", "red", "blue"),
            cex=0.7,  lwd=c(1,1,1 ))

dev.copy(png, filename = "plot3.png")
dev.off()