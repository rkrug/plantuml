#' Register the function `plantuml_knit_engine()` with knitr
#'
#' This is a simple helper function, which registers the plantuml knit engine with knitr.
#' As a result, code chunks of type `plantuml` can be evaluated.
#' @return the result of `knitr::knit_engines$set(plantuml = plantuml::plantuml_knit_engine)`
#'
#' @md
#' @export
#'
#' @examples
#' \dontrun{
#' # in the setup chunk in a RMarkdown document, add
#' plantuml_knit_engine_register()
#' }
plantuml_knit_engine_register <- function() {
  if (system.file(package = "knitr") == "") {
    stop ("This function need the package `knitr` to be installed!")
  } else {
    knitr::knit_engines$set(plantuml = plantuml::plantuml_knit_engine)
  }
}
