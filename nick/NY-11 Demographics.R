library(tidyverse)
library(ggplot2)
library(PL94171)
library(alarmdata)
library(ggredist)
library(redist)
library(tidycensus)
library(tigris)
library(sf)

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

get_acs(
  geography = "state",
  variables = "B01003_001",
  year = 2022
)

vars <- c(
  total = "B01003_001",
  white = "B02001_002",
  black = "B02001_003",
  hispanic = "B03003_003"
)

acs_data <- get_acs(
  geography = "tract",
  variables = vars,
  state = "NY",
  year = 2022,
  geometry = TRUE
)

ny11_demo <- st_intersection(acs_data, ny11_current)

ny11_demo_wide <- ny11_demo |>
  select(GEOID, variable, estimate, geometry) |>
  pivot_wider(names_from = variable, values_from = estimate) |>
  mutate(
    minority_pct = 1 - (white / total)
  )

ggplot(ny11_demo_wide) +
  geom_sf(aes(fill = minority_pct), color = NA) +
  scale_fill_viridis_c(labels = scales::percent) +
  labs(
    title = "Minority Population Share in NY District 11",
    fill = "% Minority"
  )











