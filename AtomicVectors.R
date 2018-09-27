# Basic properties of atomic vectors in R
# 13 September 2018
# AP

# use assignment operator
x <- 5 #preferred
x #prints out the output
print(x) #best way to print out the output
typeof(x)
str(x)
is.numeric(x)
is.character(x)

# building one dimensional atomic vectors
# the combine functions
z <- c(3.2,5,5,6)
str(z)

# c command always "flattens"
z <- c(c(3,4), c(5,6))
print(z)


# vectors of character strings
z <- c("perch", "bass", "red snapper", "trout")
print(z)

# use single or double with embedded quotes
z <- c("this is 'one' strong", 'and another')
print(z)


# logical (True/False) variables

z <- c(TRUE, TRUE, FALSE)

# variable names
z <- 3 #short, but not informative
plant_height <- 3 #too long
plant.height <- 3 #period used in other ways
plantHeight <-3 #camelCase naming

# properties of vectors
# 1) type
z <- c(1.1,2,3,4)
typeof(z)
is.character(z)
is.integer(z)


# 2) length of the atomic vector
length(z)
length(y)


# 3) names
z <- runif(5)
# names not initially assigned
names(z)
names(z) <- c("chow","pug","beagle",
              "greyhound","akita")

# or add names when available is created
z2 <- c(gold=3.3, silver=10,lead=2)
print(z2)
names(z2) <- NULL
names(z2) <- c("red", "green")
print(z2)

# names do not have to be distinct
names(z2) <- c("red","red")
print(z2)

# special data types
# NA values for missing data
z <- c(3.2,3.2,NA)
typeof(z)
typeof(z[3])
z1 <- NA
typeof(z1)

#NA values carry through for entire vector
is.na(z)
!is.na(z)
mean(z) #cannot make calculations
mean(!is.na(z)) 

# NaN - Inf and Inf from numeric division
z <- 0/0
typeof(z)
print(z)
z <- 1/0
print(z) #Inf stands for infinity
z <- -1/0
print(z)



# three features of atomic variables
# 1) coercion
a <- c(2,2.0)
typeof(a)
b <- c("purple","green")
d <- c(a,b)
typeof(d)
print(d)
# coercion order:
# logical -> integers -> doubles -> character

# Conversions very useful in combination with logical varables
a <- runif(10)
print(a)
a > 0.5
aboolean <- a > 0.5 # vector of logicals
sum(a)
sum(aboolean)
sum(a>0.5) # adding and coercing a logical
mean(a>0.5) #gives proportion of TRUES

# tail values for a normal distribution
mean(rnorm(1000)>2)
mean(rnorm(1000)==2)
mean(rnorm(1000)!=2)


# Vectorization
z <- c(10,20,30)
z + 1
y <- c(1,2,3)
z + y
z^2
myResult <- z^2

# Recycling
z <- c(10,20,30)
y <- c(1,2)
z + y

# Creation of vectors
# creating an empty vector and expanding it (don't do this!)

z <- vector(mode="numeric", length=0)
print(z)
z <- c(z, 5)
print(z)

# better to pre-allocate vector space
z <- rep(0,100)
str(z)
head(z)
tail(z)

# start with NAs
z <- rep(NA,100)
head(z)
typeof(z)

z[2] <- "Adams"
head(z)
typeof(z)

# efficiently add names to an atomic vector

myVector <- runif(100)
head(myVector)
myNames <- paste("Species", seq(1:length(myVector)),sep="")
head(myNames)
tail(myNames)
names(myVector)
names(myVector) <- myNames
head(myVector)

# use rep function to repeat elements and vector

rep(0.5,6)
rep(x = 0.5, times = 6)
rep(times = 6, x = 0.5)
myVec <- c(2,4,1)
rep(x = myVec, times = 2)
rep(x = myVec, each = 2) #each and times gives seperate results
rep(x = myVec, times = myVec)
rep(x = myVec, each = myVec)


# use seq() to create regular sequences
seq(from = 2, to = 4)
2:4
seq(from = 2, to = 4, by = 0.5)
seq(from = 2, to = 4, length = 7)
1:length(myVec)
seq_along(myVec)
seq_len(5)

# quickly creating random numbers
runif(5) # 5 [0,1] unifrom
runif(n = 3,min = 100, max = 100)

rnorm(6) #mean0, sd1
rnorm(n = 3, mean = 100, sd = 10)

# sample from an atomic vector

longVec <- LETTERS[1:10]
print(longVec)
sample(longVec) #reordering
vecTreat <- c(rep("Control", 5),rep("Treatment",5))
vecTreat
sample(vecTreat)
sample(x = longVec, size = 3)
sample(x = longVec, size = 16) # throws an error if more than whats at hand is asked for
sample(x = longVec, size = 16, replace = TRUE)
MyWeights <- c(rep(20,5),rep(100,5))
MyWeights
sample(x = longVec, replace = TRUE, prob = MyWeights)
sample(x = longVec, replace = FALSE, prob = MyWeights)

