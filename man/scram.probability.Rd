\name{scram.probability}
\alias{scram.probability}

\title{ Fault Tree Probability Determination Acquired from SCRAM }

\description{Interconnection with SCRAM by transferred XML files permits advanced calculation of exact probability of the top event via BDD analysis for cut sets.
}

\usage{
scram.probability(DF, list_out=FALSE, system_mission_time=NULL)
}

\arguments{
\item{DF}{ A fault tree dataframe such as returned from ftree.make or related add... functions. 
Fault tree basic elements must be either probability or exposed types, INHIBIT gates will be converted to AND. 
Fault tree shall not contain PRIORITY, ALARM nor VOTE gates, voting is [to be] handled by the atleast gate type.}
\item{list_out}{A logical indicating whether the list output from readSCRAMprobability should be returned. 
Alternatively for FALSE only a single probaility value will be returned.}
\item{system_mission_time}{An entry that may alter SCRAM default for mission time to be applied to exposed elements.
 This may be a value or label of a global scalar variable. If a global object named 'mission_time' exists it will 
 be taken as default for this system_mission_time argument.}
}

\value{
Returns a scalar vector (single value) which is the exact probability for the top event.
}

\details{  
"And one ring to bind them all ..." This function calls ftree2mef, callSCRAM, and readSCRAMprobability
 appropriately for the entered ftree object. Temporary files for SCRAM input and output are produced in the process.
 Probability is for the top event of the tree is calculated by the BDD algorithm and is regarded as exact. 
 The default output is a single element numeric vector with this probability value. The optional list output includes 
 named objects for probability and cutsets. The cutsets object is a dataframe  containing the minimal cutsets 
 (prime implcants via BDD) by tag (padded with NA for lower order sets) with a column named prob holding the 
 product of probabilities for each element of the cutset row.
}

\references{
  Rauzy, Antoine, et. al.  (2013) Open PSA Model Exchange Format v2.0 open-psa.org
  
  Limnios, Nikolaos (2007) Fault Trees ISTE Ltd.

  Nicholls, David [Editor] (2005) System Reliability Toolkit  Reliability information Analysis 
  Center
  
  O'Connor, Patrick D.T. (1991) Practical Reliability Engineering  John Wiley & Sons
  
  Fussell, J., Vesely, W.E. (1972) A New Method for Obtaining Cut Sets for Fault Trees  Transactions ANS, No. 15
  
  Ericson, Clifton A. II (2011) Fault Tree Analysis Primer  CreateSpace Inc.
    
  Vesely, W.E., Goldberg, F.F., Roberts, N.H., Haasl, D.F. (1981)  Fault Tree Handbook
  U.S.  Nuclear Regulatory Commission 
  
  Vesely, W.E., Stamatelato, M., Dugan, J., Fragola, J., Minarick, J., Railsback, J. (2002)
  Fault Tree Handbook with Aerospace Applications   NASA
  
  Doelp, L.C., Lee, G.K., Linney, R.E., Ormsby R.W. (1984) Quantitative fault tree analysis: Gate-by-gate method Plant/Operations Progress
   Volume 3, Issue 4 American Institute of Chemical Engineers

}

\examples{
## This function is completely device dependent.
}

\keyword{ logic, risk, failure }

