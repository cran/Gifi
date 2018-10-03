\name{ABC}
\alias{ABC}

\docType{data}
\title{ABC Customer Satisfaction}
\description{
The ABC Company (a fictitious company) is a typical global supplier of integrated software, hardware, and services
solutions to media and telecommunications service providers. The company develops, installs and
maintains systems combining hardware, software and advanced electronics. These enabling systems
support various lines of business, including Video on Demand, cable, and satellite TV, as well as a
range of communications services, such as voice, video, data, Internet protocol, broadband, content,
electronic, and mobile commerce. They launched an customer satisfaction survey
designed to provide feedback on all company touch points and
interactions with customers. It covers topics such as Equipment, Sales Support, Technical Support,
Training, Supplies, Software Solutions, Customer Portal, Administrative Support, Terms, Conditions
and Pricing and Site Planning and Installation.
}
\usage{ABC}
\format{
Data frame with 11 items on a 5-point Likert scale (except one item, see below)

satis: 

Overall satisfaction level from ABC. (1 ... very low, 5 ... very high)

satis2010: 

Overall satisfaction level from ABC's improvements during 2010. (1 ... very low, 5 ... very high)

best:

Is ABC your best supplier? (0 ... no; 1 ... yes)

recom: 

Would you recommend ABC to other companies? (1 ... very unlikely, 5 ... very likely)

product: 

If you were in the market to buy a product, how likely would it be for you to purchase an 
ABC product again? (1 ... very unlikely, 5 ... very likely)

equipment: 

Overall satisfaction level from the equipment. (1 ... very low, 5 ... very high)

sales:

Overall satisfaction level from sales support. (1 ... very low, 5 ... very high)

technical: 

Overall satisfaction level from technical support. (1 ... very low, 5 ... very high)

training: 

Overall satisfaction level from ABC training. (1 ... very low, 5 ... very high)

purchase: 

Overall satisfaction level from purchasing support. (1 ... very low, 5 ... very high)

pricing:

Overall satisfaction level from pricing and contracts. (1 ... very low, 5 ... very high)
}

\references{
Kenett, R. S., & Salini, S. (2012). Modern Analysis of Customer Surveys with Applications in R. New York: Wiley.
}

\examples{
   head(ABC)
}
\keyword{datasets}
