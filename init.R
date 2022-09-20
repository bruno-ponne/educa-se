# init.R
#
# Example R code to install packages if not already installed
#
install.packages("terra")

my_packages = c("leaflet", "raster", "readr", "sp", "tigris", "plotly", "tidyverse", "shiny")

install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p)
  }
}

invisible(sapply(my_packages, install_if_missing))
