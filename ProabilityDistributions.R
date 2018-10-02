### Probability distributitions
### October 02, 2018
### AP


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
