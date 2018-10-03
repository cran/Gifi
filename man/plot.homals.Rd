\name{plot.homals}
\alias{plot.homals}

\title{Plot Methods for Homals}
\description{Various plotting options for objects of class \code{"homals"}.
}
\usage{
\method{plot}{homals}(x, plot.type = "jointplot", plot.dim = c(1, 2), 
var.subset = "all", col.points = rainbow_hcl(ncol(x$data)), col.scores = "gray", 
col.lines = 1:x$ndim, cex.scores = 0.8, cex.loadings = 0.8, labels.scores = FALSE, 
stepvec = NA, max.plot.array = c(2, 2), asp = 1, main, xlab, ylab, xlim, ylim, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{Object of class \code{"homals"}}
  \item{plot.dim}{Vector with dimensions to be plotted.}
  \item{plot.type}{String indicating which type of plot to be produced: \code{"jointplot"}, 
  \code{"biplot"}, \code{"screeplot"}, \code{"transplot"}. See details.} 
  \item{var.subset}{Numeric vector for subsetting variables to be plotted. If missing, all variables are taken into account} 
  \item{col.points}{Color categories.}
  \item{col.scores}{Color object scores.} 
  \item{col.lines}{Line colors for transformation and scree plot.}
  \item{cex.scores}{Size object scores.}
  \item{cex.loadings}{Size loading labels.}
  \item{asp}{Aspect ratio}
  \item{labels.scores}{Whether object score labels should be plotted.} 
  \item{stepvec}{Vector whether step function should be plotted (see details).}
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
 
- Biplot (\code{plot.type = "biplot"}): Biplot with the object scores and the category quantifications.

- Transformation plot (\code{plot.type = "transplot"}): Plots the original scale against the
transformed scale (first dimension) for each variable separately.

- Joint plot (\code{plot.type = "jointplot"}): Plots the category quantifications.

- Scree plot (\code{plot.type = "screeplot"}): Produces a scree plot based on the eigenvalues. 

For transformation plots only: If \code{stepvec = NA}, the function tries to figure out which variable should be plotted as step function. Alternatively, a boolean vector (with length number of variables) can be specified (\code{TRUE} step function, \code{FALSE} smooth function).
}

\examples{
fithart <- homals(hartigan, ndim = 3, normobj.z = FALSE)
fithart

plot(fithart)   
plot(fithart, var.subset = c(1,2,4), plot.dim = c(2,3))
plot(fithart, plot.type = "biplot", col.scores = "black")
plot(fithart, plot.type = "biplot", col.scores = "black", labels.scores = TRUE, col.points = 1:6)
plot(fithart, plot.type = "screeplot", col.lines = "red")
plot(fithart, plot.type = "transplot", plot.dim = 1:3, col.lines = c(1, 2, 4))
plot(fithart, plot.type = "transplot", stepvec = rep(FALSE, 6), max.plot.array = c(2,2))
}

\keyword{ hplot }
