library(descr)
library(dplyr)

load("ranking.RData")
load("censo_ne.RData")

censo_se <- censo_ne %>% filter(state_abbr == "SE")

censo_se$municipality_code[censo_se$year<2007] <- paste(
  substr(censo_se$municipality_code,1,2),
  substr(censo_se$municipality_code,8,12),
  sep = "")

# Filtering only municipal schools

censo_se <- filter(censo_se, type == 3, year > 2004)

# Standardizing municipality names
censo_se$municipality_code <- as.numeric(censo_se$municipality_code)

censo_se <- left_join(censo_se, RANKING, by = c("municipality_code"="CO_MUNICIPIO"))


ind_01_library <-  censo_se %>%
  dplyr::group_by(municipality_code, NO_MUNICIPIO, year) %>% 
  dplyr::summarise(library = mean(library=="1", na.rm = TRUE)*100)

ind_02_sports_court <-  censo_se %>%
  dplyr::group_by(municipality_code,NO_MUNICIPIO, year) %>% 
  dplyr::summarise(sports_court = mean(sports_court=="1", na.rm = TRUE)*100)

ind_03_sci_lab <-  censo_se %>%
  dplyr::group_by(municipality_code, NO_MUNICIPIO,year) %>% 
  dplyr::summarise(sci_lab  = mean(sci_lab =="1", na.rm = TRUE)*100)

ind_04_computer_lab <-  censo_se %>%
  dplyr::group_by(municipality_code, NO_MUNICIPIO,year) %>% 
  dplyr::summarise(computer_lab = mean(computer_lab =="1", na.rm = TRUE)*100)


ind_05_handicap_restroom<-  censo_se %>%
  dplyr::group_by(municipality_code, NO_MUNICIPIO, year) %>% 
  dplyr::summarise(handicap_restroom = mean(handicap_restroom =="1", na.rm = TRUE)*100)

ind_06_number_employees<-  censo_se %>%
  dplyr::group_by(municipality_code, NO_MUNICIPIO, year) %>% 
  dplyr::summarise(number_employees = mean(number_employees, na.rm = TRUE))

save(ind_01_library, file = "ind_01_library.RData")
save(ind_02_sports_court, file = "ind_02_sports_court.RData")
save(ind_03_sci_lab, file = "ind_03_sci_lab.RData")
save(ind_04_computer_lab, file = "ind_04_computer_lab.RData")
save(ind_05_handicap_restroom, file = "ind_05_handicap_restroom.RData")
save(ind_06_number_employees, file = "ind_06_number_employees.RData")


