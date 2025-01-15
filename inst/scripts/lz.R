require(locuszoomr)
require(rtracklayer)
require(EnsDb.Hsapiens.v75)
data(SLE_gwas_sub,package="locuszoomr")
head(SLE_gwas_sub)
loc <- locuszoomr::locus(data = SLE_gwas_sub, gene = 'UBE2L3', flank = 1e5,
                         ens_db = "EnsDb.Hsapiens.v75")
loc <- locuszoomr::link_LD(loc, token = Sys.getenv("LDLINK_TOKEN"))
summary(loc)
bw38 <- "https://hgdownload.soe.ucsc.edu/gbdb/hg38/recombRate/recomb1000GAvg.bw"
bw19 <- "https://hgdownload.soe.ucsc.edu/gbdb/hg19/decode/hapMapRelease24CombinedRecombMap.bw"
download.file(bw19, destfile = basename(bw19))
recomb.hg19 <- rtracklayer::import.bw(basename(bw19))
unlink(basename(bw19))
loc <- locuszoomr::link_recomb(loc, recomb = recomb.hg19)
locuszoomr::locus_plot(loc)
locuszoomr::locus_plot(loc, filter_gene_biotype = "protein_coding")
locuszoomr::locus_plot(loc, filter_gene_name = c('UBE2L3', 'RIMBP3C', 'YDJC', 'PPIL2',
                                                 'PI4KAP2', 'MIR301B'))
locus_plotly(loc)
