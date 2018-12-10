# sunburstR
#November 29 2018
# Emily EAS

# Sunburst is a great way to summarize and view observational data not based on numbers but letters and words

# It tracks and graphs patterns in an interactive graph

library(ggplot2)
library(sunburstR)
library(magrittr)
library(dplyr)
# First import your data from a .csv files or a data frame
data <- read.csv('sunburstData.csv', 'header' = TRUE, 'colClasses' = c('integer','character'))
head(data)
typeof(data)

action <- data %>%
  group_by(Time_tag) %>%
  filter(row_number()==1) %>%
  ungroup() %>%
  summarize(Response=paste(c(Response), collapse="-"))
#results in length 1 character vector

sequences <- action %>%
  ungroup() %>%
  group_by(Response) %>%
  summarize(count=n())

sequence$depth <- unlist(lapply(strsplit(sequences$Response,"-"), length))

# lapply returns a list of the same length of x, so we worked with our times before, now we are working with our reponses
#str split splits the elements of our character vector into substrings

sb <- sequences %>%
  arranege(desc(depth), Response) %>%
  sunburst(count=TRUE)
print(sb)

# the 8 in the center means there are 8 different combinations of observations in our data

# for example, in the upper right of the sunburst with the 