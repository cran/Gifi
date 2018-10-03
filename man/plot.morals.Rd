\name{plot.morals}
\alias{plot.morals}

\title{Plot Methods for Morals}
\description{Various plotting options for objects of class \code{"morals"}.
}
\usage{
\method{plot}{morals}(x, plot.type = "transplot", var.subset = "all", col.lines = "black", 
stepvec = NA, max.plot.array = c(2, 2), main, xlab, ylab, xlim, ylim, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{Object of class \code{"morals"}}
  \item{plot.type}{String indicating which type of plot to be produced: \code{"resplot"}, \code{"transplot"}} 
  \item{var.subset}{Numeric vector for subsetting variables to be plotted. If missing, all variables are taken into account. Ignored for non separate variable plots.} 
  \item{col.lines}{Line colors for transformation}
  \item{stepvec}{Vector whether step function should be plotted}
  \item{max.plot.array}{Number of panels in transformation plot.}
  \item{main}{Plot title.}
  \item{type}{Type of points/lines to be plotted.}
  \item{xlab}{Label of x-axis.}
  \item{ylab}{Label of y-axis.}
  \item{xlim}{Limits for x-axis.}
  \item{ylim}{Limits for y-axis.}
  \item{\dots}{Further plot arguments passed: see \code{\link[graphics]{plot}}
}
}
\details{Plot description:
The transformation plot (\code{plot.type = "transplot"}): Plots the original scale against the transformed scale  for each variable separately.
}

\examples{
x <- scale(as.matrix(seq(0, pi, length = 20)), scale = FALSE)
y <- scale(as.matrix(sin(x)), scale = FALSE)
fitxy <- morals(x, y, xknots = knotsGifi(x, "E"), xdegrees = 2)
plot(fitxy, main = c("x", "y"))
plot(fitxy, plot.type = "resplot")
}

\keyword{ hplot }
