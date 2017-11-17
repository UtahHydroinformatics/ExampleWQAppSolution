
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
buoydata <- read.csv('data/FormattedBuoyData.csv')
buoydata$DateTime <- as.Date(buoydata$DateTime,format="%m/%d/%Y")


shinyServer(function(input, output, session) {


  output$selected_var <- renderText({ 
    
    paste('Viewing water quality data at',input$site,'between',input$dates[1],'and',input$dates[2])
    
  })
  
  output$wqplot <- renderPlot({
    plotdata <- subset(buoydata,SiteName==input$site &
                         DateTime >= input$dates[1] &
                         DateTime<= input$dates[2])
    ggplot(data=plotdata,aes(x=plotdata$DateTime,y=plotdata[,input$param]))+
      geom_line()+xlab("Date")+ylab(input$param)+theme_bw()
  })
  
  chlmod <- reactive({
    plotdata <- subset(buoydata,SiteName==input$site &
                         DateTime >= input$dates[1] &
                         DateTime<= input$dates[2])
    mod <- lm(plotdata$Chlorophyll_ug_L~plotdata[,input$param])
    modsummary <- summary(mod)
    return(modsummary)
  })
 
  output$modelresults <- renderText({
    paste("R-Squared between Chlorophyll and",input$param," during this timeframe:",chlmod()$r.squared)
  })
})
