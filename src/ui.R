library(shiny)
library(leaflet)
library(tidyverse)


ui <- fluidPage(
  
  sidebarLayout(
    
    # sidebar -------------------------------------------------------------
    sidebarPanel(
      
      titlePanel("Reported UFO Sightings Across Canada"),
      
      sliderInput("latitude", "Latitude", min = 40, max = 80, value = c(49, 49.5)),
      
      sliderInput("longitude", "Longitude", min = -140, max = -50, value = c(-123, -122)),
      
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
      leafletOutput("ufosightings", height = 600),
      
      hr(),
      
      fluidRow(
        
        column(6,
               plotOutput("total_sightings")
        )
        
      )
      
    
    )
    
  )
)