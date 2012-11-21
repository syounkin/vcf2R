THISPKG <- "vcf2R"
.onAttach <- function(libname, pkgname) {
	version <- packageDescription("vcf2R", field="Version")
	packageStartupMessage(paste("=================================
Welcome to vcf2R version ", version, "\nby Samuel G. Younkin\nThe package for parsing vcftools output files and creating nice R objects.\nI hope that you will be loving it!\n=================================", sep = "" ) )
}

.onUnload <- function(libpath){
	library.dynam.unload(THISPKG, libpath)
}
