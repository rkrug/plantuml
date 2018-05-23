## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(plantuml)

## ----installation_plantuml, eval = FALSE---------------------------------
#  updatePlantumlJar()

## ----definePlantuml------------------------------------------------------
library(plantuml)
x <- '
(*) --> "Initialization"

if "Some Test" then
  -->[true] "Some Activity"
  --> "Another activity"
  -right-> (*)
else
  ->[false] "Something else"
  -->[Ending process] (*)
endif
'
x <- plantuml( 
  x
)

## ----exampleDeviceVector-------------------------------------------------
plot( 
  x = x
# vector = TRUE
  )

