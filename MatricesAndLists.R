# basic operations on matrices and lists
# 18 September 2018
# AP

m <- matrix(data = 1:12,
            nrow = 4,
            ncol = 3)
print(m)
dim(m)
m <- matrix(data = 1:12,
            nrow = 4,
            byrow = TRUE)
print(m)


# change dimensions
dim(m) <- c(6,2)
print(m)
dim <- c(4,3)
print(m)
nrow(m)
ncol(m)
length(m)


# add row and column names
rownames(m)
rownames(m) <- c("a","b","c","d")
print(m)
colnames <- LETTERS[1:ncol(m)]
print(m)
print(m[2,3])
print(m[1:2,2:3])
print(m[,2:3])
print(m[1:2,])
print(m[,,])
rownames(m) <- paste("Species", LETTERS[1:nrow(m)],sep="")
colnames(m) <- paste("Sites",1:ncol(m), sep = "")
print(m)
m["SpeciesD", "Sites2"]

dimnames(m) <- list(paste("Site", 1:nrow(m),sep=""),
                    paste("Species", letters[1:ncol(m)],sep=""))

#t for transpose
print(t(m))

# adding rows or columns to matrix
m2 <- t(m)
m2 <- rbind(m2,c(20,20,30))  # add row to an existing matrix
print(m2)
rownames(m2)
rownames(m2)[4] <- "myFix"
print(m2)
m2["myFix", "Site1"]
m2[c("myFix", "Speciesb"),c("Site1","Site4")]



# Introducing Lists

myList <- list(1:10, 
               matrix(1:8, nrow = 4, byrow = TRUE),
               letters[1:3],
               pi)
myList[4]
myList[4] - 3 # can't substract a number from a list
myList[[4]] - 3 #pulls out the value


# list of 10 elements, a train with 10 cars
# x[5] fifth car in the train
# x[[5]] contents of the fifth car
# x[c(4,5,6)] a new train with 3 cars

myList[[2]] # full matrix
myList[[2]][3,2]
print(myList)

# naming list items

myList2 <- list(Tester = FALSE,
                littleM = matrix(1:9,nrow=3))
myList2$littleM #prints the entire matrix
myList2$littleM[1,]

#unlist is very helpful for lists!
unRolled <- unlist(myList2)
print(unRolled)

# use unlist for accessing model output
library(ggplot2)
yVar <- runif(10)
xVar <- runif(10)
myModel <- lm(yVar~xVar)
qplot(x=xVar,y=yVar)
print(myModel)
print(summary(myModel)) #summary gives a more detailed look on the model
str(summary(myModel))
summary(myModel)$coefficients
summary(myModel)$coefficients[2,4]


# find what you want by unlisting the model summary

u <- unlist(summary(myModel))
u
mySlope <- u$coefficients2
myPValue <- u$coefficients8

mySlope
myPValue

# Data frame
# - a list of atomic vectors
# - all vectors(=columns) same length

# build a data frame from scratch

varA <- 1:12
varB <- rep(c("Con","LowN","HighN"),
            each=4)
varC <- runif(12)
dFrame <- data.frame(varA,varB,varC,stringsAsFactors = FALSE)
str(dFrame)
head(dFrame)


# add a row with rbind

newData <- list(varA =13, varB="HighN",varC=0.668)
print(newData)
str(newData)
dFrame <- rbind(dFrame,newData)
tail(dFrame)

# add a column to the data frame
newVar <- runif(13)
dFrame <- cbind(dFrame,newVar)
head(dFrame)

# similarities and differences of data frames and matrices

# build a data frame and matrix with same structure
zMat <- matrix(data=1:30,ncol=3,byrow = TRUE)
zDframe <- as.data.frame(zMat)
str(zMat)
str(zDframe)

head(zDframe)
head(zMat)

zMat[3,3]
zDframe[3,3]

# column referencing is also the same
zMat[,2]
zDframe[,2]
zDframe$V2

# referencing single items
zMat[2]
zMat
zDframe[2]
zDframe["V2"]
zDframe$V2

# subscripting and dealing with missing data
set.seed(99)
z <- 1:10 # simple sequence
z
z <- sample(z)
z
z < 4 #logical vector
z[z<4] #subset
which(z<4) #get subscripts
z[which(z<4)]


zD <- c(z,NA,NA)
zD

zD[zD<4]
zD[which(zD<4)]


# use complete cases to eliminate NA values

print(zD)
complete.cases(zD)
zD[complete.cases(zD)]

# use this to find missing value slots

which(!complete.cases(zD))

# now apply this to a matrix

m <- matrix(1:20,nrow=5)
m[1,1] <- NA
m[5,4] <- NA
m

m[complete.cases(m),]

m[complete.cases(m[,c(1,2)]),]
