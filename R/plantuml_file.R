#' Convert file to plantuml code
#'
#' The function either plots the object including values (`yaml` and `json`) or
#' loads the object and plots the structure (`csv` and `rds`).
#' @param file file name. At the moment the following files are supported:
#'    - `.yml` or `yaml`: the yml data is graphed
#'    - `.json`: the json file is graphed
#'    - `.rds` : the file is loaded and the object contained is graphed
#'    - `.csv` : the csv is loaded and graphed
#' @param preamble **Only used for yaml and json files.** Text to be inserted
#'   after the `@startyaml` and before the actual yaml. For example style and
#'   highlight info. See [https://plantuml.com/yaml](https://plantuml.com/yaml)
#'   for further info.
#'
#' @return
#'
#' @md
#'
#' @export
#'
#' @rdname plantuml_file
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
  preamble = "",
  ...
){
  if (!file.exists(file)){
    stop("File does not exist!")
  }

  ext <- tools::file_ext(file)
  ext <- tolower(ext)

  result <- switch(
    ext,
    "yml"  = plantuml_yaml(file = file, preamble = preamble, ...),
    "yaml" = plantuml_yaml(file = file, preamble = preamble, ...),
    "json" = plantuml_json(file = file, preamble = preamble, ...),
    "csv"  = plantuml_csv(file = file, ...),
    "rds"  = plantuml_rds(file = file, ...),
    stop("Unsupported extension!", "See the help for a list of supported extensions.")
  )

}


#' Convert yaml file to uml graph
#'
#' Exactly one of the two arguments (`file` or `text`) needs tobe specified.
#' @param file file name of the yaml file. The function does **not** do any
#'   checking if the file is a yaml file!
#' @param text yaml text to be converted. The function does **not** do any
#'   checking if the file is valid yaml!
#' @param ... additional arguments. Will be passed to `readLines()`
#' @param preamble text to be inserted after the `@startyaml` and before the
#'   actual yaml. For example style and highlight info. See
#'   [https://plantuml.com/yaml](https://plantuml.com/yaml) for further info.
#'
#' @return a `plantuml` containing the yaml file for plotting
#'
#' @md
#'
#' @export
#'
#' @rdname plantuml_file
#'
#' @examples
#' ## some preparations
#' x1 <- "name: Test yml\na:\n- a\n- d\n- c\nB:\n- C\n- D\n- E\nx:\n  one: 0.2885\n  two: 0.7498\n"
#' x2 <- "name: Test yml\na:\n- a\n- b\n- c\nB:\n- C\n- D\n- E\nx:\n  one: 0.2865\n  two: 0.7498\n"
#' fn1 <- tempfile(fileext = ".yml")
#' fn2 <- tempfile(fileext = ".yml")
#' writeLines(x1, fn1)
#' writeLines(x2, fn2)
#'
#' ## and now the example
#'
#' plot(plantuml_yaml(fn1))
#'
#' ## Now let's see the differences between `fn1` and `fn2`
#' ## this requires the package `yaml` to be installed
#'
#' if (require(yaml)) {
#'   plot(
#'     plantuml_yaml(
#'       file = fn1,
#'       preamble = diff_yaml_json(yaml::read_yaml(fn1), yaml::read_yaml(fn2))
#'    )
#'   )
#' }
#'
#' ## and cleanup
#'
#' unlink(fn1)
#' unlink(fn2)
#'
plantuml_yaml <- function(
    file,
    text,
    preamble = "",
    ...
){
  if (!missing(file) & !missing(text)){
    stop("Either `file` or `text` must be specified - not both!")
  }

  if (missing(text)) {
    if (!file.exists(file)){
      stop("yaml file does not exist!")
    }
    text <- readLines(file, ...)
  }

  if (is.null(preamble)){
    preamble <- ""
  }

  code <- c(
    "@startyaml",
    preamble,
    text,
    "@endyaml"
  )
  code <- paste(code, collapse = "\n")

  return(plantuml(code))
}

#' Convert json file to uml graph
#'
#' Exactly one of the two arguments (`file` or `text`) needs tobe specified.
#' @param file file name of the json file. The function does **not** do any
#'   checking if the file is a json file!
#' @param file json text to be converted. The function does **not** do any
#'   checking if the file is valid json!
#' @param preamble text to be inserted after the `@startyaml` and before the
#'   actual yaml. For example style and highlight info. See
#'   [https://plantuml.com/yaml](https://plantuml.com/yaml) for further info.
#' @param ... additional arguments. Will be passed to `readLines()`
#'
#' @return a `plantuml` containing the json file for plotting
#'
#' @md
#'
#' @export
#'
#' @rdname plantuml_file
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
    text,
    preamble = "",
    ...
){
  if (!missing(file) & !missing(text)){
    stop("Either `file` or `text` must be specified - not both!")
  }

  if (missing(text)) {
    if (!file.exists(file)){
      stop("Json file does not exist!")
    }
    text <- readLines(file, ...)
  }


  code <- c(
    "@startjson",
    text,
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
#' @importFrom utils read.csv
#' @export
#'
#' @rdname plantuml_file
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

  code <- as.plantuml(utils::read.csv(file, ...))

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
#' @rdname plantuml_file
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
