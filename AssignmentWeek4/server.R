#
# This is the server logic of a Shiny web application. 
# Author: Karl Melgarejo Castillo.
# Date: December 18, 2021.
#

library(shiny)
library(lubridate)
library(dplyr)

# Define server logic 
shinyServer(function(input, output) {
 
  # Reading data from local file (see Code.R to know how to download data directly from Google)
  gm <- read.csv(file = "./GoogleData/Global_Mobility_Report_Peru.csv")
  
  # Changing format
  gm$date <- as.Date(gm$date)
  
  # Selecting only weekdays
  gm$week <- wday(gm$date)
  gm_w <- gm[gm$week>1 & gm$week<7,]
  
    selected_trends <- reactive(select(gm, input$type, date))
    selected_trends_wd <- reactive(select(gm_w, input$type, date))
    
    output$lineplot <- renderPlot({
    if(input$weekdays){
        par(mar = c(4, 4, 1, 1))
        plot(y = selected_trends_wd()[,1], x = selected_trends_wd()$date, type = "l",
             xlab = "Date", ylab = "% Change from baseline", col="blue")
        axis.Date(1, at=seq(min(selected_trends_wd()$date), 
                            max(selected_trends_wd()$date), by="quarters"), format="%b-%Y")
        output$values <- renderPrint({
          c("Number of observations:", length(selected_trends_wd()[,1]))
        })
        
    } else{
        par(mar = c(4, 4, 1, 1))
        plot(y = selected_trends()[,1], x = selected_trends()$date, type = "l",
        xlab = "Date", ylab = "% Change from baseline", xaxt = "n")
        axis.Date(1, at=seq(min(selected_trends()$date), 
                            max(selected_trends()$date), by="quarters"), format="%b-%Y")
        output$values <- renderPrint({
          c("Number of observations:", length(selected_trends()[,1]))
        })
    }
    })

    # Pull in description of the Data Base, Author and Date.
    output$desc <- renderText({
        "According to Google, Community Mobility Reports aim to provide insights into what has changed 
        in response to policies aimed at combating COVID-19. The reports chart movement 
        trends over time by geography, across different categories of places such as retail 
        and recreation, groceries and pharmacies, parks, transit stations, workplaces,
        and residential."
    })
    output$author<- renderText({
      "Author: Karl Melgarejo Castillo."
    })
    output$date<- renderText({
        "Date: December 18, 2021."
    })
})
