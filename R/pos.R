frq2pos <- function( file ){
  
  file <- file(file)
  mylist <- strsplit(readLines(file), "\t")[-1]
  close(file)

  # create a list of mafs.  If number of alleles != 2 then return NA.
  chr.list <- lapply(mylist, function( line ) line[1] )
  pos.list <- lapply(mylist, function( line ) line[2] )
  # convert to a numeric vector
  chr <- as.factor(unlist(chr.list))
  pos <- as.integer(unlist(pos.list))
  # replace maf with  1 - maf for any maf > 0.5
  return( data.frame( chr = chr, pos = pos ) )

}
