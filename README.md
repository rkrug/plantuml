PlantUML in R
================

Overview
========

This package provides the functionality to create UML graphs using the [PlantUML](http://plantuml.com/) language.

Installation
============

The package is not on CRAN, so you have to install it from github:

``` r
# From github
# install.packages("devtools")
devtools::install_github("rkrug/plantuml")
```

    ## Skipping install of 'plantuml' from a github remote, the SHA1 (d9acb893) has not changed since last install.
    ##   Use `force = TRUE` to force installation

``` r
# download and install the PlantUML jar file from \link{http://plantuml.com/download}
library(plantuml)
updatePlantumlJar()
```

Usage
=====

In a graphical device

``` r
library(plantuml)
x <- '
 @startuml
  --> "First Activity"
 -->[You can put also labels] "Second Activity"
 -->
 @enduml
'
x <- as.plantuml( x )
plot( x )
```

![](README_files/figure-markdown_github-ascii_identifiers/exampleDevice-1.png)

To save in a file

``` r
x <- '
 @startuml
  --> "First Activity"
 -->[You can put also labels] "Second Activity"
 -->
 @enduml
'
x <- as.plantuml( x )
plot( x, file = "./README_files/test.svg" )
```

And here is the file

![README\_files/test.svg](./README_files/test.svg)

Additional info
===============
