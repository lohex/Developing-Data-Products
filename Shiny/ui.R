#
# This is the user-interface definition of a Shiny web application.
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Interpretation of repeated quick tests results"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          
            sliderInput("sensi",
                        "Sensitivity:",
                        min = 1,
                        max = 100,
                        value = 72),
            sliderInput("speci",
                        "Specificity:",
                        min = 1,
                        max = 100,
                        value = 90),
          selectInput("result", "Quicktest result:",
                     c("Positive" = TRUE,
                       "Negative" = FALSE)),
         actionButton('add','Add test')
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
          verbatimTextOutput('list'),
          verbatimTextOutput('prob'),
          plotOutput("plot")
        )
    )
))
