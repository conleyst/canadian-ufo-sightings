library(shiny)
library(leaflet)
library(tidyverse)
library(plotly)
library(shinythemes)

ui <- fluidPage(theme = shinytheme("cosmo"),
  
  sidebarLayout(
    
    # sidebar -------------------------------------------------------------
    sidebarPanel(
      
      titlePanel("Canadian UFO Sightings"),
      
      "Mapping reported UFO Sightings from Sept. 15, 1936 to May 6, 2014.",
      
      sliderInput("latitude", "Latitude", min = 40, max = 80, value = c(40, 80)),
      
      sliderInput("longitude", "Longitude", min = -140, max = -50, value = c(-140, -50)),
      
      checkboxGroupInput("shape", 
                         "Shapes Reported Seen:", 
                         c("Spherical", "Cylindrical", "Light", "Disk/Circle", "Square/Rectangular", "Fireball", "Triangular", "Formation", "Unknown", "Other"),
                         c("Spherical", "Cylindrical", "Light", "Disk/Circle", "Square/Rectangular", "Fireball", "Triangular", "Formation", "Unknown", "Other")
                         ),
      
      dateInput("from", "Date of Earliest Sighting Displayed:", value = "1936-09-15", min = "1936-09-15", max = "2014-05-06"),
      
      dateInput("until", "Date of Latest Sighting Displayed", value = "2014-05-06", min = "1936-09-15", max = "2014-05-06")
      
    ),

    # main panel ----------------------------------------------------------
    mainPanel(
      leafletOutput("ufosightings", height = 500),
      
      hr(),
      
      fluidRow(

        plotlyOutput("sightings")
        
      )
      
    
    )
    
  )
)