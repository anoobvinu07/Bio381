# Additional details on for loops
# October 25th, 2018
# AP

install.packages("tcltk2")
library(tcltk2)

######################
# FUNCTION: RanWalk
# stockastic random walk
#input: times = number of time steps, 
#       n1 <- initial population size, 
#       lambda <- finite rate of increase
#       noiseSD standard deviation of rnorm(0)
#output: vector n with population sizes >0 until extinction, then NA
#------------------------------------------
library(tcltk2)
library(ggplot2)
RanWalk <- function(times=100, n1=50, lambda=1.0, noiseSD=10) {
  n <- rep(NA, times) #length of vector will be times variable
  n[1] <- n1#specify location of first value in vecto, and make it n1 -initialise first population size.
  noise <- rnorm(n=times, mean=0, sd=noiseSD)
  for(i in 1:(times-1)) {
    n[i+1] <- lambda*n[i] + noise[i]
    if(n[i] <= 0) {
      n[i] <- NA
      cat("Population extinction at time", i-1,"\n") #if you generate a negative numerb, this message will pop up
      #      tkbell() #computer will literally make a bell sounds!
      break } #exit entire looping structure
  }#end of for loop
  return(n)
} #end of RanWalk

#------------------------------------

myWalk <- RanWalk(noiseSD=10)
qplot(x=1:100, y=RanWalk(), geom="line")

# now start tinkering with default parameters in funciton

qplot(x=1:100, y=RanWalk(noiseSD=0), geom="line") #should give you a straight line 

qplot(x=1:100, y=RanWalk(lambda=1.1, noiseSD=0), geom="line")
qplot(x=1:100, y=RanWalk(lambda=0.97, noiseSD=0), geom="line")


#-------USE OF DOUBLE FOR LOOPS-------------

m <- matrix(round(runif(20), digits=2), nrow=5) #dont make square matrices 

# loop over rows
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i
}

print(m)

# loop over columns 

m <- matrix(round(runif(20), digits=2), nrow=5)
for(j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}
print(m)

# Create a double for loop for operating on each element:

m <- matrix(round(runif(20), digits=2), nrow=5)
for(i in 1:nrow(m)) {
  for(j in 1:ncol(m)) {
    m[i,j] <- m[i,j] + i + j #for particular row and column we are in, add together the row and colun value to the integer in that location. 
  } #close j loop (columns)
} #close i loop (rows)
print(m)
#what comes before deciman (runif) is sum of the column and row numbers

#-------writing functions for equations and sweeping over parameters-------

# S=CA^z power fucniton for a species-area relationship
# A = area of island
# S=number of species
#c,z = constants

#use a funciton to help us visualise this equations

############################################
# function: SpeciesAreaCurve -creates power funcitn for A and S
# inputs: A = vector of island area
#         c is the intercept constant
#         x is the slope constant
# output: vector of species richness values
#------------------------------------------
SpeciesAreaCurve <- function(A=1:5000, c=0.5, z=0.26) {
  S <- c*(A^z)
  return(S)
}
#------------------------------------------
head(SpeciesAreaCurve())

##########################################
#function: SpeciesAreaPlot
# input: A=vector of areas
#        c and z constants
# output: smoothed curve with parapeter S
#shown in the graph
#------------------------------
SpeciesAreaPlot <- function(A=1:5000, c=0.5, z=0.26) {
  plot(x=A,
       y=SpeciesAreaCurve(A, c, z), 
       type="l"
       ,
       xlab="Island Area", 
       ylab="S",
       ylim=c(0,2500))
  mtext(paste("c =", c, "z =",z),cex=0.7) #mtext is margin text. cex is character extension/size
}
#-------------------------------
SpeciesAreaPlot()

# Global variables -in combination, they will determine shape of curve
cPars <- c(100, 150,175)
zPars <- c(0.10,0.16,0.26,0.3) 
par(mfrow=c(3,4))

for (i in seq_along(cPars)) {
  for (j in seq_along(zPars)) {
    SpeciesAreaPlot(c=cPars[i],z=zPars[j])
  }
}

# Combined use of function and double for loop!! can go back to global variables and use different c and z values

#----- Expand grid-------

#expand grid for setting up a data frame with different parameter combinations
cPars
zPars
expand.grid(cPars,zPars) #makes a data frame with two columns for each variable, each row has the unique combinations that we can make form those two variables

##########################
#function: SA_Output "species area output" 
SA_output <- function(S=runif(10)) {
  sumStats <- list(SGain=max(S)-min(S), 
                   SCV=sd(S)/mean(S))
  return(sumStats)
}
##########################
SA_output()
#Build program body with a single loop through parameters in model frame

#Global variables:
Area <- 1:5000
cPars <- c(100, 150, 175)
zPars<- c(0.10, 0.16, 0.26, 0.30)

#set up model data frame
modelFrame <- expand.grid(c=cPars, z=zPars)
modelFrame$Gain <- NA #made a new column called gain filled with NAs
modelFrame$SCV <- NA
head(modelFrame)
# gain and SCV are spaces we can store/hold information as we go through simulation (for loop)

# Cycle through parameter combinations
for (i in 1:nrow(modelFrame)) {
  #Generate the S vector
  temp1 <- SpeciesAreaCurve(A=Area, 
                            c=modelFrame[i,1], 
                            z=modelFrame[i,2])
  #calculate output stats
  temp2 <- SA_output(temp1)
  #pass results to columns in modelFrame
  modelFrame[i,c(3,4)] <- temp2
}
print(modelFrame)

library(ggplot2)
Area <- 1:5
cPars <- c(100, 150, 175)
zPars<- c(0.10, 0.16, 0.26, 0.30)

modelFrame <- expand.grid(c=cPars, z=zPars, A=Area)
modelFrame$S <- NA
modelFrame

#now loop trough parameters and fill with SA

for (i in 1:length(cPars)){
  for (j in 1:length(zPars)){
    modelFrame[modelFrame$c==cPars[i] & modelFrame$z==zPars[j],"S"] 
    <- SpeciesAreaCurve(A=Area, c=cPars[i], z=zPars[j])
  } #close j loop
} #close i loop

head(modelFrame)

#graph facets with the long format

p1 <- ggplot(data=modelFrame)
p1 + geom_line(mapping=aes(x=A, y=S)) +
  facet_grid(c~z) 

p2 <- p1
p2 + geom_line(mapping=aes(x=A, y=S, group=z)) +
  facet_grid(.~c)

p3 <- p1
p3 + geom_line(mapping=aes(x=A, y=S, group=c)) +
  facet_grid(z~.)



