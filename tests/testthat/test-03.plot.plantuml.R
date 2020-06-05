# plot.plantuml(..., file = "" ) ----------------------------------------------------

context("03 check plot.plantuml() file = ''")

test_that(
  "plot using png to variable",
  expect_known_value(
    plot(
      as.plantuml( x = list( a = 1L:10L, b = NA, c = LETTERS[1:10] ) ),
      plantuml_opt = "tpng",
      file = ""
    ),
    file = "ref-03.plot.plantuml.png.rda"
  )
)

test_that(
  "plot using svg to variable",
  expect_known_value(
    plot(
      as.plantuml( x = list( a = 1L:10L, b = NA, c = LETTERS[1:10] ) ),
      plantuml_opt = "tsvg",
      file = ""
    ),
    file = "ref-03.plot.plantuml.svg.rda"
  )
)

# plot.plantuml(..., file = 'test.x')  -----------------------------------

context("03 check plot.plantuml() file = 'ref-03.plot.plantuml.x'")

# plot.plantuml(..., file = NULL)  -----------------------------------

context("03 check plot.plantuml() file = NULL")


