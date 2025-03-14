
# A summary of files

Filename   | Description
-----------|--------------------------------
biomaRt.R  | biomaRt query
cran.sh*   | CRAN package extraction 
docs.sh*   | GitHub updates
ens.R      | Ensembl database
gaawr2.R   | R/**gaawr2** creation
github.sh* | GitHub/**gaawr2** creation
GMMAT.R    | **GMMAT** script
h2.jags.R  | h2.jags documentation example
haplo.stats.R    | **haplo.stats** script
HardyWeinberg.R  | **HardyWeinberg** scrip
hello.R    | "Hello, world!"
httr.R     | **httr** script
lz.R       | **locuszoomr** script
ontologyIndex.R  | **ontologyIndex** script
OpenTargets.R    | OpenTarget query
pkgdown.sh*| **pkgdown** script
powerEQTL.R| **powerEQTL** script
README.md  | This file
rentrez.R  | **entrez** query
SNPassoc.R | **SNPassoc** script
tabix.sh*  | **tabix** script

Given the limited allowance for computing time for CRAN checking, scripts here are largely perferable to those in the package vignette, 
[`gaawr2`]. Owing to CRAN poly, R scripts are revised to be functions.

Additionally,

- `cran.sh` makes a copy of the latest repository but drops files not needed by CRAN.
- `hwe_ternary_plotly.py` is a Python script using plotly for the HWE ternary plot whose top vertex (the “a‑axis”) represents A1A2, the left vertex (the “b‑axis”) A1A2, and the right vertex (the “c‑axis”) A2A2.
