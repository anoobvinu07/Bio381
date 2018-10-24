# Control structures for non-linear execution of code
# OCtober 18, 2018
# taught by NJG
#ctrl+l cleans consol (doesnt change anything in memory)

# simple inequalities
5>3
5<3
5<=5
5==3
5!=3 #! means NOT

# use & for AND (make evaluations for things on both sides)
5>3&1!=2
1=2&1!=2 #in order for & to return true, both sides must be true

# | for OR 
1==2|1!=2

# this works with vectors
1:5>3

a <- 1:10
b <- 10:1
a>4
b>4
a>4&b>4

#use "long from" of & and | to evaluate only the first element
a>4 && b>4

# also || for long form for OR
a<4|b>4
a<4||b>4
a[1]<4|b[1]>4 #identical statment to the one before

#xor for exclusive OR testing "exclusive or"
#work for (TRUE FLASE) but not (TRUE TRUE)
a <- c(0,0,1)
b <- c(0,1,1)
a|b
xor(a,b)

#-----------------

# Set operators

#boolean algebra on sets of atomic vectors (logical, numeric, character strings)

"three" < "five" #these are character strings, not numbers. R will alphabetise character strings
FALSE<TRUE #r conversts boulean operators into 1 or 0

a <- 1:7
b <- 5:10

# union function to get all elements
union(a,b) #gives you elements that are common between two vectors adn makes on vector

# intersect to common elements
intersect(a,b) #fives number found in both

# setdiff to get distinct elemnts in a or b (depending on which you put first)
setdiff(a,b)
setdiff(b,a)

# setequal to check for identical elements
setequal(a,b)

# equality comares elemtn by element
z <- matrix(1:12, nrow=4, byrow=TRUE)
z
z1 <- matrix(1:12, nrow=4, byrow=FALSE) #fill by column is default setting in R
z1
z==z1
#use identical for entire structure comman
identical(z,z1) #FALSE because elements are not same
z1 <-z
identical(z,z1) #now we have made z1 and z the same, so they are identical

# use %in% function to check for a subset
d <- 12
d %in% union(a,b) # "is d in the union of a and b? false, because union of a and b dont contain 12
is.element(d,union(a,b)) # same thing out 

d <- c(10,12)
d %in% union(a,b)
d %in% a


#----------WANT TO USE THESE COMMANDS TO CONTROL FLOW OF OUR CODE. -------------

# Condition if statements

z <- signif(runif(1),digits=2)
print(z)
z>0.5

# naked if statement
if(z>0.5) cat(z, "is a bigger than average number", "\n") #naked if statment -no else after it


# if with else
if (z>0.8) cat(z,"is a large number","\n") else if (z<0.2) cat(z,"is a small number","\n") else {cat(z, "is a number of typical size","\n") cat("z^2=",z^2,"\n")} 

#be careful with if statemnts, whic hrequire a sincla logical value

z <- 1:10

#this deosnt do anything
if(z>7) print(z)

#also not so good:
if(z<7)print(z)

#use subsetting!
print(z[z<7])

# ----ifelse to fill vectors----

#distribution of eggs laid lambda = 10.2, p(parasitism) = 35%

tester <- runif(1000) #start with random uniform elements
eggs <- ifelse(tester>0.35, rpois(n=1000,lambda=10.2),0) #yes condition is give poisson distribution. no condition is a zero, meaning clutch was parasatised and offspring killed off
hist(eggs) #losses (offspring death) are inflated zero category.

pVals <- rbeta(n = 1000,
               shape <- 0.5, shape2 <- 0.5)
z <- ifelse(pVals <= 0.025,
            "lowerTail", "nonSig")
z[pVals >= 0.975] <- "upperTail"
head(z)
table(z)

# alternative coding
z1 <- rep("nonSig",1000)
z1[pVals <= 0.025] <- "lowerTail"
z1[pVals <= 0.0975] <- "upperTail"
library(ggplot2)
qplot(x=pVals, fill=z1) # qplot is a faster version of ggplot and does not require dataframe (like ggplot) to work with and can work with vectors
