
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

buoydata <- read.csv('data/FormattedBuoyData.csv')

shinyUI(fluidPage(theme = "bootstrap.css",

  # Application title
  titlePanel("Water Quality Data Application"),

  # Sidebar with user input controls
  sidebarLayout( 
    sidebarPanel(
      selectInput(inputId='site', 
                  label=h3("Site"), 
                  choices=unique(buoydata$SiteName), 
                  selected = NULL, 
                  multiple = FALSE,
                  selectize = TRUE, 
                  width = NULL, 
                  size = NULL),
      selectInput(inputId='param', 
                  label=h3("Select parameter to plot: "), 
                  choices=list('Temperature'='Temperature_C',
                               'pH'='pH',
                               'Sp Conductance uS/cm'='SpCond_uS_cm'), 
                  selected = NULL, 
                  multiple = FALSE,
                  selectize = TRUE, 
                  width = NULL, 
                  size = NULL),
      dateRangeInput("dates", label = h3("Date range"))
    ),

    
    # Show outputs, text, etc. in the main panel
    mainPanel(
      textOutput("selected_var"),
      plotOutput("wqplot"),
      textOutput("modelresults")
    )
  )
))
