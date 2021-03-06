% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_util.R
\name{traj_geom}
\alias{traj_geom}
\alias{pts_traj}
\alias{coord_traj}
\title{Return a list of sf_POINTS or a data.frame from a sftraj object}
\usage{
pts_traj(traj, sfc = FALSE)

coord_traj(traj)
}
\arguments{
\item{traj}{a trajectory geometery from sf_traj}

\item{sfc}{TRUE/FALSE should the return by an sfc or a list of points. Defaults to FALSE}
}
\description{
Return a list of sf_POINTS or a data.frame from a sftraj object
}
\examples{
#'
data("raccoon")
raccoon$timestamp <- as.POSIXct(raccoon$timestamp, "EST")
burstz <- list(id = raccoon$animal_id, month = as.POSIXlt(raccoon$timestamp)$mon)
# Input is a data.frame
my_traj <- as_sftraj(raccoon,
  time = "timestamp",
  error = NA, coords = c("longitude", "latitude"),
  group = burstz
)
print(my_traj, 5, 10)

# extract a list of points
pts_traj(my_traj)[1:10]

# or a data.frame of points
coord_traj(my_traj)[1:10]
}
