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
data('raccoon', package = 'sftrack')
#raccoon <- read.csv(system.file('extdata/raccoon_data.csv', package='sftrack'))
raccoon$month <- as.POSIXlt(raccoon$timestamp)$mon+1

raccoon$time <- as.POSIXct(raccoon$timestamp, tz='EST')
coords = c('longitude','latitude')
group = list(id = raccoon$animal_id, month = as.POSIXlt(raccoon$timestamp)$mon+1)
time = 'time'
error = 'fix'
crs = '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs '
# create a sftrack object
my_sftrack <- as_sftrack(data = raccoon, coords = coords, group = group, time = time, error = error, crs = crs)

# create a sftraj object
my_sftraj <- as_sftraj(data = raccoon, coords = coords, group = group, time = time, error = error, crs = crs)


## -----------------------------------------------------------------------------
attributes(my_sftrack)[-(1:2)]

## -----------------------------------------------------------------------------
my_sftrack$geometry

## -----------------------------------------------------------------------------
  df1 <- data.frame(
    id = c(1, 1, 1, 1,1,1),
    month = c(1,1,1,1,1,1),
    x = c(27, 27, 27, NA,29,30),
    y = c(-80,-81,-82,NA, 83,83),
    timez = as.POSIXct('2020-01-01 12:00:00', tz = 'UTC') + 60*60*(1:6)
  )

  test_sftraj <- as_sftraj(data = df1,group=list(id=df1$id, month = df1$month),
    time = df1$timez, active_group = c('id','month'), coords = df1[,c('x','y')])
  test_sftraj$geometry

## -----------------------------------------------------------------------------
attributes(my_sftrack$sft_group[1:10])
summary(my_sftrack)

## -----------------------------------------------------------------------------

my_sftrack[1:10,]

## -----------------------------------------------------------------------------

my_sftrack[1:3,c(1:3)]

## -----------------------------------------------------------------------------
my_sftrack[1:3,c(1:3), drop = TRUE]

## -----------------------------------------------------------------------------
plot(my_sftraj, main = "Original")
new_traj <- my_sftraj[seq(10,nrow(my_sftraj),10),]

plot(new_traj, main = "Before recalculation")

plot(step_recalc(new_traj),  main = "After recalculation")

## -----------------------------------------------------------------------------

print(my_sftrack,5,10)

## -----------------------------------------------------------------------------
summary(my_sftrack)

## -----------------------------------------------------------------------------
summary_sftrack(my_sftrack)


## -----------------------------------------------------------------------------
summary(my_sftrack, stats = TRUE)

