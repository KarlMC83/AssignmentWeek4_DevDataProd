#
# This is the user-interface definition of a Shiny web application.
# Author: Karl Melgarejo Castillo.
# Date: December 18, 2021.

library(shiny)
library(shinythemes)
library(dplyr)
library(readr)
library(lubridate)


## Define UI
shinyUI(fluidPage(theme = shinytheme("lumen"),

    # Application title
    titlePanel("PERU: Google COVID-19 Community Mobility Trends"),

    # Documentation about the APP              
    fluidRow(includeText("Documentation.txt")),
    fluidRow(includeText("Documentation1.txt")),
    fluidRow(includeText("Documentation2.txt")),
    
    # Sidebar with a check box
    sidebarLayout(
        sidebarPanel(
        
        # Select type of indicator to plot
            selectInput(inputId = "type", label = strong("Mobility indicator"),
                        #choices = unique(colnames(gm[10:15])),
                        #selected = colnames(gm[10:10])),
                        choices = c("retail_and_recreation_percent_change_from_baseline",
                                    "grocery_and_pharmacy_percent_change_from_baseline", 
                                    "parks_percent_change_from_baseline", 
                                    "transit_stations_percent_change_from_baseline",
                                    "workplaces_percent_change_from_baseline"),
                        selected = "retail_and_recreation_percent_change_from_baseline"),
                        
            verbatimTextOutput('values'),
            
            # Select whether to plot only weekdays
            checkboxInput(inputId = "weekdays", label = strong("Show data only for weekdays."), value = FALSE),
        
        # Display only if 'weekdays' is checked
        conditionalPanel(condition = "input.weekdays == true",
                         HTML("Removing weekends helps to visualize the trend.")
                        )
        ),
        mainPanel(
            plotOutput(outputId = "lineplot", height = "300px"),
            textOutput(outputId = "desc"),
            tags$a(href = "https://www.google.com/covid19/mobility/", "Source: Google LLC 'Google COVID-19 Community Mobility Reports'.", target = "_blank"),
            textOutput(outputId = "author"),
            textOutput(outputId = "date")
        )
        
)))
