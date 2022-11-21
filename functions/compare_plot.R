# Function to plot education indexes.

compare_plot <- function(etapa,municipios){
  
  load("data/ideb_new.RData")
  
  plot_temporal <- filter(ideb_new, NIVEL == etapa, NO_MUNICIPIO %in% municipios)
  
  t <- list(
    family = "Helvetica",
    size = 12)
  
  
  title <- paste("")
  
  compare_plot <- plot_ly(plot_temporal, 
                         x = ~ano, 
                         y = ~ideb,
                         color = ~NO_MUNICIPIO,
                         type = 'scatter', 
                         mode = 'lines', 
                         line = list(width = 4))%>%
    add_trace(x = ~ano, 
              y = ~ideb,
              color = ~NO_MUNICIPIO,
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
           toImageButtonOptions = list(filename = "comparacao_ideb.png"))
  return(compare_plot)
}