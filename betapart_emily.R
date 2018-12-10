# Analyzing occupancy data using betapart 
# December 05, 2018
# Emily

library(tidyverse)
library(patchwork)
library(betapart)

# Load data
occmats <- readRDS(file = "Zs.RDS")

# Convert to long format
long.dat <- function(x){
  x <- as.data.frame(x)
  x$sites <- c(1:16)
  x %>%
    gather(Spec1:Spec8, key = "Species", value = "OccProb")
}

# Run it
long2016 <- long.dat(x = occmats[[1]])
long2017 <- long.dat(x = occmats[[2]])

# Plot it
occplot1 <- ggplot(data = long2016, aes(x = Species, y = sites,
                                        fill = OccProb)) + 
  geom_tiles() +
  scale_fill_gradient(low = "white", high = "black", guide = F)

occplot1 <- ggplot(data = long2017, aes(x = Species, y = sites,
                                        fill = OccProb)) + 
  geom_tiles() +
  scale_fill_gradient(low = "white", high = "black", guide = F)

plot <- occplot1|occplot2
print(plot)

# betapart can only use values between 0 and 1
occmats <- lapply(occmats, function(x) ifelse(x < 1, 0, x))

# Calculate Jaccard using beta.temp
temporal <- beta.temp(x=occmats[[1]], y = occmats[[2]], index.family = "jaccard")

# site-by-site differences using beta.pair
spatial <- beta.pair(x = occmats[[1]], index.family = "jaccard")