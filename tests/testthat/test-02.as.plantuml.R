context("02 check as.plantuml.xxx")

# as.plantuml.xxx(...) ----------------------------------------------------

test_that(
  "as.plantuml.numeric returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml( x = c(1:5, NA, NaN) ),
      file = "ref-0ref-02.as.plantuml.numeric.rda"
    )
  }
)

test_that(
  "as.plantuml.character returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml( x = c(letters[1:5], NA, NaN) ),
      file = "ref-02.as.plantuml.character.rda"
    )
  }
)

test_that(
  "as.plantuml.complex returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml( x = complex(real = 3:3, imaginary = 1:3) ),
      file = "ref-02.as.plantuml.complexr.rda"
    )
  }
)

test_that(
  "as.plantuml.data.frame returns correct plantuml object",
  {
    skip_if_not(version$major >= 4)
    expect_known_value(
      object = as.plantuml( x = data.frame(a = 1:5, b = letters[1:5]) ),
      file = "ref-02.as.plantuml.data.frame.rda"
    )
  }
)

test_that(
  "as.plantuml.default returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml.default( x = data.frame(a = 1:5, b = letters[1:5]) ),
      file = "ref-02.as.plantuml.default.rda"
    )
  }
)

test_that(
  "as.plantuml.factor returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml( x = factor(LETTERS[1:10]) ),
      file = "ref-02.as.plantuml.factor.rda"
    )
  }
)


test_that(
  "as.plantuml.factor returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml( x = factor(LETTERS[1:10]) ),
      file = "ref-02.as.plantuml.factor.rda"
    )
  }
)


test_that(
  "as.plantuml.factor returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml( x = factor(LETTERS[1:10]) ),
      file = "ref-02.as.plantuml.factor.rda"
    )
  }
)

test_that(
  "as.plantuml.integer returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml( x = 1L:10L ),
      file = "ref-02.as.plantuml.integer.rda"
    )
  }
)

test_that(
  "as.plantuml.list returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml( x = list( a = 1L:10L, b = NA, c = "LETTERS"[1:10] ) ),
      file = "ref-02.as.plantuml.list.rda"
    )
  }
)

test_that(
  "as.plantuml.logical returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml( x = c(TRUE, FALSE, NA) ),
      file = "ref-02.as.plantuml.logical.rda"
    )
  }
)

# as.plantuml(..., complete = TRUE ----------------------------------------

test_that(
  "as.plantuml.numeric returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml( x = c(1:5, NA, NaN), complete = TRUE ),
      file = "ref-02.as.plantuml.numeric.complete.rda"
    )
  }
)

test_that(
  "as.plantuml.data.frame returns correct plantuml object",
  {
    skip_if_not(version$major >= 4)
    expect_known_value(
      object = as.plantuml( x = data.frame(a = 1:5, b = letters[1:5]), complete = TRUE ),
      file = "ref-02.as.plantuml.data.frame.complete.rda"
    )
  }
)

test_that(
  "as.plantuml.default returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml.default( x = data.frame(a = 1:5, b = letters[1:5]), complete = TRUE ),
      file = "ref-02.as.plantuml.default.complete.rda"
    )
  }
)

test_that(
  "as.plantuml.list returns correct plantuml object",
  {
    expect_known_value(
      object = as.plantuml( x = list( a = 1L:10L, b = NA, c = "LETTERS"[1:10] ), complete = TRUE ),
      file = "ref-02.as.plantuml.list.complete.rda"
    )
  }
)


