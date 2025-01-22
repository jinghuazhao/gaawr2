library(SNPassoc)
library(dplyr)
data(asthma, package = "SNPassoc")
asthma.snps <- SNPassoc::setupSNP(data=asthma, colSNPs=grep("^rs", colnames(asthma)), sep="")
asthma.snps <- setupSNP(data=asthma, colSNPs=grep("^rs", colnames(asthma)), sep="") %>%
               dplyr::rename(cc=casecontrol)
library(haplo.stats)
snpsH <- c("rs714588", "rs1023555",  "rs898070")
genoH <- SNPassoc::make.geno(asthma.snps, snpsH)
em <- haplo.stats::haplo.em(genoH, locus.label = snpsH, miss.val = c(0, NA))
em
knitr::kable(cbind(em$haplotype,em$hap.prob),caption="Haplotypes of rs714588, rs1023555, rs898070")

mod <- haplo.stats::haplo.glm(cc ~ genoH, data=asthma.snps,
                              family="binomial",
                              locus.label=snpsH,
                              allele.lev=attributes(genoH)$unique.alleles,
                              control = haplo.stats::haplo.glm.control(haplo.freq.min=0.05))
mod
SNPassoc::intervals(mod)
snpsH2 <- labels(asthma.snps)[6:15]
genoH2 <- make.geno(asthma.snps, snpsH2)
haplo.score <- list()
for (i in 1:4) haplo.score[[i]] <- haplo.stats::haplo.score.slide(asthma.snps$cc, genoH2,
                                         trait.type="binomial",
                                         n.slide=i+3,
                                         simulate=TRUE,
                                         sim.control=haplo.stats::score.sim.control(min.sim=100,
                                         max.sim=200)) 
par(mfrow=c(2,2))
for (i in 1:4) {
    plot(haplo.score[[i]])
    title(paste("Sliding Window=", i+3, sep=""))
}
snpsH3 <- snpsH2[4:7]
genoH3 <- make.geno(asthma.snps, snpsH3)
mod <- haplo.stats::haplo.glm(cc~genoH3, data=asthma.snps,
             family="binomial",
             locus.label=snpsH3,
             allele.lev=attributes(genoH3)$unique.alleles,
             control = haplo.stats::haplo.glm.control(haplo.freq.min=0.05))
mod
SNPassoc::intervals(mod)
mod.adj.ref <- glm(cc ~ smoke, data=asthma.snps, family="binomial")
mod.adj <- haplo.glm(cc ~ genoH3 + smoke, data=asthma.snps,
                 family="binomial",
                 locus.label=snpsH3,
                 allele.lev=attributes(genoH3)$unique.alleles,
                 control = haplo.stats::haplo.glm.control(haplo.freq.min=0.05))
mod.adj
lrt.adj <- mod.adj.ref$deviance - mod.adj$deviance
pchisq(lrt.adj, mod.adj$lrt$df, lower=FALSE)
