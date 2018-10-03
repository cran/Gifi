\name{homals}
\alias{homals}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Multiple Correspondence Analysis (HOMALS). 
}
\description{
Fits a multiple correspondence analysis (MCA). The default is to take each input variable as nominal. Through restrictions on the transformations (ordinal in conjunction with splines) various generalizations of MCA can be achieved. 
}
\usage{
homals(data, ndim = 2, ordinal = FALSE, ties = "s", knots = knotsGifi(data, "D"), 
degrees = -1, missing = "m", normobj.z = TRUE, active = TRUE, itmax = 1000, 
eps = 1e-6, verbose = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{Input data frame: n observations, m variables}
  \item{ndim}{Number of dimensions to be computed}
  \item{ordinal}{Whether variables should be considered as ordinal or not. Alternatively, one can specify a boolean vector of length m denoting which variables should be ordinally restricted or not.}
  \item{ties}{How ties should be handled: primary (\code{"p"}), secondary (\code{"s"}), or tertiary (\code{"t"})}
  \item{knots}{Knots specification for spline transformation (see \code{\link{knotsGifi}})}
  \item{degrees}{Spline degrees. If different degrees should be used across variables, a vector of length m can be specified. The default value of -1 indicates nominal scale level (overrides the ordinal argument).}
  \item{missing}{How missing values should be handled: multiple (\code{"m"}), single (\code{"s"}), or average (\code{"a"})}
  \item{active}{Which variables should be active or inactive (also as vector of length m)}
  \item{normobj.z}{If \code{TRUE}, object scores are z-scores, if \code{FALSE}, they are restriction to SS of 1.}
  \item{itmax}{Maximum number of iterations}
  \item{eps}{Convergence criterion}
  \item{verbose}{Iteration printout}
}
\details{
This is the most general model of the Gifi family. All other models such as PRINCALS are restricted HOMALS versions (in terms of restrictions on the transformations). 
}
\value{
\item{transform}{Optimally transformed scores}
\item{rhat}{Induced correlation matrix}
\item{evals}{Eigenvalues of induced correlation matrix}
\item{objectscores}{Object scores (rows)}
\item{scoremat}{Optimally scaled data matrix (first dimension)}
\item{quantifications}{Category quantifications}
\item{dmeasures}{Discimination matrices}
\item{lambda}{Average discrimination matrix}
\item{weights}{Component weights}
\item{loadings}{Component loadings}
\item{ntel}{Number of iterations}
\item{f}{Loss function value}
\item{data}{Original data frame}
\item{datanum}{Numerical data frame}
\item{ndim}{Number of extracted dimensions}
\item{call}{Function call}
}
\references{
Gifi, A. (1990). Nonlinear Multivariate Analysis. New York: Wiley.

De Leeuw, J., Mair, P., Groenen, P. J. F. (2017). Multivariate Analysis with Optimal Scaling. \url{http://gifi.stat.ucla.edu/gifi/_book/}.
}
\seealso{\code{\link{princals}}, \code{\link{plot.homals}}}
\examples{
## multiple CA 
fithart <- homals(hartigan)
fithart
summary(fithart)
}
\keyword{multivariate}% use one of  RShowDoc("KEYWORDS")
