
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)


shinyUI(fluidPage(

  # Application title
  titlePanel("Predicción de resultados"),
  sidebarPanel(
    
    #textInput(inputId="loc",label="Equipo Local",value = ""),
    selectInput("loc","Equipo Local",c("Alavés","Atlético de Madrid","Athletic de Bilbao",
                                       "Barcelona","Betis","Celta","Deportivo de la Coruña",
                                       "Eibar","Espanyol","Girona","Las Palmas","Leganés","Levante",
                                       "Málaga","Real Madrid","Real Sociedad","Sevilla",
                                       "Valencia","Villarreal")),
    selectInput("vis","Equipo Visitante",c("Alavés","Atlético de Madrid","Athletic de Bilbao",
                                       "Barcelona","Betis","Celta","Deportivo de la Coruña",
                                       "Eibar","Espanyol","Girona","Las Palmas","Leganés","Levante",
                                       "Málaga","Real Madrid","Real Sociedad","Sevilla",
                                       "Valencia","Villarreal")),
    actionButton("predecir", "Predecir")

  ),
  
  
  mainPanel(textOutput("GolesLocal"),textOutput("GolesVisitante"))
  
))

