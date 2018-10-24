### Probability distributitions
### October 02, 2018
### AP

library(ggplot2)
library(MASS)
#Poissons Distribution
# Discrete X >= 0
# Random events occur with a constant rate lambda

MyVec <- dpois(x=seq(0,10), lambda = 1)
names(MyVec) <- seq(0,10)
barplot(height = MyVec)

MyVec <- dpois(x=seq(0,10), lambda = 5)
names(MyVec) <- seq(0,10)
barplot(height = MyVec)

MyVec <- dpois(x=seq(0,20), lambda = 10)
names(MyVec) <- seq(0,20)
barplot(height = MyVec)

MyVec <- dpois(x=seq(0,10), lambda = 0.2)
names(MyVec) <- seq(0,10)
barplot(height = MyVec)

# sum of the area under the curve is 1
sum(MyVec)

# with lambda = 0.2, what is the probability of obtaining a zero?
dpois(x=0,lambda=2)

# p function for cumulative distribution values

hits <- 0:10
myVec <- ppois(q=hits, lambda = 2)
qplot(x=hits, y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

# for a poisson with lambda=2, what is the probability of a single draw yielding X <= 1

ppois(q=1,lambda=2)

p1 <- dpois(x=0,lambda=2)
p1
p2 <- dpois(x=1,lambda = 2)
p2
p1+p2

# the p function is the inverse of the p function

# what is the number of hits corresponding to a tail probability mass?

qpois(p=0.5,lambda = 2.5)
qplot(x=0:10, y=dpois(x=0:10, lambda = 2.5),geom="col", color=I("black"),fill=I("goldenrod"))

# simulate values directly
ranPois <- rpois(n=1000,lambda=2.5)
qplot(x=ranPois, color=I("black"),fill=I("goldenrod"))

# for real or simulated data, get a 95% interval over the distribution

quantile(x=ranPois, probs=c(0.025,0.975))

# binomial function
# p = probability of dichotoous outcome
# number of trials
# x = possible outcomes
# x is bounded between 0 and number of trials

hits <- 0:10
myVec <- dbinom(x=hits,size = 10,prob = 0.5)
qplot(x=0:10,y=myVec, geom = "col", color=I("black"),fill=I("goldenrod"))
# what is the probability of getting 5 heads out of 10 coin tosses?
dbinom(x=5,size=10,prob=0.95)
myVec <- dbinom(x=5,size=10,prob=0.95)
qplot(x=0:10,y=myVec,geom = "col", color=I("black"),fill=I("goldenrod"))
pbinom(q=5,size=10,prob=0.5)
pbinom(q=4,size=9,prob=0.5)

#get an exact 95% confidence interval
qbinom(p=c(0.025,0.975),size=100,prob=0.7)



myCoins <- rbinom(n=50,size=100,prob=0.5)
qplot(x=myCoins,color=I("black"),fill=I("goldenrod"))

# negative binomial
# if we have a series of (Bernouli) trials with p=probability of success
#how many failures until we reach that number of successes?
# a Poisson process in which the value of lambda is not constant.

nbiRan <- rnbinom(n=1000,size=10,mu=5)
qplot(x=nbiRan,color=I("black"),fill=I("goldenrod"))

# increase size parameter(= less variable)
nbiRan <- rnbinom(n=1000,size=100,mu=5)
qplot(x=nbiRan,color=I("black"),fill=I("goldenrod"))

# decrease size parameter(= less variable)
nbiRan <- rnbinom(n=1000,size=0.1,mu=5)
qplot(x=nbiRan,color=I("black"),fill=I("goldenrod"))

### continous distribution

# unifrom
# params = minimum and maximum

x <- runif(1000, min=10,max=5)
qplot(x=x,color=I("black"),fill=I("goldenrod"))

# normal distribution
myNorm = rnorm(n=100, mean = 100,sd=2)
qplot(x=myNorm,color=I("black"),fill=I("goldenrod"))

myNorm <- rnorm(n=100, mean = 2,sd=2)
qplot(x=myNorm,color=I("black"),fill=I("goldenrod"))
summary(myNorm)

tossZeroes <- myNorm[myNorm>0]
qplot(x=tossZeroes,color=I("black"),fill=I("goldenrod"))
summary(tossZeroes)


# gamma distribution, continous positive values
# unbounded but > 0
# shape parameter
# scale parameter

myGamma <- rgamma(n=100, shape = 1, scale = 10)
qplot(x=myGamma,color=I("black"),fill=I("goldenrod"))

# gamma with shape = 1 is exponential distribution
# with mean = scale parameter
# (size parameter in negative binomial is equivalent to the shape parameter for a gamma distribution of lambdas)

# shape <= 1 mode is very close to 0
myGamma <- rgamma(n=100, shape = 0.1, scale = 1)
qplot(x=myGamma,color=I("black"),fill=I("goldenrod"))
# mean = shape*scale
# variance = shape*scale^2

### beta distribution
# continuous, bounded at 0 and 1
# analogous to the binomial
# but it is the distribution of probability values, not the distribution of the number of successes
# shape1 = number of successes + 1
# shape2 = number of failures + 1

# shape1 = 1, shape2=1
myBeta <- rbeta(n=1000, shape1 = 1, shape2 = 1)
qplot(x=myBeta,color=I("black"),fill=I("goldenrod"))

# shape1 = 2, shape2 = 1
myBeta <- rbeta(n=1000, shape1 = 2, shape2 = 1)
qplot(x=myBeta,color=I("black"),fill=I("goldenrod"))

# two tosses 1 head and 1 tail
myBeta <- rbeta(n=1000, shape1 = 2, shape2 = 2)
qplot(x=myBeta,color=I("black"),fill=I("goldenrod"))

# throw two tails
myBeta <- rbeta(n=1000, shape1 = 1, shape2 = 3)
qplot(x=myBeta,color=I("black"),fill=I("goldenrod"))

# get better data
myBeta <- rbeta(n=1000, shape1 = 70, shape2 = 30)
qplot(x=myBeta,xlim = c(0,1), color=I("black"),fill=I("goldenrod"))

myBeta <- rbeta(n=1000, shape1 = 0.1, shape2 = 0.5)
qplot(x=myBeta,xlim = c(0,1), color=I("black"),fill=I("goldenrod"))

