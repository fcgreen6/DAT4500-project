library(tidyverse)
library(ggplot2)
library(PL94171)
library(alarmdata)
library(ggredist)
library(redist)



map_ny <- alarm_50state_map('NY')
plans_ny <- alarm_50state_plans('NY')


map_ny |> 
  ggplot() +
  geom_district(aes(group = cd_2020, fill = ndv, denom = nrv + ndv)) +
  scale_fill_party_c() +
  theme_map()

map_mo <- alarm_50state_map('MO')
plans_mo <- alarm_50state_plans('MO')



map_mo |> 
  ggplot() +
  geom_district(aes(group = cd_2020, fill = ndv, denom = nrv + ndv)) +
  scale_fill_party_c() +
  theme_map()
