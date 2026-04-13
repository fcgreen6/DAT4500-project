library(tidyverse)
library(ggplot2)
library(PL94171)
library(alarmdata)
library(ggredist)
library(redist)
library(tidycensus)
library(tigris)


### New York and Missouri Maps
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

### New York District 11 Minority Voting Power 

ny_current <- congressional_districts(state = "NY", year = 2022)
ny_old <- congressional_districts(state = "NY", year = 2020)

ny11_current <-ny_current|>
  filter(CD118FP == "11")

ny11_old <- ny_old |>
  filter(CD116FP == "11")

ggplot() +
  geom_sf(data = ny11_old, fill = "white", alpha = 0.5) +
  geom_sf(data = ny11_current, fill = "red", alpha = 0.5) +
  labs(title = "NY District 11: Old vs New Boundaries",
       subtitle = "Blue = Old (2020), Red = New (2022)")


census_api_key("d84f6074a7e95b068d1dbc2a2daeb05bf6ab224b", install = TRUE)


