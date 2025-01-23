data(example,package="GMMAT")
attach(example)
model0 <- glmmkin(disease ~ age + sex, data = pheno, kins = GRM,
          id = "id", family = binomial(link = "logit"))
model1 <- glmmkin(fixed = trait ~ age + sex, data = pheno, kins = GRM,
          id = "id", family = gaussian(link = "identity"))
model2 <- glmmkin(fixed = trait ~ age + sex, data = pheno, kins = GRM,
          id = "id", groups = "disease", 
          family = gaussian(link = "identity"))
snps <- c("SNP10", "SNP25", "SNP1", "SNP0")
geno.file <- system.file("extdata", "geno.bgen", package = "GMMAT")
samplefile <- system.file("extdata", "geno.sample", package = "GMMAT")
outfile <- "glmm.score.txt"
glmm.score(model0, infile = geno.file, 
           BGEN.samplefile = samplefile,
           outfile = outfile)
read.delim(outfile) |>
  head(n=4) |>
  knitr::kable(caption="Score tests under GLMM on four SNPs",digits=2)
unlink(outfile)
bed.file <- system.file("extdata", "geno.bed", package = "GMMAT") |>
            tools::file_path_sans_ext()
model.wald <- glmm.wald(fixed = disease ~ age + sex, data = pheno,
                        kins = GRM, id = "id", family = binomial(link = "logit"),
                        infile = bed.file, snps = snps)
knitr::kable(model.wald,caption="Wald tests under GLMM on four SNPs")
detach(example)
