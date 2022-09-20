library(readxl)
library(dplyr)
library(tidyr)



ideb_se <- read_excel("ideb_se.xlsx")

ideb_se$NO_MUNICIPIO[ideb_se$NO_MUNICIPIO=="Amparo de São Francisco"] <- "Amparo do São Francisco"

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

save(ideb_se_long, file = "ideb_se.RData")