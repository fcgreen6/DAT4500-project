library(alarmdata)
library(tidyverse)
library(sf)
sf_use_s2(FALSE)

BlockManager <- local({
  
  retVal <- new.env()

  retVal$GetBlocks <- function(inName) {
    
    newBlocks <- alarm_50state_map(inName)
    
    newBlocks <- st_sf(
      GEOID = newBlocks$GEOID,
      geometry = st_geometry(newBlocks),
      crs = st_crs(newBlocks)
    )
    
    return(newBlocks)
  }
  
  retVal$JoinByGeoid <- function(inSf, inData) {
    inSf <- left_join(inSf, inData, by = "GEOID")
    return(inSf)
  }
  
  retVal$ConsolodateDistricts <- function(districtSf, blockSf) {
    
    districtSf <- st_make_valid(districtSf)
    centrailizedBlocks <- st_make_valid(blockSf)
    centrailizedBlocks <- st_transform(centrailizedBlocks, st_crs(districtSf))
    centrailizedBlocks <- st_point_on_surface(centrailizedBlocks)
    
    districtSf <- st_join(
      districtSf,
      centrailizedBlocks,
      join = st_intersects
    )
    
    districtSf <- districtSf |>
      group_by(DISTRICT) |>
      summarize(across(where(is.numeric), sum, na.rm = TRUE))
    
    return(districtSf)
  }
  
  retVal
})