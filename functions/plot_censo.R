# Function to plot development of school infrastructure across time:

plot_censo <- function(variable, dataset, municipality, yminmax){
  library(plotly)
  ifelse(municipality == "Amparo do São Francisco", 
         municipality <- "Amparo de São Francisco",
         municipality <- municipality)
  ifelse(variable == "total de funcionários", ytitle <- variable,
         ytitle <- paste("%", variable))
  xtitle <- "Ano"
  
  font_ <- list(family = "Helvetica")
  
  data <- filter(dataset, NO_MUNICIPIO == municipality)
  data2 <- data.frame(data[,3], data[,4])
  names(data2) <- c("year", "yvariable")
  
  censo_plot <- plot_ly(data2,
                        x = ~year, 
                        y = ~yvariable,
                        type = 'scatter', 
                        mode = 'lines', 
                        line = list(color = "#F8C301", width = 4))%>%
    layout(yaxis = list(title = ytitle, range = yminmax), 
           xaxis = list(title = xtitle),
           plot_bgcolor = "white",
           paper_bgcolor = "white",
           font = font_) %>% 
    config(modeBarButtons = list(list("toImage")), 
           displaylogo = FALSE, 
           toImageButtonOptions = list(filename = "gráfico_educase"))
  
  return(censo_plot)
}
