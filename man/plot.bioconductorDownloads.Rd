% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bioconductorDownloads.R
\name{plot.bioconductorDownloads}
\alias{plot.bioconductorDownloads}
\title{Plot method for bioconductorDownloads().}
\usage{
\method{plot}{bioconductorDownloads}(x, graphics = NULL,
  count = "download", cumulative = FALSE, points = "auto",
  smooth = FALSE, f = 2/3, span = 3/4, se = FALSE, log.y = FALSE,
  r.version = FALSE, same.xy = TRUE, multi.plot = FALSE,
  legend.loc = "topleft", ...)
}
\arguments{
\item{x}{object.}

\item{graphics}{Character. NULL, "base" or "ggplot2".}

\item{count}{Character. "download" or "ip".}

\item{cumulative}{Logical. Use cumulative counts.}

\item{points}{Character of Logical. Plot points. "auto", TRUE, FALSE. "auto" for bioconductorDownloads(unit.observation = "month") with 24 or fewer months, points are plotted.}

\item{smooth}{Logical. Add stats::lowess smoother.}

\item{f}{Numeric. smoother window for stats::lowess(). For graphics = "base" only; c.f. stats::lowess(f)}

\item{span}{Numeric. Smoothing parameter for geom_smooth(); c.f. stats::loess(span).}

\item{se}{Logical. Works only with graphics = "ggplot2".}

\item{log.y}{Logical. Logarithm of package downloads.}

\item{r.version}{Logical. Add R release dates.}

\item{same.xy}{Logical.  Use same scale for multiple packages when graphics = "base".}

\item{multi.plot}{Logical. Plot all data in a single window frame.}

\item{legend.loc}{Character.}

\item{...}{Additional plotting parameters.}
}
\description{
Plot method for bioconductorDownloads().
}
\examples{
\dontrun{
plot(bioconductorDownloads())
plot(bioconductorDownloads(packages = "graph"))
plot(bioconductorDownloads(packages = "graph", from = 2010, to = 2015))
plot(bioconductorDownloads(packages = "graph", from = "2014-06", to = "2015-03"))
plot(bioconductorDownloads(packages = c("graph", "IRanges", "S4Vectors"), from = 2018))
}
}
