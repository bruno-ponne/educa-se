# Libraries:
library(shiny)
library(leaflet)
library(raster)
library(readr)
library(sp)
library(tigris)
library(plotly)
library(tidyverse)

# Functions:
source("functions/plot_spatial_dist.R")
source("functions/plot_series.R")
source("functions/plot_censo.R")

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




htmlTemplate("index.html", municipalities = cod_mun_SE)