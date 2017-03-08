# addAtLeast.R
# copyright 2015-2017, openreliability.org
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

 addAtLeast<-function (DF, at, atleast, name="",name2="", description="")  {
		
## Model test
##	if(any(DF$Type<4)|| any(DF$Type==13) || any(DF$Type==14) || any(DF$Type==15) ){
	if(any(DF$Type<4)|| (any(DF$Type>12)&&any(DF$Type<16))) {
		stop("PRA system event called for in RAM model")
	}

  	tp <-16
	
	parent<-which(DF$ID== at)
	if(length(parent)==0) {stop("connection reference not valid")}
	thisID<-max(DF$ID)+1
	if(DF$Type[parent]<10) {stop("non-gate connection requested")}

	if(!DF$MOE[parent]==0) {
		stop("connection cannot be made to duplicate nor source of duplication")
	}

	
	p1<-floor(atleast[1])
	if(!p1>1) {
		stop("atleast argument must be greater than 1")
	}
	
	
		Dfrow<-data.frame(
		ID=	thisID	,
		GParent=	at	,
		CParent=	at	,
		Level=	DF$Level[parent]+1	,
		Type=	tp	,
		CFR=	-1	,
		PBF=	-1	,
		CRT=	-1	,
		MOE=	0	,
		Condition=	0,
		Cond_Code=	0	,
		EType=	0	,
		P1=	p1	,
		P2=	-1	,
		Tag_Obj=	""	,
		Name=	name	,
		Name2=	name2	,
		Description=	description	,
		UType=	0	,
		UP1=	-1	,
		UP2=	-1	
	)


	DF<-rbind(DF, Dfrow)

	DF
}
	
