\name{makeNumeric}
\alias{makeNumeric}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Convert a data frame into a numeric matrix.
}
\description{
Utility function for converting a data frame with factors (numeric and character levels), ordered factors, and numerical variables into a numeric matrix. 
}
\usage{
makeNumeric(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{Data frame}
}
\value{
A numeric matrix.
}

\examples{
makeNumeric(ABC[,6:11])
}
\keyword{utilities}% use one of  RShowDoc("KEYWORDS")
