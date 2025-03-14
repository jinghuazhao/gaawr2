use_biomaRt <- function()
{
  library(biomaRt)
  if (!biomaRt::martBMCheck(mart)) {
    stop("The BioMart service is currently unavailable.")
  }
  biomaRt::listMarts()
  ensembl <- biomaRt::useMart("ensembl", dataset="hsapiens_gene_ensembl", host="grch37.ensembl.org", path="/biomart/martservice")
  biomaRt::listDatasets(ensembl)
  attr <- biomaRt::listAttributes(ensembl)
  attr_select <- c('ensembl_gene_id', 'chromosome_name', 'start_position', 'end_position', 'description', 'hgnc_symbol',
                   'transcription_start_site')
  gene <- biomaRt::getBM(attributes = attr_select, mart = ensembl)
  filter <- biomaRt::listFilters(ensembl)
  biomaRt::searchFilters(mart = ensembl, pattern = "gene")
# GRCh38
  ensembl <- biomaRt::useMart("ensembl", dataset="hsapiens_gene_ensembl")
}
