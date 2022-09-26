# Libraries:
library(shiny)
library(readr)
library(plotly)
library(dplyr)

# Functions

source("functions/plot_series.R")
source("functions/plot_censo.R")

# Data
load("data/dados_municipio.RData")
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
intro_text <- 'data/intro.txt'

dados_municipio$inv_pc <- round(dados_municipio$inv_pc)
dados_municipio$pib_pc <- round(dados_municipio$pib_pc*1000)


shinyServer(function(input, output, session) {
  output$intro_text <- renderText(readChar(intro_text, file.info(intro_text)$size))
  
  observeEvent(input$Sel_municipio, {
    output$p <- renderText(input$Sel_municipio)
    output$mun_censo <- renderText(paste("Dados do Censo Escolar -", input$Sel_municipio))
    output$ideb <- renderText(dados_municipio$ideb_valido[dados_municipio$mun == input$Sel_municipio])
    output$pop <- renderText(dados_municipio$pop_2019[dados_municipio$mun == input$Sel_municipio])
    output$inv <- renderText(paste("R$", dados_municipio$inv_pc[dados_municipio$mun == input$Sel_municipio]))
    output$pib <- renderText(paste("R$", dados_municipio$pib_pc[dados_municipio$mun == input$Sel_municipio]))
    output$ideb_time <- renderPlotly(plot_series(input$Sel_municipio))
    output$censo_01 <- renderPlotly(plot_censo("bibliotecas", ind_01_library, input$Sel_municipio, c(0,100)))
    output$censo_02 <- renderPlotly(plot_censo("quadras de esportes", ind_02_sports_court, input$Sel_municipio, c(0,100)))
    output$censo_03 <- renderPlotly(plot_censo("laboratório de ciências", ind_03_sci_lab, input$Sel_municipio, c(0,100)))
    output$censo_04 <- renderPlotly(plot_censo("laboratório de informática", ind_04_computer_lab, input$Sel_municipio, c(0,100)))
    output$censo_05 <- renderPlotly(plot_censo("banheiro PNE", ind_05_handicap_restroom, input$Sel_municipio, c(0,100)))
    output$censo_06 <- renderPlotly(plot_censo("total de funcionários", ind_06_number_employees, input$Sel_municipio, c(0,100)))
    
    
  })
  
  output$downloadData <- downloadHandler(
    filename <- function() {paste("panorama", "pdf", sep = ".")},
    
    content <- function(file) {
      file.copy("panorama_sergipe.pdf", file)
    },
    contentType = "application/pdf"
  )
  
  # Solves problem that makes the page go idle every 55 seconds.
  autoInvalidate <- reactiveTimer(10000)
  observe({
    autoInvalidate()
    cat(".")
  })
  
  
  
})