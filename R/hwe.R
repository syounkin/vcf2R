hwe2R <- function( file ){
  hwe.df <- data.frame(scan( file = file, sep = "\t", what = list( "", 1, "", "", 1, 1 ), skip = 1 ))
  names(hwe.df) <- c("CHR",	"POS",	"OBS(HOM1/HET/HOM2)",	"E(HOM1/HET/HOM2)",	"ChiSq",	"P" )
  return( hwe.df )
}
