#
# This is the server logic of a Shiny web application. 
#

library(shiny)

# Define server logic required to create and fit the sample
shinyServer(function(input, output) {

  myTests <- reactiveValues()
  
  observe({
    if(input$add > 0){
      
      if(input$result) {
        myTests$testList <- c(isolate(myTests$testList), paste("Positive (",isolate(input$sensi)/100,"% /",isolate(input$speci)/100,"%)\n"))
        myTests$pInfected <- c(isolate(myTests$pInfected), isolate(input$sensi)/100)
        myTests$pHealthy <- c(isolate(myTests$pHealthy), 1 - isolate(input$speci)/100)
      }
      else {
        myTests$testList <- c(isolate(myTests$testList), paste("Negative (",isolate(input$sensi)/100,"% /",isolate(input$speci)/100,"%)\n"))
        myTests$pInfected <- c(isolate(myTests$pInfected), 1 - isolate(input$sensi)/100)
        myTests$pHealthy <- c(isolate(myTests$pHealthy), isolate(input$speci)/100)
      }
    }
  })
  
  output$list <- renderText({
    myTests$testList
  })
  
  output$prob <-renderText({
    paste("P(results | healthy) = ",prod( myTests$pHealthy ),"\nP(results | infected) = ",prod( myTests$pInfected ) )
  })

  output$plot <- renderPlot({
    barplot(c(prod( myTests$pHealthy ),prod( myTests$pInfected )),names.arg = c("Healthy","Infected"),main="Probability",col = c("green","red"))
  })
  
})
