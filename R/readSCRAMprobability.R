## readSCRAMprobability.R
# Copyright 2017 OpenReliability.org
#
# A line-by-line parser of the output file from SCRAM probabiilty analysis
#  http://scram-pra.org/ returning a scalar vector holding the single output value.
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

readSCRAMprobability<-function(x, dir="")  {

	fileName<-paste0(dir,x)
## check that fileName provided is indeed for probability and indeed exists	
	
	conn <- file(fileName,open="r")
	on.exit(close(conn))
	
		i=1
	while ( TRUE ) {
		linn = readLines(conn, n = 1)
		if ( length(linn) == 0 ) {
			break
		}
		
		test_line<-length(grep("<sum-of-products*",linn[1]))>0
		if(test_line) {
			in_string<-as.character(linn[1])
			first<- regexpr('probability=', linn[1])+13
			last<-nchar(linn[1])-2
			pb_string = substr(in_string, first, last)	
## We are done reading the file so quit the loop now
			break
		}
		
		i=i+1
## closure of the line reading loop
	}
	
	probability<-as.numeric(pb_string)
	probability
	}
	
		
		
	