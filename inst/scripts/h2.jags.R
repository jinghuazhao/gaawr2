require(gap)
set.seed(1234567)
meyer <- within(meyer,{
         y[is.na(y)] <- rnorm(length(y[is.na(y)]),mean(y,na.rm=TRUE),sd(y,na.rm=TRUE))
         g1 <- ifelse(generation==1,1,0)
         g2 <- ifelse(generation==2,1,0)
         id <- animal
         animal <- ifelse(!is.na(animal),animal,0)
         dam <- ifelse(!is.na(dam),dam,0)
         sire <- ifelse(!is.na(sire),sire,0)
     })
G <- kin.morgan(meyer)$kin.matrix*2
library(regress)
r <- regress(y~-1+g1+g2,~G,data=meyer)
r
with(r,h2G(sigma,sigma.cov))
eps <- 0.001
y <- with(meyer,y)
x <- with(meyer,cbind(g1,g2))
ex <- h2.jags(y,x,G,sigma.p=0.03,sigma.r=0.014)
print(ex)
require(coda)
ex.mcmc <- as.mcmc(ex)
traceplot(ex.mcmc)
densplot(ex.mcmc)
