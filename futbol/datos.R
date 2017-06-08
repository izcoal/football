setwd("C:/Users/TBG/Desktop")
library(httr)
library(XML)
library(RCurl)

# Configuracion del proxyset.
set_config(use_proxy(url="10.165.0.250", port=8080))
#make.socket(host = "10.165.0.250", 8080, fail = TRUE, server = FALSE)


## Solicitar fecha fecha = 

#url_competicion = "http://clubelo.com/20-05-2011/ESP/Ranking"
url_competicion = paste("http://clubelo.com/",fecha,"/ESP/Ranking",sep="")
competicion = GET(url_competicion)

datos_competicion  = readHTMLTable(rawToChar(competicion$content))[2]
datos_competicion = data.frame(datos_competicion)
head(datos_competicion)

head(trimws(substr(datos_competicion$NULL.Club,3,length(datos_competicion$NULL.Club))))