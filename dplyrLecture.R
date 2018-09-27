### manipulating data using dplyr
### September 25,2018
### AP

### Start with a built in dataset
install.packages("dplyr") # only required if the package is not installed. Check before executng this command

library(dplyr)
data(starwars)
class(starwars)

str(starwars)

glimpse(starwars)  # better than str() in this case
head(starwars)  # more informative

##Clean up our data
# complete.cases are part of the base R
starwarsClean <- starwars[complete.cases(starwars[1:10]),]
head(starwarsClean)


# Check for NAs (base R)
is.na(starwarsClean[1,1])
anyNA(starwarsClean)
anyNA(starwars[1:10,])

##### filter() : pick/subset observations based on their values
### uses > >= <= != ==
### logical operators & | !

filter(starwarsClean, gender == "male", height < 180)
filter(starwarsClean, eye_color %in% c("blue","brown"))
## excludes NAs (unless you ask), but other rows can include NAs
filter(starwarsClean, gender == "male", height <180, height >100) # you can add multiple conditions

### arrange() : reorders rows
arrange(starwarsClean, height)
arrange(starwarsClean, desc(height)) # desc will list height in the descending order

#break ties by putting more column names
arrange(starwarsClean, height, desc(mass))
starswars1 <- arrange(starwars, height)
tail(starswars1) # all the NAs will be arranged at the bottom


## select() : choose variables by their name
# arrange() works with rows and select() works with columns
glimpse(starwarsClean)
starwarsClean[1:10,] #base r subsetting
select(starwarsClean, name:species)
select(starwarsClean, -(films:starships)) # - sign removes it from the selectiion
select(starwarsClean, -(c(name,skin_color)))

###moving columns with select()
select(starwarsClean, name, gender, species, everything()) #helps in reordering the data
select(starwarsClean, contains("color")) #helper functions!
#other helper functions: ends_with, start_with, matches (regular expressions),num_range

### rename columns with select
select(starwars, haircolor = hair_color)
rename(starwarsClean, haircolor = hair_color)


### mutate() : create new variables with functions of existing variables
starwarsClean <- mutate(starwarsClean, ratio = height/mass) #arithematic operators
head(starwarsClean$ratio)

glimpse(starwarsClean)
starwars_pounds <- mutate(starwarsClean, mass_lbs = mass * 2.2)
head(starwars_pounds)

select(starwars_pounds,name:mass,mass_lbs, everything())
transmute(starwarsClean, mass_lbs=mass*2.2) #only returns new variable

### summarize() and group_by()
summarize(starwarsClean, meanHeight = mean(height))

### group_by for more usefulness
starwarsGenders <- group_by(starwars, gender)
summarize(starwarsGenders, meanHeight = mean(height))
summarize(starwarsGenders, meanHeight = mean(height, na.rm = TRUE))
summarize(starwarsGenders, meanHeight = mean(height, na.rm = TRUE),number = n()) #n() returns sample size

##### Summarize groups via pipe : piping
starwarsClean %>%
  group_by(gender) %>%
  summarize(meanHeight = mean(height, na.rm = TRUE),TotalNumber = n())
