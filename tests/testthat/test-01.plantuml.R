context("01 check plantuml object creation")

test_that(
  "plantuml() returns correct plantuml object",
  {
    expect_known_value(
      object = plantuml("Test"),
      file = "ref-01.plantuml.test.rda"
    )
  }
)
