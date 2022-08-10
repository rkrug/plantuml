#' Title
#'
#' @param x object of `plantuml` to draw the UML graph
#' @param file file name, including extension, to which the returned plantUML graph
#'   should be saved.
#'   If `NULL', the graph is saved to a temporary file.
#' @param width	output width in pixels or NULL for default.
#' @param height	output height in pixels or NULL for default
#' @param css	path/url to external css file or raw vector with css data.
#'   This requires your system has a recent version of librsvg.
#' @param quiet	If `TRUE`, suppress status messages from the download
#' @param ... Not used at the moment.
#'
#' @return name of the file with the graph
#' @md
#'
#' @importFrom rsvg rsvg_png rsvg_pdf rsvg_ps
#' @export
#'
#' @examples
#' plantumlCode <- '
#'  @startuml
#'  (*) --> "First Activity"
#'  -->[You can put also labels] "Second Activity"
#'  --> (*)
#'  @enduml
#' '
#' \dontrun{
#' x <- as.plantuml( plantumlCode )
#' fn <- get_graph_server( x )
#' browse(fn)
#' }
get_graph_server <- function(
  x,
  file = NULL,
  width = NULL,
  height = NULL,
  css = NULL,
  quiet = TRUE,
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
        "Type '", type, "' not supported Format!"
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

  url <- plantuml_URL(
    plantuml = x,
    type = tmptype
  )

  result <- utils::download.file(url, tmpfile, quiet = quiet)

  if (result != 0) {
    unlink(file)
    stop("Error in download!")
  } else {
    result <- tmpfile
  }

  if (is.null(file)){
    file <- tmpfile
  } else {
    switch (
      type,
      svg = file.copy( from = tmpfile, to = file, overwrite = TRUE),
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

  return(file)
}
