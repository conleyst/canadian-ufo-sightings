library(shiny)
library(leaflet)
library(tidyverse)
library(lubridate)
library(htmltools)
library(RColorBrewer)

# import previously cleaned data
ufo <- read_csv("../data/ufo_clean.csv")

# define a colour palette for map
colour_palette <- colorFactor(
  palette="Set3",
  domain=c("Cylindrical", "Light", "Disk/Circle", "Spherical", "Square/Rectangular", "Fireball", "Triangular", "Formation", "Unknown", "Other")
)

# extract the palette from the leaflet map to be used for the ggplot plots -- otherwise colours don't match if this isn't done manually
tmp <- ufo %>% 
  mutate(colour = colour_palette(shape)) %>% 
  select(shape, colour) %>% 
  unique()

col_pal <- tmp$colour
names(col_pal) <- tmp$shape

server <- function(input, output) {
  
  sightings <- reactive({
    ufo %>% 
      filter(
        shape %in% input$shape,
        date <= input$until,
        date >= input$from,
        latitude >= input$latitude[1],
        latitude <= input$latitude[2],
        longitude >= input$longitude[1],
        longitude <= input$longitude[2]
      )
    
  })
  
  
  output$ufosightings <- renderLeaflet({
    
    leaflet() %>% 
      addTiles() %>% 
      addRectangles(
        lng1=input$longitude[1], lat1=input$latitude[1],
        lng2=input$longitude[2], lat2=input$latitude[2],
        fillColor = "transparent"
      ) %>% 
      addLegend(
        "bottomright",
        pal = colour_palette,
        values = c("Spherical", "Cylindrical", "Light", "Disk/Circle", "Square/Rectangular", "Fireball", "Triangular", "Formation", "Unknown", "Other"),
        title = "Shapes Reported",
        opacity = 1)
    
  })  

  
  observe({
    
    leafletProxy("ufosightings", data = sightings()) %>%
      clearMarkers() %>% 
      addCircleMarkers(
        lng = ~disp_long,
        lat = ~disp_lat,
        radius = 5,
        color = ~colour_palette(shape),
        fillColor = ~colour_palette(shape),
        fillOpacity = 1,
        popup = ~paste("Shape:", shape, "<br>",
                      "Lat:", latitude, "<br>",
                      "Long:", longitude, "<br>",
                      "Date:", date)
      )
  
  })
  
  
  output$total_sightings <- renderPlot({

    sightings() %>% 
      mutate(date=year(date)) %>% 
      group_by(date, shape) %>%
      summarise(count = n()) %>% 
      ggplot(aes(x = date, y=count, colour=shape)) + 
      geom_line() + 
      scale_colour_manual(values = col_pal) + #scale_color_brewer(palette="Set3") + 
      theme_minimal() + 
      labs(title="Number of Reports in Defined Area Over Time", x="Years", y="Frequency")
  
  })
  

}
