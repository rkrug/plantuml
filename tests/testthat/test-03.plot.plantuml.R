test_that("plot using defult (svg) without file argument", {
  vcr::local_cassette("plot.plantuml.default")
  fn <- plot(
    as.plantuml(x = list(a = 1L:10L, b = NA, c = LETTERS[1:10])),
    file = NULL
  )
  expect_snapshot_file(fn, "plot_default.svg")
  unlink(fn)
})


test_that("plot using svg", {
  svg_file <- tempfile(fileext = ".svg")
  fn <- plot(
    as.plantuml(x = list(a = 1L:10L, b = NA, c = LETTERS[1:10])),
    file = svg_file
  )
  expect_snapshot_file(fn, "plot.svg")
  unlink(svg_file)
})


test_that("plot using png", {
  png_file <- tempfile(fileext = ".png")
  fn <- plot(
    as.plantuml(x = list(a = 1L:10L, b = NA, c = LETTERS[1:10])),
    file = png_file
  )
  expect_snapshot_file(fn, "plot.png")
  unlink(png_file)
})


# test_that("plot using pdf", {
#   pdf_file <- tempfile(fileext = ".pdf")
#   fn <- plot(
#     as.plantuml(x = list(a = 1L:10L, b = NA, c = LETTERS[1:10])),
#     file = pdf_file
#   )
#   expect_snapshot_file(fn, "plot.pdf")
#   unlink(pdf_file)
# })

# test_that("plot using ps", {
#   ps_file <- tempfile(fileext = ".ps")
#   fn <- plot(
#     as.plantuml(x = list(a = 1L:10L, b = NA, c = LETTERS[1:10])),
#     file = ps_file
#   )
#   expect_snapshot_file(fn, "plot.ps")
#   unlink(ps_file)
# })

test_that("plot using txt", {
  txt_file <- tempfile(fileext = ".txt")
  fn <- plot(
    as.plantuml(x = list(a = 1L:10L, b = NA, c = LETTERS[1:10])),
    file = txt_file
  )
  expect_snapshot_file(fn, "plot.txt")
  unlink(txt_file)
})
