options(width=200,digits=2)
data(asthma, package = "SNPassoc")
str(asthma, list.len=8)
knitr::kable(asthma[1:3,1:8],caption="First three records & two SNPs")
snpCols <- colnames(asthma)[6+(1:2)]
snps <- SNPassoc::setupSNP(data=asthma[snpCols], colSNPs=1:length(snpCols), sep="")
head(snps)
summary(snps, print=FALSE)
lapply(snps, head)
lapply(snps, summary)
SNPassoc::tableHWE(snps)

asthma.snps <- asthma %>%
               dplyr::rename(cc=casecontrol) %>%
               SNPassoc::setupSNP(colSNPs=(6+1):ncol(.), sep="")
# Model 1: Simple SNP association with BMI
SNPassoc::association(bmi ~ rs4490198, data = asthma.snps)

# Model 2: SNP association with case-control status
SNPassoc::association(cc ~ rs4490198, data = asthma.snps)

# Model 3: SNP association with covariates (country and smoke)
SNPassoc::association(cc ~ rs4490198 + country + smoke, data = asthma.snps)

# Model 4: SNP association with stratification by gender
SNPassoc::association(cc ~ rs4490198 + survival::strata(gender), data = asthma.snps)

# Model 5: SNP association with subset (only Spain)
SNPassoc::association(cc ~ rs4490198, data = asthma.snps, subset = country == "Spain")

# Model 6: Interaction between SNP (dominant model) and smoking
SNPassoc::association(cc ~ SNPassoc::dominant(rs4490198) * factor(smoke), data = asthma.snps)

# Model 7: Interaction between two SNPs (dominant model for rs4490198)
SNPassoc::association(cc ~ rs4490198 * factor(rs11123242), data = asthma.snps, model.interaction = "dominant")

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
