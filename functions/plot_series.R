# Function to plot education indexes.


plot_series <- function(municipality){
  
  load("data/ideb_new.RData")
  
  data <- filter(ideb_new, NO_MUNICIPIO == municipality)
  
  colors <- c("#F8C301","#0F3072")
  
  t <- list(
    family = "Helvetica",
    size = 12)
  
  
  title <- paste("Ideb - ", municipality)
  
  series_plot <- plot_ly(data, 
                         x = ~ano, 
                         y = ~ideb,
                         color = ~NIVEL,
                         colors = colors,
                         type = 'scatter', 
                         mode = 'lines', 
                         line = list(width = 2))%>%
    add_trace(x = ~ano, 
              y = ~ideb,
              color = ~NIVEL,
              type = 'scatter', 
              mode = 'lines', 
              line = list(width = 2, dash = "dash"),
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