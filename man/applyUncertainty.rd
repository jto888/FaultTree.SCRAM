\name{applyUncertainty}
\alias{applyUncertainty}

\title{ Define an uncertainty deviate for a selected basic element in the fault tree. }

\description{Modifies an existing fault tree with the addition of the repeated nodes.}

\usage{
applyUncertainty(DF, on, what="prob", type, param)
}

\arguments{
\item{DF}{ A fault tree dataframe such as returned from ftree.make or related add... functions.}
\item{on}{ The ID of the basic element node to be defined uncertain.}
\item{what}{A string identifying the basic-event parameter that uncertainty is to be applied to. Only default of "prob" has been implemented.}
\item{type}{A string signifying the deviate to be applied. Implemented deviate types "uniform","normal","lognormal" have been implemented.}
\item{param}{A vector of the appropriate deviate parameters in the order sepcified in the Open-PSA Model Exchange Format}
}

\value{
Returns the input fault tree dataframe amended with entries defining an uncertainty deviate for the probability of the  selected event.
}

\details{
  Application of the deviate has no impact on the tree visualization or functionality, except to provide input for uncertainty analysis by the SCRAM program.
  SCRAM is an external program that must be installed on the system. Package FaultTree.SCRAM has been developed to facilitate interoperatility between the FaultTree package and SCRAM.
}

\references{
  Rauzy, Antoine, et. al.  (2013) Open PSA Model Exchange Format v2.0 open-psa.org
  
  Limnios, Nikolaos (2007) Fault Trees ISTE Ltd.
  
  Nicholls, David [Editor] (2005) System Reliability Toolkit  Reliability information Analysis 
  Center
  
  O'Connor, Patrick D.T. (1991) Practical Reliability Engineering  John Wiley & Sons
  
  Vesely, W.E., Goldberg, F.F., Roberts, N.H., Haasl, D.F. (1981)  Fault Tree Handbook
  U.S.  Nuclear Regulatory Commission 
  
  Vesely, W.E., Stamatelato, M., Dugan, J., Fragola, J., Minarick, J., Railsback, J. (2002)
  Fault Tree Handbook with Aerospace Applications   NASA
  
  Doelp, L.C., Lee, G.K., Linney, R.E., Ormsby R.W. (1984) Quantitative fault tree analysis: Gate-by-gate method Plant/Operations Progress
  Volume 3, Issue 4 American Institute of Chemical Engineers
  
  Ericson II, Clifton A. (2011) Fault Tree Analysis Primer CreateSpace Inc.
}

\examples{
mytree <-ftree.make(type="or")
mytree <- addLogic(mytree, at=1, type= "and", name="A and B failed")
mytree <- addProbability(mytree, at=2, prob=.01, name="switch A failure")
mytree <- addProbability(mytree, at=2, prob=.01, name="switch B failure")
mytree <- addLogic(mytree, at=1, type= "and", name="A and C failed")
mytree <- addDuplicate(mytree, at=5, dup_id=3)
mytree <- addProbability(mytree, at=5, prob=.01, name="switch C failure")
mytree <- applyUncertainty(mytree, on=7, type="normal", param=c(.001))
mytree <- applyUncertainty(mytree, on=3, type="lognormal", param=c(10,.95))
}

\keyword{ reliability, risk, failure }

