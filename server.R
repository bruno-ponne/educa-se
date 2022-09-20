# Libraries:
library(shiny)
library(readr)
library(plotly)
library(tidyverse)

# Functions


plot_series <- function(municipality){
  
  library(plotly)
  
  load("data/ideb_se.RData")
  
  data <- filter(ideb_se_long, NO_MUNICIPIO == municipality)
  
  colors <- c("#F8C301","#0F3072")
  
  t <- list(
    family = "Lato")
  
  
  title <- paste("Ideb - ", municipality, "- Ensino Fundamental")
  
  series_plot <- plot_ly(data, 
                         x = ~ano, 
                         y = ~ideb,
                         color = ~NIVEL,
                         colors = colors,
                         type = 'scatter', 
                         mode = 'lines', 
                         line = list(width = 4))%>%
    add_trace(x = ~ano, 
              y = ~ideb,
              color = ~NIVEL,
              type = 'scatter', 
              mode = 'lines', 
              line = list(width = 4, dash = "dash"),
              connectgaps = TRUE,
              showlegend = FALSE) %>% 
    layout(yaxis = list(title = "Ideb"), 
           xaxis = list(title = ""),
           legend = list(orientation = "h",
                         xanchor = "center",
                         x = 0.5),
           title = list(text=title),
           plot_bgcolor = "white",
           paper_bgcolor = "white",
           font = t) %>% 
    config(modeBarButtons = list(list("toImage")), 
           displaylogo = FALSE, 
           toImageButtonOptions = list(filename = "plotOutput.png"))
  return(series_plot)
}



# Data
sergipe <- shapefile("map/mapa_se.shp")
load("data/ranking.RData")
load("data/ideb_brasil.RData")
load("data/ideb_estados.RData")
load("data/ind_01_library.RData")
load("data/ind_02_sports_court.RData")
load("data/ind_03_sci_lab.RData")
load("data/ind_04_computer_lab.RData")
load("data/ind_05_handicap_restroom.RData")
load("data/ind_06_number_employees.RData")
cod_mun_SE <- read_delim("data/cod_mun_se.csv", ";", escape_double = FALSE, trim_ws = TRUE)
names(cod_mun_SE) <- c("CO_MUNICIPIO", "NO_MUNICIPIO")
RANKING$NO_MUNICIPIO[RANKING$NO_MUNICIPIO == "Amparo de São Francisco"] <- "Amparo do São Francisco"
intro_text <- 'data/intro.txt'

shinyServer(function(input, output, session) {
  output$ser_map <- renderLeaflet(plot_spatial_dist(sergipe, RANKING))
  
  output$intro_text <- renderText(readChar(intro_text, file.info(intro_text)$size))
  
  observeEvent(input$Sel_municipio, {
    output$p <- renderText(input$Sel_municipio)
    output$ideb <- renderText(RANKING$IDEB_VALIDO[RANKING$NO_MUNICIPIO == input$Sel_municipio])
    output$ideb_time <- renderPlotly(plot_series(input$Sel_municipio))
  })
  
  
  observeEvent(input$ser_map_shape_click, { # update the location selectInput on map clicks
    output$p <- renderText(input$ser_map_shape_click$id)
    output$ideb <- renderText(RANKING$IDEB_VALIDO[RANKING$NO_MUNICIPIO == input$ser_map_shape_click$id])
    output$ideb_time <- renderPlotly(plot_series(input$ser_map_shape_click$id))
    updateSelectInput(session, "Sel_municipio",
                      selected = input$ser_map_shape_click$id)
    
    
  })
  
  output$downloadData <- downloadHandler(
    filename <- function() {paste("panorama", "pdf", sep = ".")},
    
    content <- function(file) {
      file.copy("panorama_sergipe.pdf", file)
    },
    contentType = "application/pdf"
  )
  
  
  
})