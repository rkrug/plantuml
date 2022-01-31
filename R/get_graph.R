#' Title
#'
#' @param x plantuml code to draw the UML graph
#' @param file
#' - **`file` is `NULL**: the graph is drawn in the graphics device.
#' - **`file` is a file name**: the graph is saved in the file and the type
#'   is based on the extensions.
#' @param vector if \code{TRUE} use `svg` as intermediate format, if \code{FALSE}
#'   use `png`. Only used when file is `NULL`.
#' @param ... Additional values for the function `get_graph_local()`.
#'
#' @return name of the file with the graph
#' @md
#' @export
#'
#' @examples
get_graph <- function(
  x,
  file = NULL,
  vector = TRUE,
  ...
){
  if ( is.null(file) ) {
    if (vector) {
      file <- tempfile( fileext = ".svg")
    } else {
      file <- tempfile( fileext = ".png")
    }
  }

  pos <- regexpr("\\.([[:alnum:]]+)$", file)
  type <- ifelse( pos > -1L, substring(file, pos + 1L), "")

  result <- ""

  if ((type %in% c("svg", "png", "txt"))){
    result <- get_graph_server(
      x = x,
      file = file,
      vector = vector,
      ...
    )
  }

  if (!file.exists(result)){
    result <- get_graph_local(
      x = x,
      file = file,
      vector = vector,
      ...
    )
  }

  return(result)
}
