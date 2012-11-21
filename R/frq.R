frq2R <- function( file ){

  file <- file(file)
  mylist <- strsplit(readLines(file), "\t")
  close(file)

  maf.di <- as.numeric(unlist(lapply(mylist, function( foo ) if( foo[3]==2) foo[6] else NA)))
  maf.di <- ifelse( maf.di > 0.5, 1-maf.di, maf.di )
  return( maf.di )
  ## frq <- data.frame(scan( file = file, sep = "\t", what = list( "", 1L, 1L, 1L, 1, 1, 1, 1 ), skip = 1 ), stringsAsFactors = FALSE)
  ## names(frq) <- c("CHR",	"POS",	"N_ALLELES", "N_CHR", "FREQ1", "FREQ2", "FREQ3", "FREQ4")

  ## frq.df <-   with(frq, {
  ##   data.frame(
  ##     chr = as.factor(CHR),
  ##     pos = as.integer(POS),
  ##     n.allele = as.integer(N_ALLELES),
  ##     n.chr = as.integer(N_CHR),
  ##     freq.1 = as.numeric(FREQ1),
  ##     freq.2 = as.numeric(FREQ2),
  ##     freq.3 = as.numeric(FREQ3),
  ##     freq.4 = as.numeric(FREQ4)      
  ##     )
  ## })
  ## rownames(hwe.df) <- NULL
  ## return( hwe.df )
}
