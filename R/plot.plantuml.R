#' Generate UML graph from plantuml
#'
#' Generate an image containing based ion the plantuml code.
#' TODO can I use vector formats?
#'
#' @param x plantuml code to draw the UML graph
#' @param file if \code{file} is \code{NULL}, a png is created, saved in a
#'   temporary file and drawn in a device. If file is a file name, the graph is
#'   saved in the file and the type is based on the extensions. See limitations
#'   of plantuml to get the list of available file formats]
#' @param plantuml_opt additional options for plantuml in addition to \code{-p} and \code{-tFILETYPE}
#' @param vector if \code{TRUE} use svg as intermediate format, if \code{FALSE} use png. Only effects plotting in device.
#' @param ... additional arguments for the plot function \code{grid::grid.raster()}
#'
#' @return returns file name (including absolute path) of the created graph.
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom png readPNG
#' @importFrom grid grid.raster
#' @importFrom grImport PostScriptTrace readPicture picture
#' @importFrom graphics plot
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
#' #' x <- as.plantuml( plantumlCode )
#' plot( x )
#' }
plot.plantuml <- function(
  x,
  file = NULL,
  plantuml_opt = "",
  vector = TRUE,
  ...
  ){
  if (!x$complete) {
    x$code <- paste("@startuml \n ", x$code, " \n @enduml")
  }
  if ( is.null(file) ) {
    if (vector) {
      fn <- tempfile( fileext = ".svg")
      ffmt <- "-tsvg"
      fn <- tempfile( fileext = ".eps")
      ffmt <- "-teps"
    } else {
      fn <- tempfile( fileext = ".png")
      ffmt <- "-tpng"
    }
  } else {
    fn <- file
    pos <- regexpr("\\.([[:alnum:]]+)$", fn)
    ext <- ifelse( pos > -1L, substring(file, pos + 1L), "")
    ffmt <- paste0("-t", ext)
  }

  cmd <- paste0(
    "-jar ",
    system.file("jar", "plantuml.jar", package = "plantuml")
  )
  if (is.null(file)) {
    if (vector) {
      # system2(
      #   command = "java",
      #   input = x$code,
      #   args = paste(cmd, "-p", ffmt, plantuml_opt),
      #   stdout = TRUE
      # ) %>%
      #   paste0(., collapse = "") %>%
      #   charToRaw(.) %>%
      #   rsvg::rsvg_svg(NULL, file = NULL) %>%
      #   rawToChar(.) %>%
      #   grImport2::readPicture(.) %>%
      #   grImport2::grid.picture(.)

      system2(
        command = "java",
        input = x$code,
        args = paste(cmd, "-p", ffmt, plantuml_opt),
        stdout = fn
      )
      fnrgl <- gsub(".eps", ".rgml", fn)
      grImport::PostScriptTrace(
        file = fn,
        outfilename = fnrgl
      )
      prgml <- grImport::readPicture(
        rgmlFile = fnrgl
      )
      plot(
        range(prgml@summary@xscale),
        range(prgml@summary@yscale),
        type = "n",
        axes = FALSE,
        xlab = "",
        ylab = "",
        asp = 1
      )
      picture(
        picture = prgml,
        xleft   = prgml@summary@xscale["xmin"],
        xright  = prgml@summary@xscale["xmax"],
        ybottom = prgml@summary@yscale["ymin"],
        ytop    = prgml@summary@yscale["ymax"]
      )
    } else {
      system2(
        command = "java",
        input = x$code,
        args = paste(cmd, "-p", ffmt, plantuml_opt),
        stdout = fn
      )
      puml <- png::readPNG(
        fn,
        info = TRUE
      )
      grid::grid.raster(
        puml,
        ...
      )
    }
  } else {
    system2(
      command = "java",
      input = x$code,
      args = paste(cmd, "-p", ffmt, plantuml_opt),
      stdout = fn
    )
  }
  invisible()
}
