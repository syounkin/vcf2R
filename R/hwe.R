hwe2R <- function( file ){
  hwe <- data.frame(scan( file = file, sep = "\t", what = list( "", 1, "", "", 1, 1 ), skip = 1 ), stringsAsFactors = FALSE)
  names(hwe) <- c("CHR",	"POS",	"OBS",	"EXP",	"ChiSq",	"P" )

  hwe.df <-   with(hwe, {
    obs.mat <- t(data.frame(strsplit(OBS, split = "/")))
    data.frame(
      chr = as.factor(CHR),
      pos = as.integer(POS),
      chi.sq = as.numeric(ChiSq),
      p.value = as.numeric(P),
      homo.major = as.integer(obs.mat[,1]),
      het = as.integer(obs.mat[,2]),
      homo.minor = as.integer(obs.mat[,3])
      )
  })
  rownames(hwe.df) <- NULL
  return( hwe.df )
}
