#' Convert file to plantuml code
#'
#' The function either plots the object including values (`yaml` and `json`) or
#' loads the object and plots the structure (`csv` and `rds`).
#' @param file file name. At the moment the following files are supported:
#'    - `.yml` or `yaml`: the yml data is graphed
#'    - `.json`: the json file is graphed
#'    - `.rds` : the file is loaded and the object contained is graphed
#'    - `.csv` : the csv is loaded and graphed
#'
#' @return
#'
#' @md
#'
#' @export
#'
#' @examples
#' \dontrun{
#' plantuml_file("name.yml")
#' plantuml_file("name.yaml")
#' plantuml_file("name.json")
#' plantuml_file("name.rds")
#' plantuml_file("name.csv")
#' }
plantuml_file <- function(
  file,
  ...
){
  if (!file.exists(file)){
    stop("File does not exist!")
  }

  ext <- tools::file_ext(file)
  ext <- tolower(ext)

  result <- switch(
    ext,
    "yml"  = plantuml_yaml(file = file, ...),
    "yaml" = plantuml_yaml(file = file, ...),
    "json" = plantuml_json(file = file, ...),
    "csv"  = plantuml_csv(file = file, ...),
    "rds"  = plantuml_rds(file = file, ...),
    stop("Unsupported extension!", "See the help for a list of supported extensions.")
  )

}


#' Convert yaml file to uml graph
#'
#' @param file file name of the yaml file. The function does **not** do any
#'   checking if the file is a yaml file!
#' @param ... additional arguments. Will be passed to `readLines()`
#'
#' @return a `plantuml` containing the yaml file for plotting
#'
#' @md
#'
#' @export
#'
#' @examples
#' ## some preparations
#' x <- "name: Test yml\na:\n- a\n- b\n- c\nB:\n- C\n- D\n- E\nx:\n- 0.2486851\n- 0.7498182\n"
#' fn <- tempfile(fileext = ".yml")
#' writeLines(x, fn)
#'
#' ## and now the example
#'
#' plot(plantuml_yaml(fn))
#'
#' ## and cleanupo
#' unlink(fn)
#'
plantuml_yaml <- function(
    file,
    ...
){
  if (!file.exists(file)){
    stop("yaml file does not exist!")
  }

  code <- c(
    "@startyaml",
    readLines(file, ...),
    "@endyaml"
  )
  code <- paste(code, collapse = "\n")

  return(plantuml(code))
}

#' Convert json file to uml graph
#'
#' @param file file name of the json file. The function does **not** do any
#'   checking if the file is a json file!
#' @param ... additional arguments. Will be passed to `readLines()`
#'
#' @return a `plantuml` containing the json file for plotting
#'
#' @md
#'
#' @export
#'
#' @examples
#' ## some preparations
#' x <- '{"name":["Test json"],"a":["a","b","c"],"B":["C","D","E"],"x":[0.6464,0.6879]}'
#' fn <- tempfile(fileext = ".json")
#' writeLines(x, fn)
#'
#' ## and now the example
#'
#' plot(plantuml_json(fn))
#'
#' ## and cleanupo
#'
#' unlink(fn)
#'
plantuml_json <- function(
    file,
    ...
){
  if (!file.exists(file)){
    stop("json file does not exist!")
  }

  code <- c(
    "@startjson",
    readLines(file, ...),
    "@endjson"
  )
  code <- paste(code, collapse = "\n")

  return(plantuml(code))
}


#' Convert structure of `csv` file to uml graph by loading the data
#'
#' This is a convenience function which only reads the `csv` file using
#' `read.csv(file, ...)` and converts the resulting `data.frame` to a plantuml
#' object using `plantuml()`.
#' @param file file name of the `csv` file. The function does **not** do any
#'   checking if the file is a `csv` file!
#' @param ... additional arguments. Will be passed to `read.csv()`
#'
#' @return a `plantuml` containing the structure of the `csv` file for plotting
#'
#' @md
#'
#' @export
#'
#' @examples
#' ## some preparations
#' x <- data.frame(
#'   a = c("a", "b", "c"),
#'   B = c("C", "D", "E"),
#'   x = c(0.77, 0.38, 4.43),
#'   bool = c(TRUE, FALSE, FALSE)
#' )
#'
#' fn <- tempfile(fileext = ".csv")
#' write.csv(x, fn)
#'
#' ## and now the example
#'
#' plot(plantuml_csv(fn))
#'
#' # and only the fors columns (the rownames will not all be there)
#'
#' plot(plantuml_csv(fn, nrows = 1))
#'
#' # or character vectors as factors
#'
#' plot(plantuml_csv(fn, as.is = FALSE))
#'
#' ## and cleanupo
#'
#' unlink(fn)
#'
plantuml_csv <- function(
    file,
    ...
){
  if (!file.exists(file)){
    stop("csv file does not exist!")
  }

  code <- as.plantuml(read.csv(file, ...))

  return(code)
}

#' Convert structure of `rds` file to uml graph by loading the data
#'
#' This is a convenience function which only reads the `rds` file using
#' `readRDS(file, ...)` and converts the resulting object to a plantuml
#' object using `plantuml()`.
#' @param file file name of the `rds` file. The function does **not** do any
#'   checking if the file is a `rds` file!
#' @param ... additional arguments. Will be passed to `readRDS()`
#'
#' @return a `plantuml` containing the structure of the `rds` file for plotting
#'
#' @md
#'
#' @export
#'
#' @examples
#' ## some preparations
#' x <- list(
#'   name = "Test list",
#'   a = c("a", "b", "c"),
#'   B = c("C", "D", "E"),
#'   x = c(0.776318477466702, 0.381654617609456)
#' )
#'
#' fn <- tempfile(fileext = ".rds")
#' saveRDS(x, fn)
#'
#' ## and now the example
#'
#' plot(plantuml_rds(fn))
#'
#' ## and cleanupo
#'
#' unlink(fn)
#'
plantuml_rds <- function(
    file,
    ...
){
  if (!file.exists(file)){
    stop("rds file does not exist!")
  }

  code <- as.plantuml(readRDS(file, ...))

  return(code)
}
