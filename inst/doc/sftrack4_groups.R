## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
    echo = TRUE,
    fig.width = 6,
    fig.asp = 0.7
)


## -----------------------------------------------------------------------------
library("sftrack")
data('raccoon', package = 'sftrack')
#raccoon <- read.csv(system.file('extdata/raccoon_data.csv', package='sftrack'))
group_list = list(id = raccoon$animal_id, month = as.POSIXlt(raccoon$timestamp)$mon+1)

cg1 <- make_c_grouping(x=group_list, active_group=c('id','month'))
str(cg1)
cg1[[1]]

## -----------------------------------------------------------------------------

singlegroup <- make_s_group(list(id='TTP_058', month = 4))
str(singlegroup)

## -----------------------------------------------------------------------------
singlegroup 
singlegroup[1] <- 'CJ15'
singlegroup$month <- '5'
str(singlegroup)

## -----------------------------------------------------------------------------
group_list <- list(id = rep(1:2,10), year = rep(2020, 10))
cg <- make_c_grouping(x=group_list, active_group=c('id','year'))
str(cg)

## -----------------------------------------------------------------------------
a <- make_s_group(list(id = 1, year = 2020))
b <- make_s_group(list(id = 1, year = 2021))
c <- make_s_group(list(id = 2, year = 2020))
cg <- c(a, b , c)

summary(cg)

## -----------------------------------------------------------------------------
cg_combine <- c(cg,cg)
summary(cg_combine)

## -----------------------------------------------------------------------------
cg[1]
cg[1] <- make_s_group(list(id=3,year=2019))
cg[1]


## -----------------------------------------------------------------------------
# Try to add an s_group with a month field when the original group had year instead 
try( cg[1] <- make_s_group(list(id=3,month=2019)) )

## -----------------------------------------------------------------------------
group_list <- list(id = rep(1:2,10), year = rep(2020, 10))
cg <- make_c_grouping(x=group_list, active_group=c('id','year'))
group_labels(cg)[1:10]

# Subsetting a particular sensor from our raccoon data

data('raccoon', package = 'sftrack')
raccoon$month <- as.POSIXlt(raccoon$timestamp)$mon+1

raccoon$time <- as.POSIXct(raccoon$timestamp, tz='EST')
coords = c('longitude','latitude')
group = list(id = raccoon$animal_id, month = as.POSIXlt(raccoon$timestamp)$mon+1)
time = 'time'

my_sftraj <- as_sftraj(data = raccoon, coords = coords, group = group, time = time)
head(my_sftraj[group_labels(my_sftraj) %in% c('TTP-058_1'), ])



## -----------------------------------------------------------------------------
head(cg['1_2020'])

sub <- my_sftraj['TTP-058_1',]
print(sub,5, 3)

## -----------------------------------------------------------------------------
group_names(cg)

## -----------------------------------------------------------------------------
# sftrack
active_group(my_sftraj)
summary(my_sftraj, stats = T)

# change the active group to id only
active_group(my_sftraj) <- c('id')
active_group(my_sftraj)

summary(my_sftraj, stats = T)

# column groupings work the same way
active_group(cg)
active_group(cg) <- 'id'
active_group(cg)


