#!/usr/bin/bash

module load ceuadmin/htslib
export scallop_inf1=~/rds/results/private/proteomics/scallop-inf1/METAL

(
  export f=${scallop_inf1}/IL.18R1-1.tbl.gz
  gunzip -c ${f} | \
  head -1
  tabix ${f} 2:102700000-103800000
) | \
bgzip -f > IL.18R1-1.tbl.gz
tabix -f -S1 -s1 -b2 -e2 IL.18R1-1.tbl.gz
