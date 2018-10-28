### Additional details on for loops
### October 25, 2018
### AP

library(tcltk2)
library(ggplot2)


#######################################################
# FUNCTION : RanWalk
# stochastic random walk
# input : times = number of time steps
#         n1 <- initial population size
#         lambda <- finite rate of increase
#         noiseSD <- standard deviation of rnorm(0)
#  output : vector n with population sizes > 0
#  until extinction, then NA
#######################################################
library(tcltk2)
library(ggplot2)
RanWalk <- function(times = 100,
                    n1 = 50,
                    lambda = 1.0,
                    noiseSD = 10){
  n <- rep(NA, times)
  n[1] <- n1 # initialize first population size
  noise <- rnorm(n=times,mean=0,sd=noiseSD)
  for (i in 1:(times-1)) {
    n[i+1] <- lambda*n[i] + noise[i]
    if(n[i] <= 0) {
      n[i] <- NA
      cat("Population extinction at time", i-1,"\n")
      tkbell() # sounds a bell sound when the pop. goes extinct
      break
    } # end of conditional loop
  } # end of for loop
  return(n)
} # end of RanWalk

qplot(x=1:100, y=RanWalk(), geom = "line")
qplot(x=1:100, y=RanWalk(noiseSD = 0), geom = "line")

# using double for loops
m <- matrix(round(runif(20), digits = 2), nrow = 5)
#loop over rows
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i
}
print(m)


# loop over columns
m <- matrix(round(runif(20), digits = 2), nrow = 5)
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j # vector operation for each column
}
print(m)


# double for loop for operating on each element
m <- matrix(round(runif(20), digits = 2), nrow = 5)
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    m[i,j] <- m[i,j] + i + j # sum of the row and columns are put before the decimal point
    
  } # close j loop(columns)
} # close i loops(rows)
print(m)

# writing functions for equations and sweeping over parameters
# S = cA^z power function for a species-area relationship A = area of island
# S = number of species c, z = constants

################################################################
# FUNCTION : SpeciesAreaCurve
# creates power function for A and S
# inputs A = vector of island areas
# c is the intercept constant 
# z is the slope constant
# output : a vector of species richness
###############################################################
SpeciesAreaCurve <- function(A = 1:5000,
                             c = 0.5,
                             z = 0.26){
  S <- c*(A^z)
  return(S)
}
SpeciesAreaCurve()
head(SpeciesAreaCurve())

###############################################################
# FUNCTION : SpeciesAreaPlot
# input : A = vector of areas
# c and z constants
# output = smoothed curve with parameter s
# shown in the graph
###############################################################
SpeciesAreaPlot <- function(A = 1:5000,
                            c = 0.5,
                            z = 0.26){
  plot(x=A,
       y=SpeciesAreaCurve(A,c,z),
       type="l",
       xlab="Island Area",
       ylab="S",
       ylim=c(0,2500))
  mtext(paste("c = ",c,"z = ",z), cex=0.7)
}
SpeciesAreaPlot()

# global variables
cPars <- c(100,150,175)
zPars <- c(0.10,0.16,0.26,0.3)
par(mfrow=c(3,4))

for (i in seq_along(cPars)) {
  for (j in seq_along(zPars)) {
    SpeciesAreaPlot(c=cPars[i], z=zPars[j])
  }
}
