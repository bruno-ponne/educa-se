# Function: plot_density

plot_density <- function(ideb_brasil, input){
  
  if(input$Sel_estado != "Brasil"){
    plotData <- ideb_brasil %>% 
      filter(NOME == "Sergipe" | NOME == input$Sel_estado)
  }
  else{
    plotData <- ideb_brasil
  }
  
  M1 <- round(mean(plotData$IDEB_2019[plotData$NO_UF != "SE"]), 2)
  M2 <- round(mean(plotData$IDEB_2019[plotData$NO_UF == "SE"]), 2)
  
  plot <- ggplot(data = plotData, aes(x= IDEB_2019, 
                                      color = NOME == "Sergipe", 
                                      fill = NOME == "Sergipe"))+
    geom_density(size = 1, alpha = 0.3)+
    scale_color_manual(name = "", 
                       labels = c(input$Sel_estado,"Sergipe"), 
                       values = c("#29166F","#F8C301"))+
    scale_fill_manual(name = "", 
                      labels = c(input$Sel_estado,"Sergipe"), 
                      values = c("#29166F","#F8C301"))+
    theme_bw()+
    xlab("Ideb 2019")+
    ylab("Densidade")+
    theme(axis.text.x = element_text(vjust = 0),
          legend.key = element_rect(fill = 'white'),
          legend.background = element_rect(fill = 'white'),
          legend.position = "bottom",
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_rect(fill = 'white', colour = 'white'),
          plot.background = element_rect(fill = 'white', colour = 'white'),
          axis.line = element_line(colour = "#bdbdbd"),
          axis.line.y = element_line(colour = '#e0dfe7'),
          axis.ticks.y = element_blank(),
          axis.text.y = element_blank(),
          axis.text = element_text(size = 13),
          text = element_text(size = 15, family = "Helvetica"))+
    guides(color = guide_legend(override.aes = list(collor = c("#29166F","#F8C301"), fill = c("#29166F","#F8C301"))))
  
  
  if(isTruthy(input$ShowStats) & 1 %in% input$ShowStats){
    plot <- plot + 
      geom_vline(xintercept = M1, size = 1, linetype = "dashed", color = "#29166F")+
      annotate("text", x = M1+0.5, y = 0.7, label = paste("média: ", M1), color = "#29166F", size = 5)+
      geom_vline(xintercept = M2, size = 1, linetype = "dashed", color = "#F8C301")+
      annotate("text", x = M2+0.5, y = 0.8, label = paste("média: ", M2), color = "#F8C301", size = 5)
  }
  
  return(plot)
}