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
png("./plot1.png",width=480,height=480,units="px")

## Create the histogram which will be printed in the png file
hist(consum$Global_active_power,main="Global Active Power",
     xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red")

## close the device
dev.off()
