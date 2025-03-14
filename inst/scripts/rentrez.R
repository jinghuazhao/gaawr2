run_rentrez <- function()
{
  library(rentrez)
  entrez_dbs()
  entrez_db_links("pubmed")
  pubmed_fields <- entrez_db_searchable("pubmed")
# set_entrez_key("")
  Sys.getenv("ENTREZ_KEY")
  term <- "pQTLs OR (protein AND quantitative AND trait AND loci) AND human [MH] AND (plasma OR Serum)"
  r <- entrez_search(db="pubmed",term=term,use_history=TRUE)
  class(r)
  names(r)
  with(r,web_history)
  unlink(paste("pubmed",c("fetch","summary"),sep="."))
  fields <- c("uid", "pubdate", "sortfirstauthor", "title", "source", "volume", "pages")
  for(i in seq(1,with(r,count),50))
  {
    cat(i+49, "records downloaded\r")
    f <- entrez_fetch(db="pubmed", web_history=with(r,web_history), rettype="text", retmax=50, retstart=i)
    write.table(f, col.names=FALSE, row.names=FALSE, file="pubmed.fetch", append=TRUE)
    s <- entrez_summary(db="pubmed", web_history=with(r,web_history), rettype="text", retmax=50, retstart=i)
    e <- extract_from_esummary(s, fields)
    write.table(t(e), col.names=FALSE, row.names=FALSE, file="pubmed.summary", append=TRUE, sep="\t")
  }
  id <- 600807
  upload <- entrez_post(db="omim", id=id)
  asthma_variants <- entrez_link(dbfrom="omim", db="clinvar", cmd="neighbor_history", web_history=upload)
  asthma_variants
  snp_links <- entrez_link(dbfrom="clinvar", db="snp", web_history=asthma_variants$web_histories$omim_clinvar, cmd="neighbor_history")
  all_links <- entrez_link(dbfrom='pubmed', id=id, db='all')
}
