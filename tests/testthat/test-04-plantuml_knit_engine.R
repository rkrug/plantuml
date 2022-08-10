test_that(
  "An R Markdown document can be rendered", {
    expect_snapshot_file( #IMPLEMENT THIS
      {
        outputdir <- tempfile()
        dir.create(outputdir)
        outputfile <- file.path(outputdir, "rmd-04.html")

        rmarkdown::render(
          input = "./rmd-04.Rmd",
          output_dir = outputdir,
          quiet = TRUE,
          output_file = outputfile
        )
        file.exists("./rmd-04.html")
      }
    )
  }
)

test_that(
  "The graphs are created as expected", {
  expect_snapshot_file(
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
  # unlink("./rmd-04.html")
  # unlink("./graphs", recursive = TRUE)
  }
)
