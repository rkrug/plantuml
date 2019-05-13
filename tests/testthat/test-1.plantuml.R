context("check plantuml object creation")

test_that(
  "plantuml() returns correct plantuml object",
  {
    expect_known_output(
      object = plantuml("Test"),
      print = TRUE,
      file = "1.plantuml.test.txt"
    )
  }
)
