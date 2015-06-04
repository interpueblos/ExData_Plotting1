#Using an estimate memory = ncolumn * nrows*8bytes/numeric 
#memory=9*2075259*8=149418648 bytes=142,49 Mb

## load dplyr library
library(dplyr)
library(datasets)

## In this course project I'm assuming that the that is in the same directory as
## the scripts. If you want to test them, don't forget to copy the data file!
## Read the header and then take only de lines for the dates 01-02-2007 
## to 02-02-2007
header<-scan("./household_power_consumption.txt",sep=";",nlines=1,what=character())
consum<-read.table("./household_power_consumption.txt",sep=";",skip=66637,nrow=2880)

## Assign the header
names(consum)<-header

#Convert date and time columns to correct date format.
dates<-paste(consum$Date,consum$Time)
dates<-strptime(dates,"%d/%m/%Y %H:%M:%S")

## Insert the correct date and delete the older columns Date and Time
consum<-cbind(dates,consum)
consum<-select(consum,-(Date),-(Time))

## Open the device for the png file with the defined size
png("./plot4.png",width=480,height=480,units="px")

# Put the par to be 2x2 graphics in the plot
par(mfrow = c(2,2))

par(mar=c(4,4,4,1))

## Plot in the first row, first column
## Create the plot which will be printed in the png file
with(consum, plot(dates,Global_active_power,type="l", xlab="",
                  ylab="Global Active Power"))

## Plot in the first row, second column
## Create the plot which will be printed in the png file
with(consum, plot(dates,Voltage,type="l", xlab="datetime",
                  ylab="Voltage",lwd="0.5"))

## Plot in the second row, first column
## Create the plot which will be printed in the png file.
## We start creating a blank plot and after that we put the three lines
plot(consum$dates,consum$Sub_metering_1,type="n", xlab="",
     ylab="Energy Sub Metering")

lines(consum$dates,consum$Sub_metering_1,col="black",lwd="0.5")
lines(consum$dates,consum$Sub_metering_2,col="red",lwd="0.5")
lines(consum$dates,consum$Sub_metering_3,col="blue",lwd="0.5")

## Create the legend without box line
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n",lty=c(1,1,1),col=c("black","red","blue"))

## Plot in the second row, second column
## Create the plot which will be printed in the png file
with(consum, plot(dates,Global_reactive_power,type="l",lwd="0.5", 
                  xlab="datetime",ylab="Global_reactive_power"))

## close the device
dev.off()
