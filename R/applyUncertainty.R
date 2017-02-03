# applyUncertainty.R
# copyright 2017, openreliability.org
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

applyUncertainty<-function(DF, on , what="prob", type, param)  {

	if(!test.ftree(DF)) stop("first argument must be a fault tree")
	
	if(!DF$Type[which(DF$ID==on)]==4 && !DF$Type[which(DF$ID==on)]==5){
		stop("Uncertainty can be applied to only Probability or Exposed elements")
	}

	utp<-switch(type,
		uniform = 1,
		normal = 2,
		lognormal=3,
##		gamma=4,
##		beta=5,
		stop("deviate type not recognized")
	)

## there should probably be some checking on validity of parameters here
	if(type==1) {
	static_mean<-DF$PBF[which(DF$ID==on)]
		if(!((param[2]-static_mean)==(static_mean-param[1]))){
			stop(paste0("uniform-deviate does not straddle mean at ID ", on))
		}
	}
	if(type==2) {
		if(param[1] > DF$PBF[which(DF$ID==on)]/6) {
			warning(paste0("normal-deviate sigma likely too high at ID ", on))
		}
	}
	
	if(type==3) {
		if(param[1]<1 && param[2]<.5 && param[2]>1) {
			warning(paste0("error likely in lognormal-deviate parameter specification at ID ", on))
		}
	}


	DF$UType[which(DF$ID==on)]<-utp
	DF$UP1[which(DF$ID==on)]<-param[1]
	if(!utp==2) {
	DF$UP2[which(DF$ID==on)]<-param[2]
	}
	DF
}
