context("check plot.plantuml()")

# plot.plantuml(..., file = "x.png) ----------------------------------------------------

test_that(
  "create new reference png file - creation does complete without errors",
  expect_error(
    if (!file.exists("3.plot.plantuml.png")) {
      plot( as.plantuml( x = list( a = 1L:10L, b = NA, c = LETTERS[1:10] ) ), file = "3.plot.plantuml.png" )
    },
    regexp = NA
  )
)

unlink("plot.plantuml.png", force = TRUE)
plot( as.plantuml( x = list( a = 1L:10L, b = NA, c = LETTERS[1:10] ) ), file = "plot.plantuml.png" )

test_that(
  "plot.plantuml plots correct graph",
  {
    expect_equivalent(
      object = tools::md5sum("plot.plantuml.png"),
      expect = tools::md5sum("3.plot.plantuml.png")
    )
  }
)


# plot.plantuml(...) to graphic device  -----------------------------------



