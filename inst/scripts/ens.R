use_ensembl <- function()
{
  require(dplyr)
  require(EnsDb.Hsapiens.v75)
  ensembldb::metadata(EnsDb.Hsapiens.v75)
  ensembldb::keytypes(EnsDb.Hsapiens.v75)
  exon_info <- ensembldb::exons(EnsDb.Hsapiens.v75)
  gene_info <- ensembldb::genes(EnsDb.Hsapiens.v75)
  transcript_info <- ensembldb::transcripts(EnsDb.Hsapiens.v75)
  colnames(S4Vectors::mcols(gene_info))
  colnames(S4Vectors::mcols(transcript_info))
  overlaps <- IRanges::findOverlaps(transcript_info, gene_info)
  overlapping_transcripts <- transcript_info[queryHits(overlaps)]
  overlapping_genes <- gene_info[subjectHits(overlaps)]
  overlap_data <- data.frame(
    transcript_id = mcols(overlapping_transcripts)$tx_id,
    gene_id = S4Vectors::mcols(overlapping_genes)$gene_id,
    gene_name = S4Vectors::mcols(overlapping_genes)$gene_name,
    start = pmax(start(overlapping_transcripts), start(overlapping_genes)),
    end = pmin(end(overlapping_transcripts), end(overlapping_genes))
  )
  gene_symbols <- c("BRCA1", "TP53")
  gene_data <- subset(overlap_data,gene_name%in%gene_symbols,select=-c(gene_id,gene_name))
  cols <- c("UNIPROTID","PROTEINID","GENEID","GENENAME","SEQNAME","TXID")
  info <- ensembldb::select(EnsDb.Hsapiens.v75, keys = gene_symbols, 
                            columns = cols, keytype = "SYMBOL") |>
          subset(!is.na(UNIPROTID)) |>
          dplyr::left_join(gene_data,by=c('TXID'='transcript_id'))
# more focused on genes
  library(org.Hs.eg.db)
  keytypes(org.Hs.eg.db)
  uniprot_ids <- ensembldb::select(org.Hs.eg.db, keys = gene_symbols, columns = "UNIPROT", keytype = "SYMBOL")

# ensembldb::keytypes(EnsDb.Hsapiens.v75)
# [1] "ENTREZID"  "EXONID"  "GENEBIOTYPE" "GENEID" "GENENAME"  "PROTDOMID" "PROTEINDOMAINID" "PROTEINDOMAINSOURCE"
# [9] "PROTEINID" "SEQNAME" "SEQSTRAND"   "SYMBOL" "TXBIOTYPE" "TXID"      "TXNAME"          "UNIPROTID"
# colnames(S4Vectors::mcols(gene_info))
# [1] "gene_id"          "gene_name"        "gene_biotype"     "seq_coord_system" "symbol"           "entrezid"
# colnames(S4Vectors::mcols(transcript_info))
# [1] "tx_id"            "tx_biotype"       "tx_cds_seq_start" "tx_cds_seq_end"   "gene_id"          "tx_name"
# keytypes(org.Hs.eg.db)
# uniprot_ids <- ensembldb::select(org.Hs.eg.db, keys = gene_symbols, columns = "UNIPROT", keytype = "SYMBOL")
# dim(uniprot_ids)
}
