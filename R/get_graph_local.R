#' Title
#'
#' @param x plantuml code to draw the UML graph
#' @param file
#' - **`file` is `NULL**: the graph is drawn in the graphics device.
#' - **`file` is a file name**: the graph is saved in the file and the type
#'   is based on the extensions.
#' @param vector if \code{TRUE} use `svg` as intermediate format, if \code{FALSE}
#'   use `png`. Only used when file is `NULL`.
#' @param plantuml_opt additional options for plantuml in addition to \code{-p}
#'   and \code{-tFILETYPE}. See `plantuml_run() for a list of available file formats.
#' @param ... for compatibility with `get_graph_server()`. Not used at the moment.
#'
#' @return name of the file with the graph
#' @md
#' @export
#'
#' @examples
get_graph_local <- function(
  x,
  file = NULL,
  vector = TRUE,
  plantuml_opt = "-Playout=smetana",
  ...
){

  if (!x$complete) {
    x$code <- paste("@startuml \n ", x$code, " \n @enduml")
  }

  if ( is.null(file) ) {
    if (vector) {
      file <- tempfile( fileext = ".svg")
    } else {
      file <- tempfile( fileext = ".png")
    }
  }

  pos <- regexpr("\\.([[:alnum:]]+)$", file)
  ext <- ifelse( pos > -1L, substring(file, pos + 1L), "")
  ffmt <- paste0("-t", ext)
  plantuml_opt = paste("-p", ffmt, plantuml_opt)

  result <- plantuml_run(
    plantuml_opt = plantuml_opt,
    stdout = file,
    input = x$code
  )

}
