\name{cv.morals}
\alias{cv.morals}
\alias{cv}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Cross-validation for Morals fit
}
\description{
Performs a k-fold CV on Morals objects and returns the CV error.
}
\usage{
cv(object, folds = 10, verbose = FALSE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{Object of class \code{"morals"}}
  \item{folds}{Number of folds for cross-validation (for LOOCV set it equal to n).}
  \item{verbose}{If \code{TRUE}, iteration is printed out}
  \item{...}{Additional arguments (ignored here)}
}
%- maybe also 'usage' for other objects documented here.


\examples{
## mimic linear regression
xknots <- knotsGifi(neumann[,1:2], "E")  
yknots <- knotsGifi(neumann[,3], "E")
fitlin <-  morals(neumann[,1:2], neumann[,3], xknots = xknots, yknots = yknots, 
                  xdegrees = 1, ydegrees = 1, xordinal = FALSE, yordinal = FALSE)
cv(fitlin)  ## CV error of prediction
}
\keyword{utilities}% use one of  RShowDoc("KEYWORDS")
