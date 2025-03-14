run_HardyWeinberg <- function()
{
  options.default <- options()
  options(width=200,digits=2)
# MN blood group
  SNP <- c(MM = 298, MN = 489, NN = 213)
  HardyWeinberg::maf(SNP)
  HardyWeinberg::HWTernaryPlot(SNP,region=0,hwcurve=FALSE,grid=TRUE,markercol="blue")
  HardyWeinberg::HWChisq(SNP, cc = 0, verbose = TRUE)
# png("MN.png",res=300,width=8,height=6,units="in")
# HardyWeinberg::HWTernaryPlot(SNP,region=0,hwcurve=FALSE,grid=TRUE,markercol="blue")
# dev.off()
# Chromosome X
  xSNP <- c(A=10, B=20, AA=30, AB=20, BB=10)
  HardyWeinberg::HWChisq(xSNP,cc=0,x.linked=TRUE,verbose=TRUE)
# HLA/DQR
  library(gap)
  DQR <- hla[,3:4]
  a1 <- DQR[1]
  a2 <- DQR[2]
  GenotypeCounts <- HardyWeinberg::AllelesToTriangular(a1,a2)
  knitr::kable(GenotypeCounts,caption="Genotype distribution of DQR")
  HardyWeinberg::HWPerm.mult(GenotypeCounts,nperm=1000)
  HardyWeinberg::HWStr(hla[,3:4],test="permutation",nperm=1000)
  options(options.default)
}
