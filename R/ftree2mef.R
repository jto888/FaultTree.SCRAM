## ftree2mef
# Copyright 2017 OpenReliability.org
#
# Conversion of FaultTree data to Model Exchange Format in XML
# to enable input to packages conforming to the open-PRA initiative
# with specific interest in SCRAM http://scram-pra.org/
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

ftree2mef<-function(DF, DFname="", dir="", write_file=FALSE)  {
  if(!FaultTree::test.ftree(DF)) stop("first argument must be a fault tree")
  
## ToDo - issue warning if default tags must be issued.  
  
##  DF might be the DF object within the scram.cutsets environment
## in that event the DFname must be provided
 hold_name<-paste(deparse(substitute(DF)))
  if(length(DFname)==0) {
## test and fail if hold_name=="DF" while no DFname provided 
    if(hold_name=="DF"){
      stop("must provide DFname as an argument in any do.call function as done in scram.cutsets")
    }else{
        DFname<-hold_name
    }
  }
  

## Identify gates and events by ID
## establish gate types by gate ID's
	gids<-DF$ID[which(DF$Type>9)]
	eids<-DF$ID[which(DF$Type<10)]
	types<-NULL
	for(gate in 1:length(gids)) {
	if(DF$Type[which(DF$ID==gids[gate])]==10) {
	types=c(types, "or")
	}else{
	types=c(types, "and")
	}
	}

	treeXML=""
	for(gate in 1:length(gids)) {
		if(gate==1) {
			tagname="top"
		}else{
			tagname<-paste0("G_", gids[gate])
		}

		treeXML<-paste0(treeXML,'<define-gate name="',tagname, '">')

		treeXML<-paste0(treeXML,'<',types[gate],'>')

		chids<-DF$ID[which(DF$CParent==gids[gate])]

		for(child in 1:length(chids)) {
			tagname<-DF$Tag_Obj[which(DF$ID==chids[child])]
			if(DF$Type[which(DF$ID==chids[child])]>9) {
				if(tagname=="")  {
					tagname<-paste0("G_", chids[child])
				}
				treeXML<-paste0(treeXML,'<gate name="',tagname,'"/>')
			}else{
				if(tagname=="")  {
## must use source ID for MOE when assigning default tagname to events							
					if(DF$MOE[which(DF$ID==chids[child])]<1)  {			
						tagname<-paste0("E_", chids[child])		
					}else{			
						tagname<-paste0("E_", DF$MOE[which(DF$ID==chids[child])])		
					}			
				}
				treeXML<-paste0(treeXML,'<basic-event name="',tagname,'"/>')
			}
		}

		treeXML<-paste0(treeXML, ' </',types[gate],'></define-gate>')


	}

	eventXML=""
	for(event in 1:length(eids)) {
## cannot replicate MOE tags in mef, else get redifine basic-event error from scram
		if(DF$MOE[which(DF$ID==eids[event])]<1)  {
			tagname<-DF$Tag_Obj[which(DF$ID==eids[event])]
			if(tagname=="")  {
				tagname<-paste0("E_", eids[event])
			}

			eventXML<-paste0(eventXML, '<define-basic-event name="', tagname, '">')

			if(DF$PBF[which(DF$ID==eids[event])]>0) {
				eventXML=paste0(eventXML, '<float value="', DF$PBF[which(DF$ID==eids[event])], '"/>')
			}
			eventXML<-paste0(eventXML, '</define-basic-event>')
		}
	}

	XMLhead<-'<!DOCTYPE opsa-mef>
	<opsa-mef>
	<define-fault-tree name="'

	XMLfoot<-'</define-fault-tree>
	</opsa-mef>'

	outstring<-paste0(XMLhead,DFname,'">',treeXML, eventXML, XMLfoot)

	if(write_file==TRUE)  {
		file_name<-paste0(dir,DFname,"_mef.xml")
		eval(parse(text=paste0('write(outstring,"',file_name,'")')))
	}

	outstring
}