context("04 knitr_engine")

test_that("An R Markdown document can be rendered using reticulate", {
  # skip_on_cran()
  # skip_if_not_installed("rmarkdown")

  status <- rmarkdown::render("rmd-04.Rmd", quiet = TRUE)

  expect_true(
    file.exists(status),
    "example.Rmd rendered successfully"
  )
  expect_true(
    file.exists("./graphs/diagram_png.png"),
    "diagram_png.png created successfully"
  )
  expect_true(
    file.exists("./graphs/diagram_png.png"),
    "diagram_png.png created successfully"
  )
  expect_true(
    file.exists("./graphs/diagram_png_code.png"),
    "diagram_png_code.png created successfully"
  )
  expect_true(
    file.exists("./graphs/diagram_svg.svg"),
    "diagram_svg.svg created successfully"
  )

  unlink(status)
  unlink("./graphs", recursive = TRUE)
})
