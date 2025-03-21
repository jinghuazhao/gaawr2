#!/usr/bin/bash

module load ceuadmin/htslib
export csd3_inf1=~/rds/results/private/proteomics/scallop-inf1/METAL
export f=${csd3_inf1}/IL.18R1-1.tbl.gz
export r=2:102700000-103800000

(
  gunzip -c ${f} | \
  head -1
  tabix ${f} ${r}
) | \
bgzip -f > IL.18R1-1.tbl.gz
tabix -f -S1 -s1 -b2 -e2 IL.18R1-1.tbl.gz

export gcst_inf1=https://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90274001-GCST90275000/
export gcst=${gcst_inf1}/GCST90274804/harmonised/GCST90274804.h.tsv.gz
(
  wget -qO- ${gcst} | \
  gunzip -c | \
  head -1
  tabix ${gcst} ${r}
) | \
bgzip -f > IL.18R1.gz
tabix -f -S1 -s1 -b2 -e2 IL.18R1.gz
rm GCST90274804.h.tsv.gz.tbi

Rscript -e '
suppressMessages(library(dplyr))
r <- Sys.getenv("r")
d <- read.delim(file.path("tests","IL.18R1-1.tbl.gz"))
metal <- TwoSampleMR::format_data(within(d,{P=10^log.P.}), phenotype_col="prot", snp_col="MarkerName",
                      chr_col="Chromosome", pos_col="Posistion",
                      effect_allele_col="Allele1", other_allele_col="Allele2",
                      eaf_col="Freq1", beta_col="Effect", se_col="StdErr",
                      pval_col="P", log_pval=FALSE,
                      samplesize_col="N")
gcst <- TwoSampleMR::format_data(read.delim(file.path("tests","IL.18R1.gz")),
                     chr_col="chromosome", pos_col="base_pair_location", snp_col="rsid",
                     effect_allele_col="effect_allele", other_allele_col="other_allele",
                     eaf_col="effect_allele_frequency", beta_col="beta", se_col="standard_error",
                     pval_col="p_value", log_pval=FALSE,
                     samplesize_col="n")
outcome <- pQTLtools::import_OpenGWAS("ebi−a−GCST004132",r,"gwasvcf") %>%
           as.data.frame() %>%
           dplyr::mutate(outcome="Crohns disease",LP=10^-LP) %>%
           dplyr::select(ID,outcome,REF,ALT,AF,ES,SE,LP,SS,id) %>%
           setNames(c("SNP","outcome",paste0(c("other_allele","effect_allele","eaf","beta","se","pval","samplesize","id"),".outcome")))
clump <- TwoSampleMR::clump_data(gcst)
harmonise <- TwoSampleMR::harmonise_data(clump,outcome)
prefix <- paste("IL.18R1,"cis",sep="-")
pQTLtools::run_TwoSampleMR(harmonise, mr_plot="pQTLtools", prefix=prefix)
`
# https://jinghuazhao.github.io/INF/doc/GWAS-INF.pdf
# Eczema(ieu−a−996)
