context("00 check update process")

test_that(
  "Automatic download when calling plantuml_run()",
  expect_error(
    object = plantuml_run(stdout = TRUE),
    regexp = NA
  )
)

test_that(
  "plantuml_update(beta = TRUE)",
  {
    expect_error(
      object = plantuml_update( beta = TRUE, quiet = TRUE ),
      regexp = NA
    )
  }
)

test_that(
  "plantuml_update(beta = FALSE)",
  {
    expect_error(
      object = plantuml_update( beta = FALSE, quiet = TRUE ),
      regexp = NA
    )
  }
)
