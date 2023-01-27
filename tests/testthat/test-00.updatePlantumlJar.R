# test_that(
#   "Automatic download when calling plantuml_run()",
#   {
#     expect_snapshot(
#       {
#         plantuml_run()
#       }
#     )
#   }
# )
unlink(getPlantumlOption("jar_name"))

test_that(
  "plantuml jar does not exist",
  {
    expect_snapshot(
      {
        file.exists(getPlantumlOption("jar_name"))
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
  "plantuml jar exists",
  {
    expect_snapshot(
      {
        file.exists(getPlantumlOption("jar_name"))
      }
    )
  }
)

unlink(getPlantumlOption("jar_name"))

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

test_that(
  "plantuml jar exists",
  {
    expect_snapshot(
      {
        file.exists(getPlantumlOption("jar_name"))
      }
    )
  }
)

