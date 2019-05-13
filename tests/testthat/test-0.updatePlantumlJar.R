context("check update process")

test_that(
  "updatePlantumlJar(beta = TRUE)",
  {
    expect_error(
      object = updatePlantumlJar( beta = TRUE, quiet = TRUE ),
      regexp = NA
    )
  }
)

test_that(
  "updatePlantumlJar(beta = FALSE)",
  {
    expect_error(
      object = updatePlantumlJar( beta = FALSE, quiet = TRUE ),
      regexp = NA
    )
  }
)
