## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
    echo = TRUE,
    fig.width = 6,
    fig.asp = 0.7
)
library("lwgeom")


## -----------------------------------------------------------------------------
library("sftrack")
# Make tracks from raw data
# raccoon <- read.csv(system.file('extdata/raccoon_data.csv', package='sftrack'))
data("raccoon", package = "sftrack")
raccoon$month <- as.POSIXlt(raccoon$timestamp)$mon + 1

raccoon$time <- as.POSIXct(raccoon$timestamp, tz = "EST")
coords <- c("longitude","latitude")
group <- list(id = raccoon$animal_id, month = as.POSIXlt(raccoon$timestamp)$mon+1)
time <- "time"
error <- "fix"
crs <- 4326
my_sftrack <- as_sftrack(data = raccoon, coords = coords, group = group, time = time, error = error, crs = crs)
my_sftraj <- as_sftraj(data = raccoon, coords = coords, group = group, time = time, error = error, crs = crs)

## -----------------------------------------------------------------------------
my_sftrack$geometry

## -----------------------------------------------------------------------------
my_sftraj$geometry

## -----------------------------------------------------------------------------
library("sf")
st_length(my_sftraj)[1:10]

df1 <- data.frame(
  id = c(1, 1, 1, 1),
  time = as.POSIXct("2020-01-01 12:00:00", tz = "UTC") + 60*60*(1:4),
  x = c(1, 3, 3, 2),
  y = c(1, 1, 3, 4)
)

road <- st_linestring(rbind(
  c(1, 2),
  c(5, 2),
  c(5, 0)
)
)

animal1 <- as_sftraj(df1)
plot(animal1)

plot(road,  col = "red", add = TRUE)

# Does the animal cross the road?

any(st_intersects(animal1, road, sparse = FALSE))

# When?
animal1$time[st_intersects(animal1, road, sparse = FALSE)]

# How often does the animal stay near the road?
st_is_within_distance(animal1, road, 1)

# How close is the animal from the road?

st_distance(animal1, road)

## -----------------------------------------------------------------------------
plot(my_sftraj)
plot(my_sftraj, key.pos = 4, key.width = lcm(4), key.length = 1)
get_key_pos(my_sftraj)

## -----------------------------------------------------------------------------
active_group(my_sftraj$sft_group) <- "id"
active_group(my_sftraj$sft_group)
plot(my_sftraj)

## -----------------------------------------------------------------------------
plot(my_sftrack, axes = TRUE, cex = 5)

## -----------------------------------------------------------------------------
library("ggplot2")
ggplot() + geom_sftrack(data = my_sftraj)

## -----------------------------------------------------------------------------

cols <- c("TTP-041_1" = "dodgerblue1", "TTP-041_2" = "darkseagreen2",
          "TTP-058_1" = "darkorchid1", "TTP-058_2" = "khaki3")

ggplot() + geom_sftrack(data = my_sftrack, size = 3, alpha = 0.5) +
scale_color_manual(values = cols) + 
  ggtitle("Raccoons at Tree Tops Park Winter 2020") +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

## -----------------------------------------------------------------------------
library("ggplot2")
ggplot() + geom_sftrack(data = my_sftraj, step_mode = TRUE)

## -----------------------------------------------------------------------------
coord_traj(my_sftraj$geometry)[1:10, ]

## -----------------------------------------------------------------------------
pts_traj(my_sftraj$geometry)[1:5]

pts_traj(my_sftraj$geometry, sfc= TRUE)[1:5]

## -----------------------------------------------------------------------------
is_linestring(my_sftraj$geometry)[1:10]
new_sftraj <- my_sftraj[is_linestring(my_sftraj$geometry), ]
head(new_sftraj)

## -----------------------------------------------------------------------------
step_metrics(my_sftraj[1:10, ])

