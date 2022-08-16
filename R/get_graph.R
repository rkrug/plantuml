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
  if (inherits(x, what = "plantuml")) {
    if (!x$complete) {
      x$code <- paste("@startuml \n ", x$code, " \n @enduml")
    }
    x <- x$code
  } else if (!inherits(x, what = "character")) {
    stop("'x' has to be of class 'plantuml' or a 'character` vector containing the plantuml code!")
  }

  if (!is.null(file)) {
    pos <- regexpr("\\.([[:alnum:]]+)$", file)
    type <- ifelse( pos > -1L, substring(file, pos + 1L), "")

    if (!(type %in% getPlantumlOption("supported_formats"))) {
      stop(
        "Type '", type, "' not supported through plantUML server!"
      )
    }
  } else {
    type <- "svg"
  }

  tmptype <- ifelse(
    type == "txt",
    "txt",
    "svg"
  )
  tmpfile <- tempfile( pattern = "plantuml.", fileext = paste0(".", tmptype))


  result <- switch (
    getPlantumlOption("method"),
    "server" = {
      get_graph_server(
        x = x,
        file = tmpfile,
        type = type
      )
    },
    "local" = {
      get_graph_local(
        x = x,
        file = tmpfile,
        type = type,
        quiet = TRUE
      )
    }
  )

  if (is.null(file)){
    file <- tmpfile
  } else {
    switch (
      type,
      svg = file.copy(
        from = tmpfile,
        to = file, overwrite = TRUE
      ),
      png = rsvg::rsvg_png(
        svg = tmpfile,
        file = file,
        width = width,
        height = height,
        css = css
      ),
      pdf = rsvg::rsvg_pdf(
        svg = tmpfile,
        file = file,
        width = width,
        height = height,
        css = css
      ),
      ps = rsvg::rsvg_ps(
        svg = tmpfile,
        file = file,
        width = width,
        height = height,
        css = css
      ),
      txt = file.copy( from = tmpfile, to = file, overwrite = TRUE),
      stop("Not supported conversion!")
    )
  }


  return(result)
}
