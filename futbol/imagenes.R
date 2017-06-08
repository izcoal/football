library(jpeg)
library(rgdal)
setwd("C:/Users/TBG/Downloads")

name = "image"
path=paste("C:/Users/TBG/Downloads/",name,".jpg",sep="")
myJPG <- readJPEG(path,native = TRUE)
plot(myJPG)