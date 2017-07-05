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
#' @param plantumlOpt additional options for plantuml in addition to \code{-p} and \code{-tFILETYPE}
#' @param ... additional arguments for the plot function \code{grid::grid.raster()}
#'
#' @return returns file name (including absolute path) of the created graph.
#'
#' @export
#' @importFrom png readPNG
#' @importFrom grid grid.raster
#'
#' @examples
#' plantumlCode <- '
#'  @startuml
#'  (*) --> "First Activity"
#'  -->[You can put also labels] "Second Activity"
#'  --> (*)
#'  @enduml
#' '
#' x <- as.plantuml( plantumlCode )
#' plot( x )
plot.plantuml <- function(
  x,
  file = NULL,
  plantumlOpt = "",
  ...
  )
{
  if ( is.null(file) ) {
    fn <- tempfile( fileext = ".png")
    ffmt <- "-tpng"
  } else {
    fn <- file
    pos <- regexpr("\\.([[:alnum:]]+)$", fn)
    ext <- ifelse( pos > -1L, substring(file, pos + 1L), "")
    ffmt <- paste0("-t", ext)
  }

  system2(
    command = "plantuml",
    input = x$code,
    args = paste("-p", ffmt, plantumlOpt),
    stdout = fn
    )

  if ( is.null(file) ) {
    puml <- readPNG(
      fn,
      info = TRUE
    )

    grid::grid.raster(
      puml,
      ...
    )
  }
  invisible(fn)
}
