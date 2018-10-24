### For loops in R
### October 23, 2018
### AP

myDogs <- c("chow", "akita", "malamute", "husky", "samoyed")


# not recommended for looping
for(i in myDogs){
  print(i)
}

#better to create a sequence vector
for(i in 1:length(myDogs)){ #cat stands for concatenate
  cat("i =", i, "myDogs [i] =", myDogs[i], "\n")
}

# problem with empty vector
myBadDogs <- NULL
for(i in 1:length(myBadDogs)){ #cat stands for concatenate
  cat("i =", i, "myBadDogs [i] =", myBadDogs[i], "\n")
}

# use seq_along
for(i in seq_along(myDogs)){ #cat stands for concatenate
  cat("i =", i, "myDogs [i] =", myDogs[i], "\n")
}

myBadDogs <- NULL
for(i in seq_along(myBadDogs)){ #cat stands for concatenate
  cat("i =", i, "myBadDogs [i] =", myBadDogs[i], "\n")
}

# use external variable for vector length
zz <- 5
for(i in seq_len(zz)){ #cat stands for concatenate
  cat("i =", i, "myDogs [i] =", myDogs[i], "\n")
}

for(i in 1:zz){ #cat stands for concatenate
  cat("i =", i, "myDogs [i] =", myDogs[i], "\n")
}

#tip #1 don't do unnecessary things in the for loop!
for(i in 1:length(myDogs)){ 
  myDogs[1] <- toupper(myDogs[i])
  cat("i =", i, "myDogs [i] =", myDogs[i], "\n")
}

# do things outside of the loop
myDogs <- c("chow", "akita", "malamute", "husky", "samoyed")
myDogs <- toupper(myDogs)
for(i in 1:length(myDogs)){ 
  myDogs[1] <- toupper(myDogs[i])
  cat("i =", i, "myDogs [i] =", myDogs[i], "\n")
}

# tip #2 do not change object dimensions in a loop (c, list, rind, cbind)

myDat <- runif(1)
for(i in 2:20) {
  temp <- runif(1)
  myDat <- c(myDat, temp)
  cat("loop number =",i,"vector element =", myDat[i],"\n")
}
head(myDat)

# tip #3 Do not write a loop if you can vectorize the operation!
myDat <- 1:10
for(i in seq_along(myDat)){
  myDat <- myDat[i] + myDat[i]^2
  cat("loop number =",i,"vector element =", myDat[i],"\n")
}

z <- 1:10
z <- z + z^2

# tip #4 be alert to distinction between counter variable i and the vector element z[i]

z <- c(10,2,4)
for(i in seq_along(z)) {
  cat("i =",i,"z[i]",z[i],"\n")
}

# tip #5 use 'next' to skip certain elements in the loop

z <- 1:20
#what if we want to work with only the odd numbered elements?
for(i in seq_along(z)){
  if(i %% 2==0) next
  print(i)
}

# alternative that may be faster
z <- 1:20
zsub <- z[z %% 2 != 0]
length(zsub)
for(i in seq_along(zsub)) {
  cat("i =", 1, "zsub[i] = ", zsub[i],"\n")
}
