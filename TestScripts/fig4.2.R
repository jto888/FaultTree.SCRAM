## fig4.2.R
## Example Fault Tree from open-psa mef documentation https://open-psa.github.io/mef/
## This is a silly tree as the creators were focused on several components, apparently
## ignorant to the fact that the Top undesired event will occurr whenever BE1 fails
## regardless of the state of  the other basic elements.
##
## The challenge for cutset analysis is to find the common factor through the domain of 
## an initially identified order of cutsets. This process needs to take place just after
## unique cutsets have been determined and before the exhaustive cutset reduction algorithm.
## It should be terminate very quickly once any common factor is excluded.
##
fig4.2<-ftree.make(type="or", name="TOP")
fig4.2<-addLogic(fig4.2, at=1, type="and", name="G1")
fig4.2<-addProbability(fig4.2, at=2, prob=1.2e-3, tag="BE1", name="BE1")
fig4.2<-addProbability(fig4.2, at=2, prob=2.4e-3, tag="BE2", name="BE2")
fig4.2<-addLogic(fig4.2, at=1, type="and", name="G2")
fig4.2<-addDuplicate(fig4.2, at=5, dup_id=3)
fig4.2<-addProbability(fig4.2, at=5, prob=5.2e-3, tag="BE3", name="BE3")
fig4.2<-addLogic(fig4.2, at=1, type="and", name="G3")
fig4.2<-addDuplicate(fig4.2, at=8, dup_id=3)
fig4.2<-addProbability(fig4.2, at=8, prob=1.6e-3, tag="BE4", name="BE4")

