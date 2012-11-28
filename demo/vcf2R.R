file <- system.file( "extdata", "snvs.fixed_header.frq", package = "vcf2R")
maf.di <- frq2R( file )
summary(maf.di)
pos.df <- frq2pos( file )
head(pos.df)

data("targets")

