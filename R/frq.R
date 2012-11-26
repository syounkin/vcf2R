frq2R <- function( file ){
  
  file <- file(file)
  mylist <- strsplit(readLines(file), "\t")
  close(file)

  # create a list of mafs.  If number of alleles != 2 then return NA.
  maf.di.list <- lapply(mylist, function( line ) if( line[3]==2) line[6] else NA)
  # convert to a numeric vector
  maf.di <- as.numeric(unlist(maf.di.list))
  # replace maf with  1 - maf for any maf > 0.5
  maf.di <- ifelse( maf.di > 0.5, 1 - maf.di, maf.di )
  return( maf.di )

}
