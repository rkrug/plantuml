#' Generate UML graph from plantuml
#'
#' Generate an image containing based ion the plantuml code.
#' TODO use pipe instead of temporary file
#' TODO scale window according to png
#' TODO can I use vector formats?
#'
#' @param plantuml plantuml code to draw the UML graph
#' @param file if \codew{file} is \code{NULL}, a png is created, saved in a
#'   temporary file and drawn in a device. If file is a file name, the graph is
#'   saved in the file and the type is based on the extensions. See limitations
#'   of plantuml to get the list of available file formats]
#' @param plantumlOpt additional options for plantuml in addition to \code{-p} and \code{-tFILETYPE}
#'
#' @return returns file name (including absolute path) of the created graph.
#'
#' @export
#' @importFrom png readPNG
#'
#' @examples
plotPlantuml <- function(
  plantuml,
  file = NULL,
  plantumlOpt = ""
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
    input = plantuml,
    args = paste("-p", ffmt, plantumlOpt),
    stdout = fn
    )

  if ( is.null(file) ) {
    puml <- readPNG(
      fn,
      info = TRUE
    )

    plot(
      1:1,
      type = "n",
      axes = FALSE,
      xlab = "",
      ylab = ""
      )
    lim <- par()
    rasterImage(
      puml,
      lim$usr[1],
      lim$usr[3],
      lim$usr[2],
      lim$usr[4])
  }
  invisible(fn)
}
