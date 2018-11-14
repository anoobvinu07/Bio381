# demos of color palettes in R
# November 13 2018
# AP

library(ggplot2)
library(ggthemes)
library(patchwork)
library(wesanderson)

# working with basic colors and grey

d <- mpg
p1 <- ggplot(d,aes(x=fl, y=hwy, group=fl))
p1 + geom_boxplot() 

p1 + geom_boxplot(fill="red")
myColors <- c("red", "green", "pink", "blue", "orange")
p1 + geom_boxplot(fill = myColors)

# use grey function
p1 + geom_boxplot(fill=gray(seq(from=0.1, to =0.9, length=5)))

# histograms with alpha transparency
x1 <- rnorm(n=100,mean=0)
x2 <- rnorm(n=100,mean=3)
dFrame <- data.frame(v1=c(x1,x2))
lab <- rep(c("Control", "Treatment"), each=100)
dFrame <- cbind(dFrame, lab)

h1 <- ggplot(dFrame, aes(x=v1, fill=lab))
h1 + geom_histogram(position = "identity", alpha=0.5, color="black")

p1 + geom_boxplot(fill=wes_palettes[["Royal2"]])
p1 + geom_boxplot(fill=wes_palettes[["Darjeeling2"]])

p1 + geom_boxplot(fill=c(grey(0.5),canva_palettes[[1]])) 
