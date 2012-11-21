THISPKG <- "vcf2R"
.onAttach <- function(libname, pkgname) {
	version <- packageDescription("vcf2R", field="Version")
	packageStartupMessage(paste("
==================================
Welcome to vcf2R version ", version, "\n",
"by Samuel G. Younkin

The package for parsing vcftools
output files and creating nice R
objects.

I hope that you will be loving it!
==================================", sep = "" ) )
}

.onUnload <- function(libpath){
	library.dynam.unload(THISPKG, libpath)
}
