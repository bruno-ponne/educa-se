library(readxl)
library(dplyr)
library(tidyr)
library(plotly)


ideb_se <- read_excel("ideb_se.xlsx")

ideb_se$'2005' <- as.numeric(ideb_se$'2005' )
ideb_se$'2007' <- as.numeric(ideb_se$'2007' )
ideb_se$'2009' <- as.numeric(ideb_se$'2009' )
ideb_se$'2011' <- as.numeric(ideb_se$'2011' )
ideb_se$'2013' <- as.numeric(ideb_se$'2013' )
ideb_se$'2015' <- as.numeric(ideb_se$'2015' )
ideb_se$'2017' <- as.numeric(ideb_se$'2017' )
ideb_se$'2019' <- as.numeric(ideb_se$'2019' )
ideb_se$NIVEL[ideb_se$NIVEL == "AI"] <- "anos iniciais"
ideb_se$NIVEL[ideb_se$NIVEL == "AF"] <- "anos finais"


ideb_se_long <- ideb_se %>% gather(ano, ideb, '2005':'2019')

ideb_amparo <- filter(ideb_se_long, NO_MUNICIPIO == "Amparo de São Francisco")

plot_ly(ideb_amparo, 
        x = ~ano, 
        y = ~ideb,
        color = ~NIVEL,
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
  layout(yaxis = list(gridcolor = "#bdbdbd",
                      title = "Ideb"), 
         xaxis = list(showgrid = FALSE,
                      title = "Ano "),
         title = list(text="Evolução do Ideb - Ensino Fundamental"),
         plot_bgcolor = "white",
         paper_bgcolor = "white")
