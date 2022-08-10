test_that(
  "plot using png",
  expect_snapshot(
    {
      skip_on_cran()
      {
        plot(
          as.plantuml( x = list( a = 1L:10L, b = NA, c = LETTERS[1:10] ) ),
          formatt = "png",
          file = NULL
        )
      }
    }
  )
)

test_that(
  "plot using svge",
  {
    expect_snapshot(
      {
        skip_on_cran()
        {
          plot(
            as.plantuml( x = list( a = 1L:10L, b = NA, c = LETTERS[1:10] ) ),
            format = "svg",
            file = NULL
          )
        }
      }
    )
  }
)


