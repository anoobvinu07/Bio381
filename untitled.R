dat <- na.omit( read.csv(filename) )
pnorm(1) - pnorm(-1)
pnorm(2) - pnorm(-2)
pnorm(3) - pnorm(-3)
library(dplyr)
y <- filter(dat, Sex=="M" & Diet=="chow") %>% select(Bodyweight) %>% unlist
z <- ( y - mean(y) ) / popsd(y)
mean( abs(z) <=1 )
mean( abs(z) <=2 )
mean( abs(z) <=3 )

set.seed(1)
y <- filter(dat, Sex=="M" & Diet=="chow") %>% select(Bodyweight) %>% unlist
avgs <- replicate(10000, mean( sample(y, 25)))
mypar(1,2)
hist(avgs)
qqnorm(avgs)
qqline(avgs)
mean(avgs)
popsd(avgs)

dir()
setwd('ststistics_n_R/')
library(dplyr)
babies <- read.table('babies.txt', header = T)
head(babies)
bwt.nonsmoke <- filter(babies, smoke == 0) %>% select(bwt) %>% unlist
bwt.smoke <- filter(babies, smoke == 1) %>% select(bwt) %>% unlist
library(rafalib)
mean(bwt.nonsmoke) - mean(bwt.smoke)
popsd(bwt.nonsmoke)
popsd(bwt.smoke)

set.seed(1)
dat.ns <- sample(bwt.nonsmoke,25)
dat.s <- sample(bwt.smoke,25)
tval <- t.test(dat.ns,dat.s)$statistic
tval
pval <- 1 - (pnorm(abs(tval)) - pnorm(-abs(tval)))
pval <- 1-(pnorm(abs(tval))-pnorm(-abs(tval)))
pval
N <- 25
qnorm(.995)*sqrt( var( dat.ns)/N + var( dat.s)/N )


babies <- read.table('babies.txt', header = T)
head(babies)
bwt.nonsmoke <- filter(babies, smoke == 0) %>% select(bwt) %>% unlist
bwt.smoke <- filter(babies, smoke == 1) %>% select(bwt) %>% unlist
library(rafalib)
mean(bwt.nonsmoke) - mean(bwt.smoke)
popsd(bwt.nonsmoke)
popsd(bwt.smoke)

controls<- rnorm(5000, mean=24, sd=3.5) 
ttestgenerator <- function(n, mean=24, sd=3.5) {
  cases <- rnorm(n,mean,sd)
  controls <- rnorm(n,mean,sd)
  tstat <- (mean(cases)-mean(controls)) / 
    sqrt( var(cases)/n + var(controls)/n ) 
  return(tstat)
}
