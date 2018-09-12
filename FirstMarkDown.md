---
title: "FirstMarkDown"
author: "Anoob Prakash"
date: "6 September 2018"
output: 
  html_document: 
    keep_md: yes
---




```r
library(knitr)
kable(head(iris))
```



 Sepal.Length   Sepal.Width   Petal.Length   Petal.Width  Species 
-------------  ------------  -------------  ------------  --------
          5.1           3.5            1.4           0.2  setosa  
          4.9           3.0            1.4           0.2  setosa  
          4.7           3.2            1.3           0.2  setosa  
          4.6           3.1            1.5           0.2  setosa  
          5.0           3.6            1.4           0.2  setosa  
          5.4           3.9            1.7           0.4  setosa  

##Fractions and Greek symbols

$$ \alpha = \frac{\beta}{\delta + \gamma_{x=3}} $$

##Summation sign

$$z=\sum_{i=1}^{J-1}{K_i}$$

##Escaping backslash character

$$\backslash \alpha \ge b \backslash$$

##Mixing plain text in LaTeX

$$P(\mbox{Occurrence Of Species A}) = Z$$

