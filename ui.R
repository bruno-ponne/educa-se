# Libraries:
library(shiny)
library(readr)
library(plotly)
library(tidyverse)


# Data
load("data/dados_municipio.RData")
load("data/ind_01_library.RData")
load("data/ind_02_sports_court.RData")
load("data/ind_03_sci_lab.RData")
load("data/ind_04_computer_lab.RData")
load("data/ind_05_handicap_restroom.RData")
load("data/ind_06_number_employees.RData")
cod_mun_SE <- read_delim("data/cod_mun_se.csv", ";", escape_double = FALSE, trim_ws = TRUE)
names(cod_mun_SE) <- c("CO_MUNICIPIO", "NO_MUNICIPIO")
intro_text <- 'data/intro.txt'




htmlTemplate("index.html", municipalities = cod_mun_SE)