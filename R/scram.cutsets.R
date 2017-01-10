## scram.cutsets
# Copyright 2017 OpenReliability.org
#
# Acquisition of cutsets from SCRAM program http://scram-pra.org/
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
scram.cutsets<-function(DF, method="mocus")  {
  if(!FaultTree::test.ftree(DF)) stop("first argument must be a fault tree")
  
  DFname<-paste(deparse(substitute(DF)))
  
  if(method!="mocus" && method!="bdd" && method!="zbdd") {
    stop(paste0("method ",method," not supported"))
  }
  
  #ToDo
  
  ## test for component types other than probability or exposed, fail if non-coherent
  ## test for gates priority, alarm, vote, fail for now as not impleemnted
  ## test for inhibit and warn about conversion to and
  
  ## perhaps create a directory /temp if not already existing in current file position
  ## then assure that dir="/temp" in called functions ftree2mef and callSCRAM and readSCRAMcutsets
  

 # ftree2mef(DF, DFname=DFname, dir="", write_file=TRUE) 
do.call("ftree2mef",list(DF,DFname,"",TRUE))
##stop("test mef file creation")

mef_file<-paste0(DFname,'_mef.xml')
if(file.exists(mef_file)) {
##  unlikely that it is possible to input a quoted string of the mef file content
##  so an input_string argument was abandoned as the second argument to callSCRAM
  do.call("callSCRAM",list(DFname,method))
}else{
  stop(paste0("mef file does not exist for object ",DFname))
}

  scram_file<-paste0(DFname,'_scram_', method, '.xml')
  if(file.exists(scram_file)) {
    cs_list<-readSCRAMcutsets(scram_file)
  }else{
    stop(paste0(scram_file, " does not exist\n callSCRAM(",DFname,"scram_arg=",method))
  }
  
## ToDo
## after proven functional, the temporary files created by this function should be deleted.
  
cs_list
  
}