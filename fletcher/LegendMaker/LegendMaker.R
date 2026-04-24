LegendMaker <- local({
  retVal <- new.env()
  
  
  retVal$MakePointLegend <- function(inNames, inColors) {
    plot.new()
    legend(
      "center",
      legend = inNames,
      col = inColors,
      pch = 16,
      pt.cex = 3,
      y.intersp = 1.5
    )
  }
  
  retVal$MakeLineLegend <- function(inNames, inColors) {
    plot.new()
    legend(
      "center",
      legend = inNames,
      col = inColors,
      lty = 1,
      lwd = 6,
      y.intersp = 1.5
    )
  }
  
  retVal
})