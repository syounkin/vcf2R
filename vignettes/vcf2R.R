### R code from vignette source './vcf2R.Rnw'

###################################################
### code chunk number 1: vcf2R.Rnw:3-4
###################################################
  options(width=70, continue = " ")


###################################################
### code chunk number 2: packages
###################################################
library("vcf2R")
library("GenomicRanges")
library("BSgenome.Hsapiens.UCSC.hg19")


###################################################
### code chunk number 3: pos
###################################################
file <- system.file( "extdata", "snvs.fixed_header.frq", package = "vcf2R")
pos.df <- frq2pos( file )
head(pos.df)


###################################################
### code chunk number 4: loci
###################################################
with( pos.df, table(chr) )
pos.gr <- with( pos.df, GRanges( seqnames = paste("chr", chr, sep = ""), ranges = IRanges( start = pos, end = pos ), strand = "+" ) )
seqlengths(pos.gr) <- seqlengths(Hsapiens)[levels(seqnames(pos.gr))]
start(pos.gr) <- start(pos.gr) - 10e3
end(pos.gr) <- end(pos.gr) + 10e3
loci <- reduce(pos.gr)
start(loci) <- start(loci) + 10e3
end(loci) <- end(loci) - 10e3


###################################################
### code chunk number 5: width
###################################################
val <- data.frame( n.snps = countOverlaps(loci, pos.gr), kb = width(loci)/1e3 )
values(loci) <- val
names(loci) <- c("PAX7", "ABCA4", "IRF6", "VAX1", "FGFR2", "BMP4", "NTN1", "NOG", "MAFB", "MSX1", "8q24", "PTCH1", "FOXE1")
loci
sum(width(loci))/1e6
with( values(loci), sum(n.snps) )


###################################################
### code chunk number 6: targets
###################################################
data("targets")
targets.gr


###################################################
### code chunk number 7: hwe2R
###################################################
file <- system.file( "extdata", "snvs.fixed_header.hwe", package = "vcf2R")
hwe.df <- hwe2R( file = file )
head(hwe.df)


###################################################
### code chunk number 8: txdf
###################################################
library("TxDb.Hsapiens.UCSC.hg19.knownGene")
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
txgr <- transcripts(txdb)
txdf <- as.data.frame(txgr)
txdf <- within(txdf, {
#  exon <- NA
  chr <- substr(seqnames,4,10)
  transcript <- tx_name
})
txdf <- txdf[,-c(1,4)]


###################################################
### code chunk number 9: kg
###################################################
known.gene.file <- system.file( "extdata", "known-genes", package = "vcf2R" )
kg.df <- data.frame(scan( file = known.gene.file, sep = "\t", what = list("",1L,1L,"","","",1L,1L,1L,1L,"","") ))
names(kg.df) <- c("chr", "start", "end", "name", "foo", "strand", "cds.start", "cds.end", "foo2", "num.exons", "exon.coods.start", "exon.coods.end" )
kg.gr <- GRanges( seqnames = kg.df$chr, ranges = IRanges( start = kg.df$start, end = kg.df$end ), strand = kg.df$strand )


###################################################
### code chunk number 10: track1
###################################################
library("Gviz")
library("GenomicRanges")

data(geneModels)
ht <- 20; wd <- ht*1.618;
for( locus in names(loci) ){

  gr <- targets.gr[names(targets.gr)==locus,]
  chr <- as.character(unique(seqnames(gr)))
  seqlengths(gr) <- seqlengths(Hsapiens)[levels(seqnames(gr))]
  atrack <- AnnotationTrack(gr, name=paste0(locus, " Target"), chromosome = chr, genome = "hg19", stacking = "squish")
  kg.sub.df <- as.data.frame(kg.gr[subjectHits(findOverlaps( loci[names(loci)==locus,], kg.gr )),])
  kg.sub.df <- kg.sub.df[,-c(1,4,5)]
  gtrack <- GenomeAxisTrack()
  grtrack <- GeneRegionTrack(kg.sub.df, genome="hg19", chromosome=as.character(seqnames(loci)[which(names(loci)==locus)]), name="Gene Model")
  itrack <- IdeogramTrack(genome="hg19", chromosome=chr)
  atrack2 <- AnnotationTrack(loci[names(loci)==locus,], chromosome = chr, genome = "hg19", name=paste0(locus, " Actual"), stacking = "squish")
  pdf( file = paste0( "./figures/", locus, ".pdf" ), height = ht, width = wd )
  plotTracks(list(atrack2,atrack,grtrack,gtrack,itrack), add = FALSE)
  dev.off()
}


