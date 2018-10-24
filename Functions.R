### Functions in R
### October 11 2018
### AP

sum(3,2) # 'prefix' functions
3 + 2 # an operator function, but actually an 'infix' function
`+`(3,2)
`<-`(yy,3)
yy

sd # prints the function contents
sum # primitive functions
sd(c(3,2))
sd() # uses default parameters
sum()

########################
# FUNCTION:HardyWeinberg
# INPUTS:an allele frequency p(0,1)
# OUTPUTS:p and the frequencies of 3 genotypes AA, AB, BB
#-----------------------
HardyWeinberg <- function(p=runif(1)) {
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p,
                     AA=fAA,
                     AB=fAB,
                     BB=fBB),digits=3)





return(vecOut)
}
#-----------------------

HardyWeinberg
HardyWeinberg(p=0.02)
HardyWeinberg()

# Multiple return statements for different return values

########################
# FUNCTION:HardyWeinberg
# INPUTS:an allele frequency p(0,1)
# OUTPUTS:p and the frequencies of 3 genotypes AA, AB, BB
#-----------------------
HardyWeinberg2 <- function(p=runif(1)) {
  if(p > 1.0 | p < 0.0){
    return("Function failure: p out of bounds")
  }
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p,
                     AA=fAA,
                     AB=fAB,
                     BB=fBB),digits=3)
  
  
  
  
  
  return(vecOut)
}
#-----------------------

HardyWeinberg2(p=0.5)
z <- HardyWeinberg2(p=1.1)
z

# use stop function for error trapping

HardyWeinberg3 <- function(p=runif(1)) {
  if(p > 1.0 | p < 0.0){
    stop("Function failure: p out of bounds")
  }
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p,
                     AA=fAA,
                     AB=fAB,
                     BB=fBB),digits=3)
  
  
  
  
  
  return(vecOut)
}
#-----------------------

HardyWeinberg3()
HardyWeinberg3(p=1.1)

# scoping in functions
# global variables
# local variables

myFunc <- function(a=3,b=4){
  z <- a + b
  return(z)
}
myFunc()

myFuncBad <- function(a=3){
   z <- a + b
   return(z)
}
myFuncBad() # error because of bad coding

b <- 100 # global variable # b which is not part of myFuncBad is added as a global variable

myFuncBad()

---------------------------------------------------------------------------
  

########################
# FUNCTION:fitlinear
# INPUTS:numeric vector of predictor(x) and response(y)
# OUTPUTS:slope and p-value
#-----------------------
fitlinear <- function(x=runif(20), y=runif(20)){
  myMod <- lm(y~x) # fit of the linear model
  myOut <- c(slope=summary(myMod)$coefficients[2,1],
             pValue=summary(myMod)$coefficients[2,4])
  plot(x=x,y=y)
  return(myOut)
}
#-----------------------
fitlinear()



########################
# FUNCTION:fitlinear2
# INPUTS:numeric vector of predictor(x) and response(y)
# OUTPUTS:slope and p-value
#-----------------------
fitlinear2 <- function(p=NULL){
  if(is.null(p)) {
    p <- list(x=runif(20), y=runif(20))
    } #NULL can only be addressed with is.null() 
  myMod <- lm(p$y~p$x) # extracting y and x vaues from list p
  myOut <- c(slope=summary(myMod)$coefficients[2,1],
             pValue=summary(myMod)$coefficients[2,4])
  plot(x=p$x,y=p$y)
  return(myOut)
}
#-----------------------
fitlinear2()
