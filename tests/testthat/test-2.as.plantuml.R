context("check as.plantuml.xxx")

# as.plantuml.xxx(...) ----------------------------------------------------

test_that(
  "as.plantuml.numeric returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = c(1:5, NA, NaN) ),
      print = TRUE,
      file = "2.as.plantuml.numeric.txt"
    )
  }
)

test_that(
  "as.plantuml.character returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = c(letters[1:5], NA, NaN) ),
      print = TRUE,
      file = "2.as.plantuml.character.txt"
    )
  }
)

test_that(
  "as.plantuml.complex returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = complex(real = 3:3, imaginary = 1:3) ),
      print = TRUE,
      file = "2.as.plantuml.complexr.txt"
    )
  }
)

test_that(
  "as.plantuml.data.frame returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = data.frame(a = 1:5, b = letters[1:5]) ),
      print = TRUE,
      file = "2.as.plantuml.data.frame.txt"
    )
  }
)

test_that(
  "as.plantuml.default returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml.default( x = data.frame(a = 1:5, b = letters[1:5]) ),
      print = TRUE,
      file = "2.as.plantuml.default.txt"
    )
  }
)

test_that(
  "as.plantuml.factor returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = factor(LETTERS[1:10]) ),
      print = TRUE,
      file = "2.as.plantuml.factor.txt"
    )
  }
)


test_that(
  "as.plantuml.factor returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = factor(LETTERS[1:10]) ),
      print = TRUE,
      file = "2.as.plantuml.factor.txt"
    )
  }
)


test_that(
  "as.plantuml.factor returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = factor(LETTERS[1:10]) ),
      print = TRUE,
      file = "2.as.plantuml.factor.txt"
    )
  }
)

test_that(
  "as.plantuml.integer returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = 1L:10L ),
      print = TRUE,
      file = "2.as.plantuml.integer.txt"
    )
  }
)

test_that(
  "as.plantuml.list returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = list( a = 1L:10L, b = NA, c = "LETTERS"[1:10] ) ),
      print = TRUE,
      file = "2.as.plantuml.list.txt"
    )
  }
)

test_that(
  "as.plantuml.logical returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = c(TRUE, FALSE, NA) ),
      print = TRUE,
      file = "2.as.plantuml.logical.txt"
    )
  }
)

# as.plantuml(..., complete = TRUE ----------------------------------------

test_that(
  "as.plantuml.numeric returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = c(1:5, NA, NaN), complete = TRUE ),
      print = TRUE,
      file = "2.as.plantuml.numeric.complete.txt"
    )
  }
)

test_that(
  "as.plantuml.data.frame returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = data.frame(a = 1:5, b = letters[1:5]), complete = TRUE ),
      print = TRUE,
      file = "2.as.plantuml.data.frame.complete.txt"
    )
  }
)

test_that(
  "as.plantuml.default returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml.default( x = data.frame(a = 1:5, b = letters[1:5]), complete = TRUE ),
      print = TRUE,
      file = "2.as.plantuml.default.complete.txt"
    )
  }
)

test_that(
  "as.plantuml.list returns correct plantuml object",
  {
    expect_known_output(
      object = as.plantuml( x = list( a = 1L:10L, b = NA, c = "LETTERS"[1:10] ), complete = TRUE ),
      print = TRUE,
      file = "2.as.plantuml.list.complete.txt"
    )
  }
)


