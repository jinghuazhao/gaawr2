#!/usr/bin/bash

module load ceuadmin/htslib
export scallop_inf1=~/rds/results/private/proteomics/scallop-inf1/METAL
export f=${scallop_inf1}/IL.18R1-1.tbl.gz
export r=2:102700000-103800000

(
  gunzip -c ${f} | \
  head -1
  tabix ${f} ${r}
) | \
bgzip -f > IL.18R1-1.tbl.gz
tabix -f -S1 -s1 -b2 -e2 IL.18R1-1.tbl.gz

Rscript -e '
r <- Sys.getenv("r")
exposure <- TwoSampleMR::format_data(within(d,{P=10^logP}), phenotype_col="prot", snp_col="rsid",
                        chr_col="Chromosome", pos_col="Posistion",
                        effect_allele_col="Allele1", other_allele_col="Allele2",
                        eaf_col="Freq1", beta_col="Effect", se_col="StdErr",
                        pval_col="P", log_pval=FALSE,
                        samplesize_col="N")
outcome <- pQTLtools::import_OpenGWAS("ebi−a−GCST004132",r,"gwasvcf") %>%
           as.data.frame() %>%
           dplyr::mutate(outcome="Crohns disease",LP=10^-LP) %>%
           dplyr::select(ID,outcome,REF,ALT,AF,ES,SE,LP,SS,id) %>%
           setNames(c("SNP","outcome",paste0(c("other_allele","effect_allele","eaf","beta","se","pval","samplesize","id"),".outcome")))
harmonise <- TwoSampleMR::harmonise_data(clump,outcome)
prefix <- paste("IL.18R1,"cis",sep="-")
pQTLtools::run_TwoSampleMR(harmonise, mr_plot="pQTLtools", prefix=prefix)
`
# https://jinghuazhao.github.io/INF/doc/GWAS-INF.pdf
# Eczema(ieu−a−996)
