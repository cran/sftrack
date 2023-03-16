## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
    echo = TRUE,
    fig.width = 6,
    fig.asp = 0.7
)


## -----------------------------------------------------------------------------
library("sftrack")

#data
data("raccoon", package = "sftrack")

#xyz
coords <- raccoon[,c("longitude", "latitude")]
crs <- 4326
#groupings
group <- list(id = raccoon$animal_id,month = as.POSIXlt(raccoon$timestamp)$mon+1)
active_group <- c("id","month")
#time
time <- as.POSIXct(raccoon$timestamp, tz = "EST")
#error
error <- raccoon$fix
my_sftrack <- as_sftrack(data = raccoon, coords = coords, group = group, 
                         active_group = active_group, time = time, 
                         crs = crs, error = error)

head(my_sftrack)


## -----------------------------------------------------------------------------
raccoon$time <- as.POSIXct(raccoon$timestamp, tz = "EST")
raccoon$month <- as.POSIXlt(raccoon$timestamp)$mon + 1

coords <- c("longitude", "latitude")
group <- c(id = "animal_id", month = "month")
time <- "time"
error <- "fix"

my_sftraj <- as_sftraj(data = raccoon, coords = coords, group = group, time = time, error = error)

head(my_sftraj)

## ---- message = FALSE---------------------------------------------------------
library("adehabitatLT")

ltraj_df <- as.ltraj(xy = raccoon[,c('longitude','latitude')], date = as.POSIXct(raccoon$timestamp),
 id = raccoon$animal_id, typeII = TRUE,
 infolocs = raccoon[,1:6])

my_sf <- as_sftrack(ltraj_df)
head(my_sf)


## -----------------------------------------------------------------------------
library("sf")
df1 <- raccoon[!is.na(raccoon$latitude),]
sf_df <- st_as_sf(df1, coords=c("longitude","latitude"), crs = crs)
group <- c(id = "animal_id")
time_col <- "time"

new_sftraj <- as_sftraj(sf_df, group = group, time = time_col) 
head(new_sftraj)

new_sftrack <- as_sftrack(sf_df, group = group, time = time_col) 
head(new_sftrack)


## -----------------------------------------------------------------------------
# Make tracks from raw data
coords <- c("longitude","latitude")
group <- c(id = "animal_id", month = "month")
time <- "time"
error <- "fix"

my_sftraj <- as_sftraj(data = raccoon, coords = coords, group = group, time = time, error = error)
my_sftrack <- as_sftrack(data = raccoon, coords = coords, group = group, time = time, error = error)

# Convert between types
new_sftrack <- as_sftrack(my_sftraj)
#head(new_sftrack)
new_sftraj <- as_sftraj(my_sftrack)
#head(new_sftraj)

identical(my_sftraj,new_sftraj)
identical(my_sftrack,new_sftrack)

## -----------------------------------------------------------------------------

raccoon$time[1] <- raccoon$time[2]
try(as_sftrack(data = raccoon, coords = coords, group = group, time = time, error = error))


## -----------------------------------------------------------------------------

which_duplicated(data = raccoon , group = group, time = time)
raccoon <- raccoon[-2,]
my_sftrack <- as_sftrack(data = raccoon, coords = coords, group = group, time = time, error = error)


