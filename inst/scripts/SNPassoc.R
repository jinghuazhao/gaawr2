options(width=200,digits=2)
library(dplyr)
library(SNPassoc)
data(asthma, package = "SNPassoc")
str(asthma, list.len=9)
knitr::kable(asthma[1:3,1:8],caption="First three records & two SNPs")

snpCols <- grep("^rs", colnames(asthma), value=TRUE)[1:5]
snps <- setupSNP(data=asthma[snpCols], colSNPs=1:length(snpCols), sep="")
summary(snps, print=FALSE)
lapply(snps, head)
lapply(snps, summary)
knitr::kable(tableHWE(snps),caption="Table of HWE")

asthma.snps <- setupSNP(data=asthma, colSNPs=grep("^rs", colnames(asthma)), sep="") %>%
               dplyr::rename(cc=casecontrol) %>%
               dplyr::select(1:11)
association(bmi ~ rs4490198, asthma.snps)
association(cc ~ rs4490198, data=asthma.snps)
association(cc ~ rs4490198 + country + smoke, asthma.snps)
association(cc ~ rs4490198 + survival::strata(gender), asthma.snps)
association(cc ~ rs4490198, asthma.snps, subset=country=="Spain")
association(cc ~ dominant(rs4490198)*factor(smoke), data=asthma.snps)
association(cc ~ rs4490198*factor(rs11123242), data=asthma.snps, model.interaction = "dominant" )

assoc <- SNPassoc::WGassociation(cc, data=asthma.snps, mc.cores=5)
assoc %>%
as.data.frame() %>%
dplyr::select(-comments) %>%
knitr::kable(caption="SNP association")
assoc.adj <- SNPassoc::WGassociation(cc ~ country + smoke, asthma.snps, mc.cores=5)
assoc.adj %>%
as.data.frame() %>%
dplyr::select(-comments) %>%
knitr::kable(caption="with adjustment for contountry & smoking")
assoc.maxstat <- SNPassoc::maxstat(asthma.snps, cc)
knitr::kable(t(assoc.maxstat[,]),caption="Max stat association statistics")
