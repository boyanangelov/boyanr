# BoyanR package

This is a collection of R functions that I have created myself or have found in solutions and suggestions on the net. If a known attribution is missing, please contact me.

## Installation

```r
# install devtools if you don't have it already
install.packages("devtools")

# install package
devtools::install_github('bobbyangelov/boyanr')

# load package
library(boyanr)
```

List of available functions:

* `missmap()`: generates a visualisation of missing values
* `inference()`: useful for statistical inference 
* `outliersDetect()`: visualise and modify outliers in a variable 

Example of `missmap` usage:

![nyc](http://i64.tinypic.com/20rjtz9.png)
