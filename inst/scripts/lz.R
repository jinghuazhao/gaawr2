require(locuszoomr)
require(EnsDb.Hsapiens.v75)

data(SLE_gwas_sub,package="locuszoomr")
head(SLE_gwas_sub)
loc <- locuszoomr::locus(data = SLE_gwas_sub, gene = 'UBE2L3', flank = 1e5,
                         ens_db = "EnsDb.Hsapiens.v75")
loc <- locuszoomr::link_LD(loc, token = Sys.getenv("LDLINK_TOKEN"))
summary(loc)
locuszoomr::locus_plot(loc)
locuszoomr::locus_plot(loc, filter_gene_biotype = "protein_coding")
locuszoomr::locus_plot(loc, filter_gene_name = c('UBE2L3', 'RIMBP3C', 'YDJC', 'PPIL2',
                                                 'PI4KAP2', 'MIR301B'))
loc2 <- locuszoomr::locus(SLE_gwas_sub, gene = 'IRF5', flank = c(7e4, 2e5), LD = "r2",
                          ens_db = "EnsDb.Hsapiens.v75")
require(rtracklayer)
bw38 <- "https://hgdownload.soe.ucsc.edu/gbdb/hg38/recombRate/recomb1000GAvg.bw"
bw19 <- "https://hgdownload.soe.ucsc.edu/gbdb/hg19/decode/hapMapRelease24CombinedRecombMap.bw"
download.file(bw19, destfile = basename(bw19))
recomb.hg19 <- rtracklayer::import.bw(basename(bw19))
unlink(basename(bw19))
loc3 <- locuszoomr::locus(SLE_gwas_sub, gene = 'STAT4', flank = 1e5, LD = "r2",
                          ens_db = "EnsDb.Hsapiens.v75")
loc3 <- locuszoomr::link_recomb(loc3, recomb = recomb.hg19)
locuszoomr::locus_plot(loc3)

p1 <- locuszoomr::locus_ggplot(loc, labels = "index", nudge_x = 0.03)
p2 <- locuszoomr::locus_ggplot(loc2, legend_pos = NULL)

library(cowplot)
cowplot::plot_grid(p1, p2, ncol = 1)

library(ggpubr)
ggpubr::ggarrange(p1, p2, ncol = 1)

library(gridExtra)
gridExtra::grid.arrange(p1, p2, ncol = 1)

locuszoomr::locus_ggplot(loc)
locuszoomr::gg_scatter(loc)
locuszoomr::gg_genetracks(loc)
p <- locuszoomr::gg_scatter(loc)
locuszoomr::gg_addgenes(p, loc)
locuszoomr::locus_plotly(loc)

locuszoomr::multi_layout(ncol = 3,
             plots = {
               locuszoomr::locus_plot(loc, use_layout = FALSE, legend_pos = 'topleft')
               locuszoomr::locus_plot(loc2, use_layout = FALSE, legend_pos = NULL)
               locuszoomr::locus_plot(loc3, use_layout = FALSE, legend_pos = NULL, labels = "index")
             })
