\name{morals}
\alias{morals}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Multiple Regression (MORALS). 
}
\description{
Fits multiple regression within the Gifi framework.  
}
\usage{
morals(x, y, xknots = knotsGifi(x, "Q"), yknots = knotsGifi(y, "Q"), xdegrees = 2, 
ydegrees = 2, xordinal = TRUE, yordinal = TRUE, xties = "s", yties = "s", xmissing = "m", 
ymissing = "m", xactive = TRUE, xcopies = 1, itmax = 1000, eps = 1e-6, verbose = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{Vector or data frame with predictor variables (all numeric)}
  \item{y}{Vector with response variable}
  \item{xknots}{Knots specification for predictors (see \code{\link{knotsGifi}})}
  \item{yknots}{Knots specification for response (see \code{\link{knotsGifi}})}
  \item{xdegrees}{Degree specification for predictors}
  \item{ydegrees}{Degree specification for response}
  \item{xordinal}{Whether predictors should be considered as ordinal or not. Alternatively, one can specify a boolean vector of length m denoting which variables should be ordinally restricted or not}
  \item{yordinal}{Whether response should be considered as ordinal or not}
  \item{xties}{How predictor ties should be handled: primary (\code{"p"}), secondary (\code{"s"}), or tertiary (\code{"t"})}
  \item{yties}{How response ties should be handled: primary (\code{"p"}), secondary (\code{"s"}), or tertiary (\code{"t"})}
  \item{xmissing}{How missing predictor values should be handled: multiple (\code{"m"}), single (\code{"s"}), or average (\code{"a"})}
  \item{ymissing}{How missing response values should be handled: multiple (\code{"m"}), single (\code{"s"}), or average (\code{"a"})}
  \item{xactive}{Which predictors should be active or inactive}
  \item{xcopies}{Number of copies for each predictor}
  \item{itmax}{Maximum number of iterations}
  \item{eps}{Convergence criterion}
  \item{verbose}{Iteration printout}
}
\details{
Fits MORALS as described in De Leeuw et al. (2017). 
}
\value{
\item{rhat}{Induced correlation matrix}
\item{objectscores}{Object scores (rows)}
\item{xhat}{Optimally transformed predictors}
\item{yhat}{Optimally transformed response}
\item{ypred}{Predicted (fitted) values}
\item{yres}{Residuals}
\item{smc}{Squared multiple correlation}
\item{ntel}{Number of iterations}
\item{f}{Loss function value}
}
\references{
Gifi, A. (1990). Nonlinear Multivariate Analysis. New York: Wiley.

De Leeuw, J., Mair, P., Groenen, P. J. F. (2017). Multivariate Analysis with Optimal Scaling. \url{http://gifi.stat.ucla.edu/gifi/_book/}. 
}

\seealso{\code{\link{homals}}, \code{\link{princals}}, \code{\link{plot.morals}}}

\examples{
x <- scale(as.matrix(seq(0, pi, length = 20)), scale = FALSE)
y <- scale(as.matrix(sin(x)), scale = FALSE)
fitxy <- morals(x, y, xknots = knotsGifi(x, "E"), xdegrees = 2)
plot(fitxy, main = c("x", "y"))
plot(fitxy, plot.type = "resplot")

plot(fitxy$xhat, fitxy$yhat)
lines(fitxy$xhat, fitxy$ypred)

plot(x, fitxy$yhat)
lines(x, fitxy$ypred)
}
\keyword{multivariate}% use one of  RShowDoc("KEYWORDS")
