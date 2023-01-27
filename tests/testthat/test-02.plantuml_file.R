# as.plantuml.xxx(...) ----------------------------------------------------

x <- "name: Test yml\na:\n- a\n- b\n- c\nB:\n- C\n- D\n- E\nx:\n- 0.2486851\n- 0.7498182\n"
fn_yml <- tempfile(fileext = ".yml")
writeLines(x, fn_yml)
fn_yaml <- tempfile(fileext = ".yaml")
writeLines(x, fn_yaml)

x <- '{"name":["Test json"],"a":["a","b","c"],"B":["C","D","E"],"x":[0.6464,0.6879]}'
fn_json <- tempfile(fileext = ".json")
writeLines(x, fn_json)

x <- data.frame(
  a = c("a", "b", "c"),
  B = c("C", "D", "E"),
  x = c(0.77, 0.38, 4.43),
  bool = c(TRUE, FALSE, FALSE)
)
fn_csv <- tempfile(fileext = ".csv")
write.csv(x, fn_csv)

x <- list(
  name = "Test list",
  a = c("a", "b", "c"),
  B = c("C", "D", "E"),
  x = c(0.776318477466702, 0.381654617609456)
)
fn_rds <- tempfile(fileext = ".rds")
saveRDS(x, fn_rds)

test_that(
  "plantuml_yml",
  {
    expect_snapshot(
      {
        plantuml_yaml(fn_yml)
        identical(plantuml_yaml(fn_yml), plantuml_file(fn_yml))
      }
    )
  }
)

test_that(
  "plantuml_yaml",
  {
    expect_snapshot(
      {
        plantuml_yaml(fn_yaml)
        identical(plantuml_yaml(fn_yaml), plantuml_file(fn_yaml))
      }
    )
  }
)

test_that(
  "plantuml_json",
  {
    expect_snapshot(
      {
        plantuml_json(fn_json)
        identical(plantuml_json(fn_json), plantuml_file(fn_json))
      }
    )
  }
)

test_that(
  "plantuml_csv",
  {
    expect_snapshot(
      {
        plantuml_csv(fn_csv)
        identical(plantuml_csv(fn_csv), plantuml_file(fn_csv))
      }
    )
  }
)

test_that(
  "plantuml_rds",
  {
    expect_snapshot(
      {
        plantuml_rds(fn_rds)
        identical(plantuml_rds(fn_rds), plantuml_file(fn_rds))
      }
    )
  }
)


unlink(fn_yml)
unlink(fn_yaml)
unlink(fn_json)
unlink(fn_csv)
unlink(fn_rds)


