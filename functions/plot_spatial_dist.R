# Function: Spatial distribution

plot_spatial_dist <- function(map, ideb){
  ser_merged<- geo_join(map, 
                       ideb, 
                       by_sp ="CD_GEOCODM", 
                       by_df ="CO_MUNICIPIO")
  
  pal <- colorNumeric(palette = c("#F8C301","#0F3072"), 
                      domain = ser_merged@data$IDEB_VALIDO)
  
  # Legendas ao passar o mouse
  
  mytext <- paste(
    "Município: ", ser_merged@data$NO_MUNICIPIO,"<br/>", 
    "Ideb: ", ser_merged@data$IDEB_VALIDO, 
    sep="") %>%
    lapply(htmltools::HTML)
  
  dist_map <- leaflet(data = ser_merged) %>%
    addTiles %>%
    addPolygons(fillColor = ~pal(IDEB_VALIDO), fillOpacity = 0.7,
                color = "#525252", 
                weight = 1,
                layerId = ~NO_MUNICIPIO,
                label = mytext,
                labelOptions = labelOptions( 
                  style = list("font-weight" = "normal", padding = "3px 8px"), 
                  textsize = "12px", 
                  direction = "auto")) %>%
    addLegend("bottomright", 
              pal = pal, 
              values = ~IDEB_VALIDO,
              title = "Ideb",
              opacity = 0.7)
  return(dist_map)
}