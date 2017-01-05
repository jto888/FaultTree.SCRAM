## N.R
## An edge case generated for initial study by the Resilience Center at Colorado University.
## This model has one first order cut set that is clearly isolated.  A second AND gate appearing
## to produce a third order cut set is built with a duplicate basic component element, such
## that the only initial cut set of third order must be eliminated by the reduction algorithm.
##
N<-ftree.make(type="or", name=" no Functionality ", name2=" at N5")
N<-addProbability(N, at=1, prob= 0.7, name="Failure Probability", name2="of N5", tag="N5")
N<-addLogic(N, at=1, type="and", name="no Functionality", name2="from Externalities of N5")
N<-addLogic(N, at=3, type="or", name="no Functionality", name2="of N3")
N<-addLogic(N, at=3, type="or", name="no Functionality", name2="of N4")
N<-addProbability (N, at=4, prob= 0.8, name="Failure Probability", name2="of N3", tag="N3")
N<-addProbability (N, at=4, prob= 0.9, name="Failure Probability", name2="of N1", tag="N1")
N<-addProbability (N, at=5, prob= 0.6, name="Failure Probability", name2="of N4", tag="N4")
N<-addLogic(N, at=5, type="and", name="no Functionality", name2="from Externalities of N4")
N<-addDuplicate( N, at=9, dup_id=7)
N<-addProbability (N, at=9, prob= 0.5, name="Failure Probability", name2="of N2", tag="N2")
