test_that(
  "plot using defult (svg) without file argument",
  {
    vdiffr::expect_doppelganger(
      "Plot from svg without file argument",
      plot(
        as.plantuml( x = list( a = 1L:10L, b = NA, c = LETTERS[1:10] ) ),
        file = NULL
      )
    )
  }
)


test_that(
  "plot using svg",
  {
    vdiffr::expect_doppelganger(
      "plot using svg",
      {
        svg_file <- tempfile(fileext = ".svg")
        plot(
          as.plantuml( x = list( a = 1L:10L, b = NA, c = LETTERS[1:10] ) ),
          file = svg_file
        )
      }
    )
  }
)


test_that(
  "plot using png",
  {
    vdiffr::expect_doppelganger(
      "plot using png",
      {
        png_file <- tempfile(fileext = ".png")
        plot(
          as.plantuml( x = list( a = 1L:10L, b = NA, c = LETTERS[1:10] ) ),
          file = png_file
        )
      }
    )
  }
)


# test_that(
#   "plot using pdf",
#   {
#     expect_snapshot(
#       "plot using pdf",
#       {
#         pdf_file <- tempfile(fileext = ".pdf")
#         suppressWarnings(
#           plot(
#             as.plantuml( x = list( a = 1L:10L, b = NA, c = LETTERS[1:10] ) ),
#             file = pdf_file
#           )
#         )
#         readLines(pdf_file)
#       }
#     )
#   }
# )


# test_that(
#   "plot using ps",
#   {
#     expect_snapshot(
#       {
#         ps_file <- tempfile(fileext = ".ps")
#         suppressWarnings(
#           plot(
#             as.plantuml( x = list( a = 1L:10L, b = NA, c = LETTERS[1:10] ) ),
#             file = ps_file
#           )
#         )
#         readLines(ps_file)
#       }
#     )
#   }
# )

test_that(
  "plot using txt",
  {
    expect_snapshot(
      {
        {
          txt_file <- tempfile(fileext = ".txt")
          suppressWarnings(
            plot(
              as.plantuml( x = list( a = 1L:10L, b = NA, c = LETTERS[1:10] ) ),
              file = txt_file
            )
          )
          readLines(txt_file)
        }
      }
    )
  }
)


