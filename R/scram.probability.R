## scram.probability
# Copyright 2017 OpenReliability.org
#
# Acquisition of exact probability calculation from SCRAM program http://scram-pra.org/
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
scram.probability<-function(DF)  {
  if(!FaultTree::test.ftree(DF)) stop("first argument must be a fault tree")
  
  DFname<-paste(deparse(substitute(DF)))
  
    #ToDo
  
  ## test for component types other than probability,exposed, or sthochastic.fail if non-coherent
  ## test for PBF value in all basic component events (except Dynamic) - fail if not all >0
  ## it is possible that Dynamic components will have probability generated within SCRAM
  ## test for gates priority, alarm, vote, fail for now as not implemnted
  ## test for inhibit and warn about conversion to and

  do.call("ftree2mef",list(DF,DFname,"",TRUE))
    
  mef_file<-paste0(DFname,'_mef.xml')
if(file.exists(mef_file)) {
  do.call("callSCRAM",list(DFname,"probability", " 1"))
}else{
  stop(paste0("mef file does not exist for object ",DFname))
}

}
