\name{princals}
\alias{princals}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Categorical principal component analysis (PRINCALS). 
}
\description{
Fits a categorical PCA. The default is to take each input variable as ordinal but it works for mixed scale levels (incl. nominal) as well. Through a proper spline specification various continuous transformation functions can be specified: linear, polynomials, and (monotone) splines. 
}
\usage{
princals(data, ndim = 2, levels = "ordinal", ordinal, knots, ties = "s", 
degrees = 1, copies = 1, missing = "s", normobj.z = TRUE, active = TRUE,
itmax = 1000, eps = 1e-06, verbose = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{Input data frame: n observations, m variables}
  \item{ndim}{Number of dimensions to be computed}
   \item{levels}{A vector of length m denoting basic scale levels (\code{"nominal"}, \code{"ordinal"}, \code{"metric"}; see details}
  \item{ordinal}{If knots are specified manually, a boolean vector of length m denotes which variables should be ordinally restricted or not (see details)}
  \item{knots}{Scale levels can be specified manually using splines (see \code{\link{knotsGifi}}). If knots is set, this overrides \code{level} (see details)}
  \item{ties}{How ties should be handled: primary (\code{"p"}), secondary (\code{"s"}), or tertiary (\code{"t"})}
  \item{degrees}{Spline degrees. If different degrees should be used across variables, a vector of length m can be specified.}
  \item{copies}{Number of copies for each variables (also as vector of length m). If \code{copies} is a scalar the function creates a copies vector internally with a value of 2 for each nominal variable.}
  \item{missing}{How missing values should be handled: multiple (\code{"m"}), single (\code{"s"}), or average (\code{"a"})}
  \item{active}{Which variables should be active or inactive (also as vector of length m)}
  \item{normobj.z}{If \code{TRUE}, object scores are z-scores, if \code{FALSE}, they are restricted to SS of 1.}
  \item{itmax}{Maximum number of iterations}
  \item{eps}{Convergence criterion}
  \item{verbose}{Iteration printout}
}
\details{
The measurement (or scale) levels of the variables are incorporated via spline transformations. If the user only needs simple scale levels like nominal, ordinal, and metric, a corresponding vector can be specified in the \code{levels} argument without setting \code{knots} and \code{ordinal}. The corresponding spline transformations (unrestricted, monotone, and linear) are then created internally. If all scale level transformations are the same, \code{ordinal} can be a single value. For more advanced transformations such as polynomial or more flexible splines, the \code{knots} and \code{ordinal} arguments need to be specified instead of \code{levels}.


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

De Leeuw, J., Mair, P., Groenen, P. J. F. (2017). Multivariate Analysis with Optimal Scaling. 
}

\seealso{\code{\link{homals}}, \code{\link{plot.princals}}}

\examples{
ABC6 <- ABC[,6:11]

## ordinal PCA
fitord <- princals(ABC6)  ## ordinal PCA
fitord
summary(fitord)

plot(fitord, plot.type = "transplot")
plot(fitord, "loadplot", main = "Loadings Plot ABC Data")  ## aspect ratio = 1
plot(fitord, "biplot", main = "Biplot ABC Data")
plot(fitord, "screeplot")

## linear restrictions (mimics standard PCA)
abc_knots <- knotsGifi(ABC6, "E")     ## 0 interior knots
fitlin <- princals(ABC6, knots = abc_knots, ordinal = TRUE)  
fitlin 
fitlin$evals
plot(fitlin, plot.type = "transplot")

## compare with standard PCA
ABCnum <- makeNumeric(ABC6)
fitpca <- prcomp(ABCnum, scale = TRUE)
fitpca$sdev^2   

## more complicated specifications
\dontrun{
data(epi.bfi, package = "psychTools")
epi6 <- epi.bfi[,1:6]
fitepi1 <- princals(epi6, knots = knotsGifi(epi6, "Q"))    ## monotone splines (degree 2)
fitepi1
plot(fitepi1, "transplot")

## no interior knots vars 1 and 2; data knots vars 3 and 4; 5 
## interior percentile knots var 5; no interior knots var 6)
knotList <- c(knotsGifi(epi6[,1:2], "E"), 
              knotsGifi(epi6[,3:4], "D"), 
              knotsGifi(epi6[,5], "Q", n = 5),
              knotsGifi(epi6[,6], "E"))
knotList  
ordvec <- c(TRUE, FALSE, TRUE, FALSE, FALSE, TRUE) ## ordinal restrictions
degvec <- c(3, -1, 2, 2, 3, 1)                     ## spline degrees (second variable nominal)
fitepi2 <- princals(epi6, knots = knotList, ordinal = ordvec, degrees = degvec)
fitepi2
plot(fitepi2, "transplot")
}

}
\keyword{multivariate}% use one of  RShowDoc("KEYWORDS")
