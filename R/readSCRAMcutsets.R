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
