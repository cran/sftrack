## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
    echo = TRUE,
    fig.width = 6,
    fig.asp = 0.7
)


## ---- out.width = "75%", fig.align = "center", fig.cap = "Fig.1: Glossary introducing the main concepts.", echo = FALSE----
knitr::include_graphics("glossary.png")


## ----sftrack-overview, echo = FALSE-------------------------------------------
library("sftrack")
data(raccoon)
raccoon$timestamp = as.POSIXct(raccoon$timestamp, tz = "EST5EDT")
my_sftrack <- as_sftrack(
  data = raccoon,
  coords = c("longitude","latitude"),
  time = "timestamp",
  group = "animal_id",
  crs = 4326)
head(my_sftrack)
plot(my_sftrack)


## ----sftraj-overview, echo = FALSE--------------------------------------------
my_sftraj <- as_sftraj(my_sftrack)
head(my_sftraj)
plot(my_sftraj)


