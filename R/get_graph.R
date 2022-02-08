#' Title
#'
#' @param x plantuml code to draw the UML graph
#' @param file file name, including extension, to which the returned plantUML graph
#'   should be saved.
#'   If `NULL', the graph is saved to a temporary file.
#' @param width	output width in pixels or NULL for default.
#' @param height	output height in pixels or NULL for default
#' @param css	path/url to external css file or raw vector with css data.
#'   This requires your system has a recent version of librsvg.
#' @param ... Additional values for the function
#'   `get_graph_local()` or `get_graph_server()`
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
  width = NULL,
  height = NULL,
  css = NULL,
  ...
){
  result <- switch (
    getPlantumlOption("method"),
    "server" = {
      get_graph_server(
        x = x,
        file = file,
        width = width,
        height = height,
        css = css,
        ...
      )
    },
    "local" = {
      get_graph_local(
        x = x,
        file = file,
        width = width,
        height = height,
        css = css,
        ...
      )
    }
  )

  return(result)
}
