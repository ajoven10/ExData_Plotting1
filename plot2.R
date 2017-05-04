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

plot(datos$Time, datos$Global_active_power, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png, filename = "plot2.png")
dev.off()
