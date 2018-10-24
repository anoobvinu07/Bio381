### Example of structured programmng approach
### 16 October 2018
### AP
#-------------------------------------------------------------------------
#Preliminaries
library(ggplot2)
source("myFunctions.R")  # referencing to the place where the functions are stored
# set.seed(100)
#-------------------------------------------------------------------------
# Global variables
antFile <- "antcountydata.csv" #ant data set
xCol <- 7 # latitude center of each country
yCol <- 5 # number of ant species
#-------------------------------------------------------------------------

# Program body

temp1 <- getData(fileName = antFile)

x <- temp1[,xCol] # extract predictor variable
y <- temp1[,yCol] # extract response variable

temp2 <- fitRegressionModel(xVar = x, yVar = y)
# fit regression model
temp3 <- summarizeOutput(temp2)

graphResults(xVar = x, yVar = y)

print(temp3) # show residuals
print(temp2) # show model

## Summary
getData()
fitRegressionModel()
summarizeOutput()
graphResults()
