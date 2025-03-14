use_ontologyIndex <- function()
{
  library(ontologyIndex)
  id <- function(ontology)
  {
    inflammatory <- grep(ontology$name,pattern="inflammatory")
    immune <- grep(ontology$name,pattern="immune")
    inf <- union(inflammatory,immune)
    list(id=ontology$id[inf],name=ontology$name[inf])
  }
# GO
  data(go)
  goidname <- id(go)
# EFO
  file <- "efo.obo" # efo-3.26.0
  get_relation_names(file)
  efo <- get_ontology(file, extract_tags="everything")
  length(efo) # 89
  length(efo$id) # 27962
  efoidname <- id(efo)
  diseases <- get_descendants(efo,"EFO:0000408")
  efo_0000540 <- get_descendants(efo,"EFO:0000540")
  efo_0000540name <- efo$name[efo_0000540]
  isd <- data.frame(efo_0000540,efo_0000540name)
  save(efo,diseases,isd,efoidname,goidname, file="efo.rda")
  write.table(isd,file="efo_0000540.csv",col.names=FALSE,row.names=FALSE,sep=",")
  library(ontologyPlot)
  onto_plot(efo,efo_0000540)
}
