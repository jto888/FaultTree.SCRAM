## scram.importance
# Copyright 2017 OpenReliability.org
#
# Acquisition of importance measures from SCRAM program http://scram-pra.org/
# by means of temporary writing of SCRAM input and output files.
# 
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##
scram.importance<-function(DF, system_mission_time=NULL)  {
  if(!FaultTree::test.ftree(DF)) stop("first argument must be a fault tree")
  
  DFname<-paste(deparse(substitute(DF)))
  
	arg3<-""
	if (is.null(system_mission_time)) {
		if(exists("mission_time")) {
			system_mission_time<-"mission_time"	
			Tao <- eval((parse(text = system_mission_time)))
			arg3<-paste0(" --mission-time ", Tao)			
		}else{
			stop("mission_time not avaliable, SCRAM default will apply")
		}
	}else{	
		if (is.character(system_mission_time)) {
			if (exists("system_mission_time")) {
				Tao <- eval((parse(text = system_mission_time)))
				arg3<-paste0(" --mission-time ", Tao)
			}else {
				stop("exposure object does not exist")
			}
		}else {
			Tao = system_mission_time
			arg3<-paste0(" --mission-time ", Tao)
		}
	}
	

  ## test for gates priority, alarm, vote, fail for now as not implemnted  
  ## test for component types other than probability,exposed, or sthochastic.fail if non-coherent
  ## test that there are no empty gates, all tree leaves must be basic component events
  ## Identify gates and events by ID
	gids<-DF$ID[which(DF$Type>9)]
	pids<-DF$CParent
	if(length(setdiff(gids, pids))>0) {
	stop(paste0("no children at gate(s) ID= ", setdiff(gids, pids)))
	}
  ## test for gates priority, alarm, vote, fail for now as not implemnted
   if(any(DF$Type==13) || any(DF$Type==14) || any(DF$Type==15)) {
  stop("ALARM, PRIORITY, and VOTE gates are not supported in SCRAM calls")
  }
  ## test for component types other than probability or exposed, fail if non-coherent  
  if(any(DF$Type==1) || any(DF$Type==2)|| any(DF$Type==3)) {
  stop("Repairable model types: Active, Latent, and Demand not supported in SCRAM calls")
  } 
  ## test for PBF value in all basic component events (except Dynamic) - fail if not all >0
  ## ASSUME THAT DYNAMIC EVENTS WILL BE TYPE= 9
  event_probs<-DF$PBF[which(DF$Type<9)]
  if(any(event_probs<=0)) {
	stop("incomplete basic-event probability data in model")
   }
  
  ## it is possible that Dynamic components will have probability generated within SCRAM
    #ToDo??
  ## test for inhibit and warn about conversion to and

  do.call("ftree2mef",list(DF,DFname,"",TRUE))
    
  mef_file<-paste0(DFname,'_mef.xml')
if(file.exists(mef_file)) {
  do.call("callSCRAM",list(DFname,"importance", " 1", arg3))
}else{
  stop(paste0("mef file does not exist for object ",DFname))
}

  scram_file<-paste0(DFname,'_scram_importance.xml')
  if(file.exists(scram_file)) {
    impDF<-readSCRAMimportance(scram_file)
  }else{
    stop(paste0(scram_file, " does not exist"))
  }
  

## this experimental code only works if tags are assigned as a single letter prefix on number
# tags<-as.character(impDF$tag)
# val_tags<-as.numeric(substr(tags,3,nchar(tags)-2))
# impDF<-impDF[order(-impDF$MIF,val_tags),]


impDF<-impDF[order(-impDF$MIF),]
impDF


}
