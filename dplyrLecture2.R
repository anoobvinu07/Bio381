#### write.table() : useful for working outside R with a .csv file
library("dplyr")
data(starwars)

starwars1 <- select(starwars, name:species)
glimpse(starwars1)
write.table(starwars1, file ="StarwarsInfo.csv", row.names=FALSE, sep =",") #creating a .csv file
### option: write.csv()

### read.table(): useful when you have metadata
data <- read.table(file = "FileName.csv", row.names = F, header = T, sep = ",")
starwarsData <- read.table("StarwarsInfo.csv", header = T, sep = ',',stringsAsFactors = F)
head(starwarsData)
class(starwarsData)
data <- as_tibble(starwarsData)
glimpse(data)

### saveRDS(): useful when working in R; saves a single R objects as a file
saveRDS(starwars1, file = "StarwarsTibble")

### readRDS(): restores R objects
sw <- readRDS("StarwarsTibble")
class(sw)



######## Further into dplyr
glimpse(sw)


### count our NAs (not in dplyr)
sum(!is.na(sw)) # not sure this was the code here

###count our nonmissing data
sum(!is.na(sw))

swSp <- sw %>%
  group_by(species) %>%
  arrange(desc(mass))
swSp

swSp %>%
  summarize(avgMass = mean(mass, na.rm = T),
            avgHeight = mean(height, na.rm = T), n=n()) ##n() gives count info(sample size)

### filter out low sample size
swSp %>%
  summarize(avgMass = mean(mass, na.rm = T),
            avgHeight = mean(height, na.rm = T), n=n()) %>%
  filter(n>=2) %>%
  arrange(desc(n))


### using the count helper
swSp %>%
  count(eye_color)


swSp %>%
  count(wt = height) # gives the sum using "weight" (wt)


### Useful summary functions
starwarsSummary <- swSp %>%
  summarize(avgHeight=mean(height, na.rm = T),
            medHeight = median(height,na.rm = T), 
            sdHeight = sd(height, na.rm = T),
            IQRHeight = IQR(height,na.rm=T),
            min_height = min(height, na.rm = T),
            first_height = first(height),
            nth = nth(height,4), 
            n_eyecolors = n_distinct(eye_color), 
            n = n()) %>%
  filter(n>=2) %>%
  arrange(desc(n))

print(starwarsSummary)

### group_by() use multiple variables/ungroup
sw2 <- sw[complete.cases(sw),] # only include rows that dont have NAs
glimpse(sw2)

sw2groups <- group_by(sw2, species,hair_color)
summarize(sw2groups, n=n())

sw3groups <- group_by(sw2,species,hair_color)
summarize(sw3groups, n=n())


#  ungroup
sw3groups %>%
  ungroup() %>%
  summarize(n=n())

# ungroup(sw3groups)

## Grouping with mutate()
###Ex: standardize within groups
sw3 <- sw2 %>%
  group_by(species) %>%
  mutate(prop_height = height/sum(height)) %>%
  select(species, height, prop_height)

print(sw3)

sw3 %>%
  arrange(species) #alphabetical order

library(sp)
sp::coordinates(data) ### for using specific functions in packages that may be masked