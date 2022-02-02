#' Title
#'
#' @param x plantuml code to draw the UML graph
#' @param file file name, including extension, to which the returned plantUML graph
#'   should be saved. The extension has priority over the parameter `force_png`, i.e.
#'   if the filename has the extension `.svg`, the parameter 'force_png` is ignored.
#'   If `NULL', the graph is saved to a temporary file.
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
  force_png = FALSE,
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
    if (force_png & type == "png") {
      tmptype <- "png"
    } else {
      tmptype <- "svg"
      force_png <- FALSE
    }
  } else {
    tmptype <- ifelse(
      force_png,
      "png",
      "svg"
    )
    type <- tmptype
  }

  if (type == "txt") {
    tmptype <- "txt"
  }

  tmpfile <- tempfile( pattern = "plantuml.", fileext = paste0(".", tmptype))

  result <- plantuml_run(
    x = x,
    file = tmpfile
  )

  if (result != 0) {
    unlink(file)
    stop("Error in generating graph!")
  } else {
    result <- tmpfile
  }

  if (force_png){
    if (!is.null(file)) { file.copy( from = tmpfile, to = file, overwrite = TRUE) }
  } else {
    switch (
      type,
      png = rsvg::rsvg_png(svg = tmpfile, file = file),
      pdf = rsvg::rsvg_pdf(svg = tmpfile, file = file),
      ps  = rsvg::rsvg_ps(svg = tmpfile, file = file),
      txt = if (!is.null(file)){ file.copy( from = tmpfile, to = file, overwrite = TRUE) },
      svg = if (!is.null(file)){ file.copy( from = tmpfile, to = file, overwrite = TRUE) },
      stop("Not supported conversion!")
    )
  }

  if (is.null(file)){
    file <- tmpfile
  }

  return(file)
}
