#' Title
#'
#' @param x plantuml code to draw the UML graph
#' @param file file name, including extension, to which the returned plantUML graph
#'   should be saved. The extension has priority over the parameter `force_png`, i.e.
#'   if the filename has the extension `.svg`, the parameter 'force_png` is ignored.
#'   If `NULL', the graph is saved to a temporary file.
#' @param force_png if `TRUE`, a png will be returned from the plantuml server,
#'   if `FALSE`, a svg will be returned and
#' @param ... Additional values for the function `get_graph_local()` or `get_graph_server()`
#'   but not used at the moment.
#'
#' @return name of the file with the graph
#' @md
#' @export
#'
#' @examples
get_graph <- function(
  x,
  file = NULL,
  force_png = FALSE,
  ...
){
  if ( is.null(file) ) {
    if (force_png) {
      file <- tempfile( fileext = ".png")
    } else {
      file <- tempfile( fileext = ".svg")
    }
  }

  pos <- regexpr("\\.([[:alnum:]]+)$", file)
  type <- ifelse( pos > -1L, substring(file, pos + 1L), "")

  result <- ""

  switch (
    getPlantumlOption("always_use"),
    "server" = {
      get_graph_server(
        x = x,
        file = file,
        vector = vector,
        ...
      )
    },
    "local" = {
      result <- get_graph_local(
        x = x,
        file = file,
        vector = vector,
        ...
      )
    },
    "auto" = {
      result <- NULL
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
    }
  )
  return(result)
}
