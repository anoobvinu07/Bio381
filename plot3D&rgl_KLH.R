# Creating 3D graphics using plot3D and rgl
# November 28 2018
# KLH

library(plot3D)

data(airquality)
head(airquality)

x <- airquality$Temp
y <- airquality$Wind
z <- airquality$Day

# basic scater plot in plot3D
scatter3D(x,y,z)

# modify the appearance of the box
scatter3D(x,y,z, bty = "n")

# change the shape and size of the points
scatter3D(x,y,z, bty="b2", pch=15, cex=0.5)

# manually specify arguments
scatter3D(x,y,z, bty = "u",colkey = TRUE, col = "steelblue", col.panel = "grey", col.grid = "black")

# color gradient scale
scatter3D(x,y,z, bty = "b2", col = ramp.col(c("red","purple","blue")))

# ggplot like colors
scatter3D(x,y,z, bty="b2", col=gg2.col(100))

# change the angle of the graph
scatter3D(x,y,z, bty = "b2", theta = 40, phi = 40)

# adding axis labels and tickmarks
scatter3D(x,y,z, bty = "b2", main="airquality data",
          xlab="temp",
          ylab="wind",
          zlab="day")

# ticktypes
scatter3D(x,y,z, bty="b2", ticktype="detailed",nticks=10)

# adding text to existing plot
scatter3D(x,y,z, labels=rownames(airquality), add=TRUE, cex=0.5)

# adding confidence interval
myCI <- list(x=matrix(nrow=length(z), data=rep(0.1, 2*length(z))))
head(myCI$x)
scatter3D(x,y,z, bty="b2", pch=20, col=gg2.col(100), CI = myCI)

# regression plane
fit <- lm(z~x+y)
grid.lines=25
x.pred <- seq(min(x), max(x), length.out = grid.lines)
y.pred <- seq(min(y), max(y), length.out = grid.lines)
xy <- expand.grid(x=x.pred, y=y.pred)
z.pred <- matrix(predict(fit,newdata=xy),nrow=grid.lines, ncol=grid.lines)

firpoints <- predict(fit)

scatter3D(x,y,z, bty="b2", pch=20, cex=0.8, theta=10,phi =10, col=gg2.col(100),
          surf=list(x=x.pred, y=y.pred, z=z.pred, facets))
