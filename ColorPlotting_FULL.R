# demos of color palettes 
#11/13/18
#-------------------------------------------------------------------------------

library(ggplot2)
library(ggthemes)
library(patchwork)
library(wesanderson)

# working with basic colors and greyscale 

d <- mpg 
p1 <- ggplot(d,aes(x=fl,y=hwy,group=fl))
p1 + geom_boxplot()

p1 + geom_boxplot(fill="red") # using r's named colors hurts the eyes sometimes

#make custom palette from r colors
myColors <- c("red", "green", "pink", "blue", "orange")
p1 + geom_boxplot(fill=myColors)

# function grey (gray) takes a number between 0 and 1 and returns the number you want for a greyscale 

p1 + geom_boxplot(fill= gray(seq(from=0.1,to=0.9, length = 5)))


# histograms with alpha transparency 

x1 <- rnorm(n=100, mean=0)
x2 <- rnorm(n=100,mean = 3)
dFrame <- data.frame(v1=c(x1,x2))
lab <- rep(c("Control", "Treatment"), each = 100)
dFrame <- cbind(dFrame,lab)
h1 <- ggplot(dFrame,aes(x=v1,fill=lab))
h1 + geom_histogram(position = "identity", alpha=0.5, color="black")
# notice overlapping bars make a third color (maybe a differnt alpha would make this more clear)

# don't forget that nick has a ling list of color palettes on the course webpage 

#add a nice wes anderson color palette
p1 + geom_boxplot(fill=wes_palettes[["Royal2"]])

p1 + geom_boxplot(fill=c(grey(0.5), canva_palettes[[1]]))

# use scale fill manual

p2 <- ggplot(d,aes(x=fl,y=hwy,fill=fl)) +
  geom_boxplot() +
  scale_fill_manual(values=wes_palettes[["Darjeeling1"]])
print(p2)


# colorbrewer2.org has a ton of color palettes that are good for mapping and they are built into ggplot through scale_fill_brewer()

p2 + geom_boxplot() +
  scale_fill_brewer(palette = "Blues")

# using continuous scales 

p3 <- ggplot(d,aes(x=displ,y=hwy,color=cty)) +
  geom_point()
print(p3) # notice ggplot default is a blue scale 

# use a scale color gradient to change low and high colors 

p3 + scale_color_gradient(low="red", high="blue")

#use scale_color_gradient2() for 3 color gradient 

z <- mean(d$cty)
p3 +
scale_colour_gradient2(midpoint = z, low="red", mid="seagreen", high="cyan", space="Lab")  # it's hard to make your own gradient, so that's why there are built in gradients 

# use color gradientn() for multicolored changes 

p3 + scale_color_gradientn(colors=rainbow(5))


# make a heatmap with viridis color scale 

xVar <- 1:30
yVar <- 1:5
myData <- expand.grid(xVar=xVar, yVar=yVar) # now we have a grid thats 30x5

zVar <- myData$xVar + myData$xVar + myData$yVar + 2*rnorm(n=150)
myData <- cbind(myData, zVar)

p4 <- ggplot(myData,aes(x=xVar,y=yVar,fill=zVar))
p4 + geom_tile() # default color scale kinda sucks

p4 + geom_tile() +
  scale_fill_gradient2(midpoint = 19, low= "brown", mid=grey(0.8), high = "darkblue")

# now with viridis 

p4 + geom_tile() + scale_fill_viridis_c() # way better color scale 

# other virids options = cividis, magma, inferno, plasma


p4 + geom_tile() + scale_fill_viridis_c(option = "magma") # looks really cool and makes more sense 




