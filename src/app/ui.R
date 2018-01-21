library(shiny)
library(leaflet)
library(tidyverse)


ui <- fluidPage(
  
  sidebarLayout(
    
    # sidebar -------------------------------------------------------------
    sidebarPanel(
      
      titlePanel("Reported UFO Sightings Across Canada"),
      
      sliderInput("latitude", "Latitude", min = 40, max = 80, value = c(40, 80)),
      
      sliderInput("longitude", "Longitude", min = -140, max = -50, value = c(-140, -50)),
      
      checkboxGroupInput("shape", 
                         "Shapes Reported Seen:", 
                         c("Spherical", "Cylindrical", "Light", "Disk/Circle", "Square/Rectangular", "Fireball", "Triangular", "Formation", "Unknown", "Other"),
                         c("Spherical", "Cylindrical", "Light", "Disk/Circle", "Square/Rectangular", "Fireball", "Triangular", "Formation", "Unknown", "Other")
                         ),
      
      dateInput("from", "Date of Earliest Sighting Displayed:", value = "1936-09-15"),
      
      dateInput("until", "Date of Latest Sighting Displayed", value = "2014-05-06")
      
    ),

    # main panel ----------------------------------------------------------
    mainPanel(
      leafletOutput("ufosightings", height = 500),
      
      hr(),
      
      fluidRow(
        plotOutput("total_sightings", height = 200),
        plotOutput("prop_sightings", height=200)
        
        # column(6, plotOutput("total_sightings")),
        # column(6, plotOutput("prop_sightings"))
        
      )
      
    
    )
    
  )
)