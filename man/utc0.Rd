% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utc.R
\name{utc0}
\alias{utc0}
\title{Compute Coordinated Universal Time (UTC/GMT) for Specified Local Time.}
\usage{
utc0(date = "2020-01-01", time = "12:00:00", tz = "Europe/Vienna")
}
\arguments{
\item{date}{Character. Date "yyyy-mm-dd".}

\item{time}{Character. Local time "hh:mm" or "hh:mm:ss".}

\item{tz}{Character. Local time zone. See OlsonNames() or use Sys.timezone().}
}
\description{
Compute Coordinated Universal Time (UTC/GMT) for Specified Local Time.
}
