# as.plantuml.xxx(...) ----------------------------------------------------

test_that(
  "as.plantuml.numeric returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml( x = c(1:5, NA, NaN) )
    )
  }
)

test_that(
  "as.plantuml.character returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml( x = c(letters[1:5], NA, NaN) )
    )
  }
)

test_that(
  "as.plantuml.complex returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml( x = complex(real = 3:3, imaginary = 1:3) )
    )
  }
)

test_that(
  "as.plantuml.data.frame returns correct plantuml object",
  {
    skip_if_not(version$major >= 4)
    expect_snapshot(
     as.plantuml( x = data.frame(a = 1:5, b = letters[1:5]) )
    )
  }
)

test_that(
  "as.plantuml.default returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml.default( x = data.frame(a = 1:5, b = letters[1:5]) )
    )
  }
)

test_that(
  "as.plantuml.factor returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml( x = factor(LETTERS[1:10]) )
    )
  }
)


test_that(
  "as.plantuml.factor returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml( x = factor(LETTERS[1:10]) )
    )
  }
)


test_that(
  "as.plantuml.factor returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml( x = factor(LETTERS[1:10]) )
    )
  }
)

test_that(
  "as.plantuml.integer returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml( x = 1L:10L )
    )
  }
)

test_that(
  "as.plantuml.list returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml( x = list( a = 1L:10L, b = NA, c = "LETTERS"[1:10] ) )
    )
  }
)

test_that(
  "as.plantuml.logical returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml( x = c(TRUE, FALSE, NA) )
    )
  }
)

# as.plantuml(..., complete = TRUE ----------------------------------------

test_that(
  "as.plantuml.numeric returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml( x = c(1:5, NA, NaN), complete = TRUE )
    )
  }
)

test_that(
  "as.plantuml.data.frame returns correct plantuml object",
  {
    skip_if_not(version$major >= 4)
    expect_snapshot(
     as.plantuml( x = data.frame(a = 1:5, b = letters[1:5]), complete = TRUE )
    )
  }
)

test_that(
  "as.plantuml.default returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml.default( x = data.frame(a = 1:5, b = letters[1:5]), complete = TRUE )
    )
  }
)

test_that(
  "as.plantuml.list returns correct plantuml object",
  {
    expect_snapshot(
     as.plantuml( x = list( a = 1L:10L, b = NA, c = "LETTERS"[1:10] ), complete = TRUE )
    )
  }
)


