test_that(
  "Automatic download when calling plantuml_run()",
  {
    expect_snapshot(
      {
        plantuml_run()
      }
    )
  }
)

test_that(
  "plantuml_update(beta = TRUE)",
  {
    expect_snapshot(
      {
        plantuml_update( beta = TRUE, quiet = TRUE )
      }
    )
  }
)

test_that(
  "plantuml_update(beta = FALSE)",
  {
    expect_snapshot(
      {
        plantuml_update( beta = FALSE, quiet = TRUE )
      }
    )
  }
)
