
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source("modelo poisson.R")
matches = read.csv2("season1516.csv",header=TRUE,dec=",")

shinyServer(
  
  function(input, output) {
    
    results <- eventReactive(input$predecir, {
      prediccion(div1.teams,coef(efectos),home1,home2,input$loc,input$vis)
    })
    
    output$GolesLocal <- 
                                       renderText({
        results()$h.goals
  })
    
    output$GolesVisitante <- 
                                           renderText({
      results()$a.goals
    })
    
  

    
    
})
