#' Get PlantUML graph
#'
#' Get the graph from either the local PicoWeb Server included in plantuml or an
#' online plantuml server.
#' @param x plantuml code to draw the UML graph
#' @param file file name, including extension, to which the returned plantUML
#'   graph should be saved. If `NULL', the graph is saved to a temporary file.
#'   The following extensions are allowed:
#'     - **svg**: This is the default format and the one **always** used as return format for PlantUML
#'         for image formats. No conversion neeed.
#'     - **txt**: Second return format for PlantUML. No conversion neeed.
#'     - **png**: Converted from **svg** using `rsvg::rsvg_png(
#'                                                            svg = tmpfile,
#'                                                            file = file,
#'                                                            width = width,
#'                                                            height = height,
#'                                                            css = css
#'                                                            )`
#'     - **pdf** Converted from **svg** using `rsvg::rsvg_pdf(
#'                                                            svg = tmpfile,
#'                                                            file = file,
#'                                                            width = width,
#'                                                            height = height,
#'                                                            css = css
#'                                                            )`
#'     - **ps**  Converted from **svg** using `rsvg::rsvg_ps(
#'                                                           svg = tmpfile,
#'                                                           file = file,
#'                                                           width = width,
#'                                                           height = height,
#'                                                           css = css
#'                                                          )`
#' @param width	output width in pixels or NULL for default.
#' @param height	output height in pixels or NULL for default
#' @param css	path/url to external css file or raw vector with css data.
#'   This requires your system has a recent version of librsvg.
#'
#' @return name of the file with the graph
#' @md
#' @importFrom rsvg rsvg_png rsvg_pdf rsvg_ps
#' @export
#'
#' @examples
get_graph <- function(
  x,
  file = NULL,
  width = NULL,
  height = NULL,
  css = NULL
){
  formats <- c("svg", "txt", "png", "pdf", "ps")

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

    if (!(type %in% formats)) {
      stop(
        "Type '", type, "' not supported!"
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

  result <- utils::download.file(
    url,
    destfile = tmpfile,
    quiet = TRUE
  )

  if (result != 0) {
    unlink(tmpfile)
    stop("Error in download of PlantUML chart from PlantUML Server / Picoweb Server!")
  }


  if (is.null(file)){
    file <- tmpfile
  } else {
    switch (
      type,
      svg = file.copy(
        from = tmpfile,
        to = file,
        overwrite = TRUE
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
      txt = file.copy(
        from = tmpfile,
        to = file,
        overwrite = TRUE
      ),
      stop("Not supported conversion!")
    )
  }

  if (file != tmpfile){
    unlink(tmpfile)
  }

  return(file)
}
