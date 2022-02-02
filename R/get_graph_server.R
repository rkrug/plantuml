#' Title
#'
#' @param x object of `plantuml` to draw the UML graph
#' @param file
#' - **`file` is `NULL**: the graph is drawn in the graphics device.
#' - **`file` is a file name**: the graph is saved in the file and the type
#'   is based on the extensions.
#' @param vector if \code{TRUE} use `svg` as intermediate format, if \code{FALSE}
#'   use `png`. Only used when file is `NULL`.
#' @param ... for compatibility with `get_graph_local()`. Not used at the moment.
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

  url <- plantuml_URL(
    plantuml = x,
    type = tmptype
  )

  result <- utils::download.file(url, tmpfile)

  if (result != 0) {
    unlink(file)
    stop("Error in download!")
  } else {
    result <- tmpfile
  }

  if (force_png){
    if (!is.null(file)) { file.copy( from = tmpfile, to = file, overwrite = TRUE) }
  } else if (type != "svg") {
    switch (
      type,
      png = rsvg::rsvg_png(svg = tmpfile, file = file),
      pdf = rsvg::rsvg_pdf(svg = tmpfile, file = file),
      ps  = rsvg::rsvg_ps(svg = tmpfile, file = file),
      txt = if (!is.null(file)){ file.copy( from = tmpfile, to = file, overwrite = TRUE) },
      stop("Not supported conversion!")
    )
  }

  if (is.null(file)){
    file <- tmpfile
  }

  return(file)
}
