options(width=200)
library(gap)
library(HardyWeinberg)
DQR <- hla[,3:4]
a1 <- DQR[1]
a2 <- DQR[2]
GenotypeCounts <- AllelesToTriangular(a1,a2)
print(GenotypeCounts)
HWPerm.mult(GenotypeCounts,nperm=1000)
HWStr(hla[,3:4],test="permutation",nperm=1000)
