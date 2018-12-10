# caret
# December 06, 2018
# Brandon (BKC)

# caret = Classification and REgression Training
# wrapper for >300 model training techniques
# function for plotting and summarizing model performance

library(caret)
library(patchwork)
library(tidyverse)
set.seed(1235)

# load data and fix col names
load("wine.Rda")
colnames(wine) = make.names(colnames(wine))

# peek structure of the data
str(wine)
head(wine)

# view dist. of variables
wine_long = gather(wine, attr, val, -class)
ggplot(wine_long, aes(val)) + geom_density() +
  geom_histogram(aes(y..density..), bins=30, alpha=0.7) +
  facet_wrap(.~attr, scales="free")

# "recipe" for developing a model
# 1. prepare data (seperate + preprocessing)
# 2. train on training set
# 3. predict on test

# minimal working example

# partition data: prop. of classes is preserved
part = createDataPartition(wine$class, p=0.8, list=FALSE)
train = wine[part, ]
test = wine[-part, ]

# all shpould be roughly equal
prop.table(table(wine$class))
prop.table(table(train$class))
prop.table(table(test$class))

# train a moedel using the "rpart" method
rpart_model_wine = train(class~.,data=train, method="rpart")

# view model summary
rpart_model_wine

# make predictions
rpart_wine_predict = predict(rpart_model_wine, newdata=test)
head(rpart_wine_predict)
head(test$class)

# build a better model with nnet package

# preprocessing
preproc_values = preProcess(train, method=c("center","scale"))
train = predict(preproc_values, train)
test = predict(preproc_values, test)
head(train)

# specify parameters  and resampling 
modelLookup("nnet")
param_grid = expand.grid(.decay=c(0.8,0.2,0.05), size=c(1,3,5))
resample_type = trainControl(method="LGOCV")

# pass the train function
nnet_model_wine = train(class~.,data=train, method="nnet",
                        tuneGrid = param_grid,
                        trControl = resample_type,
                        #model specific params
                        maxit = 200)

# visualize training process
nnet_model_wine
p = ggplot(nnet_model_wine) | ggplot(nnet_model_wine, metric="Kappa")
p / ggplot(nnet_model_wine, plotType="level")

# resample performance for final model
resampleHist(nnet_model_wine)

# get predictions and summarize predictive power
nnet_model_wine = predict(nnet_model_wine, newdata=test)
confusionMatrix(nnet_model_wine, test$class)

# variable importance: which vars matter for predictions?
imp = varImp(nnet_model_wine)
imp

imp_df = data.frame("attr" = rownames(imp[[1]]),
                    "imp" = imp[[1]][,1])
ggplot(imp_df, aes(y=imp, x=attr)) + geom_col() + coord_flip()

ggplot(wine_long, aes(x=class, y=val, col=class)) + geom_boxplot() +
  facet_wrap(.~attr, scale="free")


