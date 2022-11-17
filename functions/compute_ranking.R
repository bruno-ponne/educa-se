# Function to plot kmeans clusters and ranking


compute_ranking <- function(municipality){

  load("data/dados_municipio.RData")
  
  set.seed(42)
  
  dados_municipio$pop_ln = log(dados_municipio$pop_2019)
  
  sergipe_kmeans <- kmeans(x = scale(dados_municipio[,c(7,13)]), 
                           centers = 4,
                           nstart = 100)
  
  dados_municipio$cluster <- paste("Grupo", sergipe_kmeans$cluster)
  
  rank <- dados_municipio %>% 
    arrange(cluster, ideb_valido) %>%
    group_by(cluster) %>% 
    mutate(rank = round(rank(-ideb_valido)), g_total = n()) %>% 
    select(co_mun, mun, pop_ln, inv_pc, ideb_valido, cluster, rank, g_total)
  
  rank$grupo <- -1
  rank$grupo[rank$cluster == "Grupo 1"] <- "população pequena/gasto médio"
  rank$grupo[rank$cluster == "Grupo 2"] <- "população grande/gasto baixo"
  rank$grupo[rank$cluster == "Grupo 3"] <- "população pequena/gasto alto"
  rank$grupo[rank$cluster == "Grupo 4"] <- "população média/gasto médio"
  
  colors <- c("#F8C301","#0F3072", "#43923E", "#d73027")
  
  data <- filter(rank, mun == municipality)
  
  a <- list(
    x = data$pop_ln,
    y = data$inv_pc,
    text = paste(municipality," (", data$ideb_valido, ")", " - ", "Posição: ", data$rank, "º entre ", data$g_total, " municípios.", sep = ""),
    xref = "x",
    yref = "y",
    axref = "x",
    ayref = "y",
    showarrow = TRUE,
    arrowhead = 4,
    arrowsize = .5,
    ax = 11,
    ay = 2250,
    font = list(size = 14)
  )
  
  
  
  p <- plot_ly(rank,
          x = ~pop_ln, 
          y = ~inv_pc,
          color= ~as.factor(grupo),
          colors = colors,
          type = 'scatter',
          text = ~mun,
          marker = list(size = 10),
          mode = 'markers',
          hoverinfo = "text") %>%
    layout(yaxis = list(title = "Gasto com educação (R$ per capita)"), 
           xaxis = list(title = "População (logaritmo natural)"),
           legend = list(orientation = "h",
                         xanchor = "center",
                         y = -0.2,
                         x = 0.5),
           annotations = a) %>%
    config(modeBarButtons = list(list("toImage")), 
           displaylogo = FALSE, 
           toImageButtonOptions = list(filename = "gráfico_educase"))
  
  return(p)
}

