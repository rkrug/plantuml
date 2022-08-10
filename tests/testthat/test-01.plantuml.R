test_that(
  "plantuml() returns correct plantuml object",
  {
    expect_snapshot(
      {
        plantuml("Test")
      }
    )
  }
)
