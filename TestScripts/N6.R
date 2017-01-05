## N6.R
## An edge case generated for initial study by the Resilience Center at Colorado University
## this model has no AND gates, so all basic component events are first order cut sets.
##
  N6<-ftree.make(type="or", name=" no Functionality ", name2=" at N6")
  N6<-addProbability(N6, at=1, prob= 0.7932, name="Failure Probability", name2="of N6", tag="N6")
  N6<-addLogic(N6, at=1, type="or", name="no Functionality", name2="from Externalities")
  N6<-addProbability (N6, at=3, prob= 0.7404, name="Failure Probability", name2="of N1", tag="N1")
  N6<-addLogic(N6, at=3, type="or", name="no Functionality", name2="at N4")
  N6<-addProbability(N6, at=5, prob= 0.8308, name="Failure Probability", name2="of N4", tag="N4")
  N6<-addProbability(N6, at=5, prob= 0.6323, name="Failure Probability", name2="of N2", tag="N2")
