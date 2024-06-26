#' Package download counts and rank percentiles.
#'
#' From bioconductor
#' @param packages Character. Vector of package name(s).
#' @param date Character. Date. yyyy-mm
#' @param count Character. "ip" or "download".
#' @return An R data frame.
#' @export
#' @examples
#' \dontrun{
#' bioconductorRank(packages = "cicero", date = "2019-09")
#' }

bioconductorRank <- function(packages = "monocle", date = "2019-01",
  count = "download") {
  
  if (!curl::has_internet()) stop("Check internet connection.", call. = FALSE)
  
  pkg.url <- "https://bioconductor.org/packages/stats/bioc/bioc_pkg_stats.tab"
  packages.stats <-  as.data.frame(mfetchLog(pkg.url))
  
  dat <- packages.stats[packages.stats$Month != "all", ]
  dat$month <- NA
  
  for (i in seq_along(month.abb)) {
    if (i < 10) {
      dat[dat$Month == month.abb[i], "month"] <- paste0(0, i)
    } else {
      dat[dat$Month == month.abb[i], "month"] <- paste(i)
    }
  }
  
  dat$date <- as.Date(paste0(dat$Year, "-", dat$month, "-01"))
  dat <- dat[order(dat$date), ]
  
  sel.data <- dat[dat$date == as.Date(paste0(date, "-01")), ]
  
  if (count == "ip") {
    ct <- sel.data$Nb_of_distinct_IPs
  } else if (count == "download") {
    ct <- sel.data$Nb_of_downloads
  }
  
  names(ct) <- sel.data$Package
  
  freqtab <- sort(ct, decreasing = TRUE)
  
  # packages in bin
  packages.bin <- lapply(packages, function(nm) {
    freqtab[freqtab %in% freqtab[nm]]
  })
  
  # offset: ties arbitrarily broken by alphabetical order
  packages.bin.delta <- vapply(seq_along(packages.bin), function(i) {
    which(names(packages.bin[[i]]) %in% packages[i])
  }, numeric(1L))
  
  nominal.rank <- lapply(seq_along(packages), function(i) {
    sum(freqtab > freqtab[packages[i]]) + packages.bin.delta[i]
  })
  
  tot.packagess <- length(freqtab)
  
  packages.percentile <- vapply(packages, function(x) {
    round(100 * mean(freqtab < freqtab[x]), 1)
  }, numeric(1L))
  
  dat <- data.frame(date = date,
                    packages = packages,
                    downloads = c(freqtab[packages]),
                    rank = unlist(nominal.rank),
                    percentile = packages.percentile,
                    total.downloads = sum(ct),
                    total.packages = tot.packagess,
                    stringsAsFactors = FALSE,
                    row.names = NULL)
  
  out <- list(packages = packages, date = date, package.data = dat,
    freqtab = freqtab)
  class(out) <- "bioconductorRank"
  out
}

#' Plot method for bioconductorRank().
#' @param x An object of class "bioconductor_rank" created by \code{bioconductorRank()}.
#' @param graphics Character. "base" or "ggplot2".
#' @param log.y Logical. Logarithm of package downloads.
#' @param ... Additional plotting parameters.
#' @return A base R or ggplot2 plot.
#' @export


plot.bioconductorRank <- function(x, graphics = NULL, log.y = TRUE, ...) {
  if (is.logical(log.y) == FALSE) stop("log.y must be TRUE or FALSE.")
  freqtab <- x$freqtab + 1
  package.data <- x$package.data
  packages <- x$packages
  date <- x$date
  y.max <- freqtab[1]
  q <- stats::quantile(freqtab)[2:4]
  
  iqr <- vapply(c("75%", "50%", "25%"), function(id) {
    dat <- which(freqtab > q[[id]])
    dat[length(dat)]
  }, numeric(1L))
  
  if (is.null(graphics)) {
    if (length(packages) == 1) {
      basePlot(packages, log.y, freqtab, iqr, package.data, y.max, date)
    } else if (length(packages) > 1) {
      ggPlot(x, log.y, freqtab, iqr, package.data, y.max, date)
    } else stop("Error.")
  } else if (graphics == "base") {
    if (length(packages) > 1) {
      invisible(lapply(packages, function(pkg) {
        basePlot(pkg, log.y, freqtab, iqr, package.data, y.max, date)
      }))
    } else {
      basePlot(packages, log.y, freqtab, iqr, package.data, y.max, date)
    }
  } else if (graphics == "ggplot2") {
    ggPlot(x, log.y, freqtab, iqr, package.data, y.max, date)
  } else stop('graphics must be "base" or "ggplot2"')
}

#' Print method for bioconductorRank().
#' @param x An object of class "bioconductor_rank" created by \code{bioconductorRank()}
#' @param ... Additional parameters.
#' @export

print.bioconductorRank <- function(x, ...) {
  dat <- x$package.data
  rank <- paste(format(dat$rank, big.mark = ","), "of",
                format(dat$total.packages, big.mark = ","))
  out <- data.frame(dat[, c("date", "packages", "downloads")], rank,
    percentile = dat[, "percentile"], stringsAsFactors = FALSE,
    row.names = NULL)
  print(out)
}

#' Summary method for bioconductorRank().
#' @param object Object. An object of class "bioconductor_rank" created by \code{bioconductorRank()}
#' @param ... Additional parameters.
#' @export
#' @note This is useful for directly accessing the data frame.

summary.bioconductorRank <- function(object, ...) {
  object$package.data
}
