## readSCRAMcutsets.R
# Copyright 2017 OpenReliability.org
#
# A line-by-line parser of the output files from minimal cutset analysis
# both mocus and bdd from SCRAM http://scram-pra.org/ 
# returning a list of cutsets with basic-elements identified by tag.
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

readSCRAMcutsets<-function(x, dir="")  {

	fileName<-paste0(dir,x)
	conn <- file(fileName,open="r")
	on.exit(close(conn))

	be_vector<-NULL
	scram_cs_list<-list(NULL)
	
	i=1
	while ( TRUE ) {
		linn = readLines(conn, n = 1)
		if ( length(linn) == 0 ) {
			break
		}
		t2<-length(grep("<product order*",linn[1]))>0
		t3<-length(grep("<basic-event name*",linn[1]))>0
		t5<-length(grep("</results",linn[1]))>0

## line handlers based on grep tests

		if(t2)  {
			if(!is.null(be_vector) ) {
## encountering this node with a be_vector signifies the end of a previous collection of basic-event names
## so those need to be handled now, by adding to the appropriate list for this cut set order

				product_order<-length(be_vector)

				if(length(scram_cs_list)<product_order)  {
					scram_cs_list[[product_order]]<-t(as.matrix(be_vector))
				}else{
					if(is.null(scram_cs_list[[product_order]]))  {
						scram_cs_list[[product_order]]<-t(as.matrix(be_vector))
					}else{
						scram_cs_list[[product_order]]<-rbind(scram_cs_list[[product_order]],t(as.matrix(be_vector)))
					}
				}

			}

			be_vector<-NULL
# closure of product order handler
		}

		if(t3) {
## build the be_vector for later processing into scram_cs_lists
			in_string<-as.character(linn[1])
			first<- regexpr('=', linn[1])+2
			last<-nchar(linn[1])-3
			be = substr(in_string, first, last)

			if(is.null(be_vector)) {
				be_vector<-be
			}else{
				be_vector<-c(be_vector, be)
			}
		}

		if(t5) {
## encountering this node signifies the end of a previous collection of basic-event names
## so those need to be handled now, by adding to the appropriate list for last product_order with checking

			if(length(scram_cs_list)<product_order)  {
				scram_cs_list[[product_order]]<-t(as.matrix(be_vector))
			}else{
				if(is.null(scram_cs_list[[product_order]]))  {
					scram_cs_list[[product_order]]<-t(as.matrix(be_vector))
				}else{
					scram_cs_list[[product_order]]<-rbind(scram_cs_list[[product_order]],t(as.matrix(be_vector)))
				}
			}
		break
		}
		i=i+1
## closure of the line reading loop
	}
	
	scram_cs_list
}
