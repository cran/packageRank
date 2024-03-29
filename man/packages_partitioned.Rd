% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/packagesFunctions.R
\name{packages_partitioned}
\alias{packages_partitioned}
\title{Partitioned CRAN and Archive Packages.}
\usage{
packages_partitioned(observed.downloads = FALSE, multi.core = TRUE)
}
\arguments{
\item{observed.downloads}{Logical. Compute current observed package downloads.}

\item{multi.core}{Logical or Numeric. \code{TRUE} uses \code{parallel::detectCores()}. \code{FALSE} uses one, single core. You can also specify the number logical cores. See \code{vignette("Parallelization")} for details.}
}
\value{
An R list.
}
\description{
CRAN, Archive, Observed, CRAN & Archive, CRAN only and Archive only.
}
