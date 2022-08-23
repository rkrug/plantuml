test_that(
  "Automatic download when calling plantuml_run()",
  {
    expect_snapshot(
      {
        server_info()
      }
    )
  }
)

