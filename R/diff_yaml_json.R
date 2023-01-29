#' Create diff between two lists to be used in the `plantuml_yaml()` and
#' `plantuml_json()` as preamble to highlight the differences.
#'
#' This function requires that the names of `x` and `y` are identical and in the
#' same order. Any deviation from this will very likely result in strange error
#' messages. The format follows the **0Highlight parts** on
#' [https://plantuml.com/yaml](https://plantuml.com/yaml).
#' @param x list basde on yaml or json file to be compared. See the details zection for further info.
#' @param y list based on yaml or json file to be compared. See the details zection for further info.
#'
#' @return `character` vector to be used as preamble for the `plot_yaml()` and
#'   `plantuml_json()` functions (or `plantuml_file()` in case of a f=json or
#'   yaml file..
#' @export
#'
#' @examples
diff_yaml_json <- function(
    x,
    y
){
  comp <- all.equal(x, y)
  comp <- gsub(pattern = ": Component ", replacement = " / ", x = comp)
  comp <- gsub(pattern = "Component ", replacement = "#highlight ", x = comp)
  comp <- gsub(pattern = "\": .*", replacement = "\"", x = comp)
  return(comp)
}
