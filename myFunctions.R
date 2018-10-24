### Collection of functions to source
### 16 October 2018
### AP

########################
# FUNCTION:Get Data
# INPUTS:.csv data file
# OUTPUTS:data frame
#-----------------------
getData <- function(fileName=NULL){
  if(is.null(fileName)) {
    dataFrame <- data.frame(ID=101:110,
                            varA=runif(10),
                            varB=runif(10))
  } else {
    dataFrame <- read.table(file=fileName,
                            header=TRUE,
                            sep=",",
                            stringsAsFactors = FALSE)
  }
  
  return(dataFrame)
}
#-----------------------



########################
# FUNCTION:fitRegressionModel
# fit an ols regression model
# INPUTS: x and y vectors of numeric. must be same length
# OUTPUTS:entre summary from lm
#-----------------------
fitRegressionModel <- function(xVar=runif(10),yVar=runif(10)) {
    dataFrame <- data.frame(xVar, yVar)
  regModel <- lm(yVar~xVar, data=dataFrame)
  
  
  return(summary(regModel))
}

#-----------------------




########################
# FUNCTION:summarizeOutput
# INPUTS:
# OUTPUTS:
#-----------------------
summarizeOutput <- function(z=NULL){
  if(is.null(z)) {
    z <- summary(lm(runif(10)~runif(10)))
  }
 
  
  return(z$residuals)
}
#-----------------------




########################
# FUNCTION:graphResults
# INPUTS:x and y numeric vectors
# OUTPUTS:creates graph (side effects)
#-----------------------
graphResults <- function(xVar=runif(10), yVar=runif(10)){
  library(ggplot2)
  dataFrame <- data.frame(xVar,yVar)
  p1 <- qplot(data=dataFrame,
              x=xVar,
              y=yVar,
              geom = c("smooth","point"))
  print(p1)
  
}
#-----------------------

# getData()
# fitRegressionModel()
# summarizeOutput()
# graphResults()