#' Generate UML graph from plantuml
#'
#' Generate an image containing based ion the plantuml code.
#' TODO can I use vector formats?
#'
#' @param x plantuml code to draw the UML graph
#' @param file
#' - **`file` is `NULL**: the graph is drawn in the graphics device.
#' - **`file` is a file name**: the graph is saved in the file and the type
#'   is based on the extensions.
#'- **`file` is `NULL`**: the data which would have been saved in the file
#'  is returned in a character vector. **This is only useful for text formats
#'  like `eps` or `svg`!**
#'
#' @param plantuml_opt additional options for plantuml in addition to \code{-p}
#'   and \code{-tFILETYPE}. See `plantuml_run() for a list of available file formats.
#' @param vector if \code{TRUE} use `svg` as intermediate format, if \code{FALSE}
#'   use `png`. Only effects plotting in device.
#' @param ... additional arguments for the `plot` function and the `plantuml_run` function.
#'
#' @md
#' @return returns file name (including absolute path) of the created graph.
#'
#' @export
#' @importFrom png readPNG
#' @importFrom magrittr %>%
#' @importFrom grImport PostScriptTrace readPicture picture
#' @importFrom graphics plot rasterImage
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
#' plot( x )
#' plot(as.plantuml(x), java_opt = "-Djava.awt.headless=true")
#' }
plot.plantuml <- function(
  x,
  file = NULL,
  plantuml_opt = "",
  vector = TRUE,
  ...
){


  result <- get_graph(
    x = x,
    file = file,
    vector = vector,
    plantuml_opt = plantuml_opt
  )

  # if (!x$complete) {
  #   x$code <- paste("@startuml \n ", x$code, " \n @enduml")
  # }
  # if ( is.null(file) ) {
  #   if (vector) {
  #     # fn <- tempfile( fileext = ".svg")
  #     # ffmt <- "-tsvg"
  #     fn <- tempfile( fileext = ".eps")
  #     ffmt <- "-teps"
  #     plantuml_opt = paste("-p", ffmt, plantuml_opt)
  #   } else {
  #     fn <- tempfile( fileext = ".png")
  #     ffmt <- "-tpng"
  #     plantuml_opt = paste("-p", ffmt, plantuml_opt)
  #   }
  # } else if (file == "") {
  #   plantuml_opt = paste("-p",plantuml_opt)
  # } else {
  #   fn <- file
  #   pos <- regexpr("\\.([[:alnum:]]+)$", fn)
  #   ext <- ifelse( pos > -1L, substring(file, pos + 1L), "")
  #   ffmt <- paste0("-t", ext)
  #   plantuml_opt = paste("-p", ffmt, plantuml_opt)
  # }

  if (is.null(file)) {
    if (vector) {
      ps <- tempfile(fileext = ".ps")
      rgml <- tempfile(fileext = ".xml")
      rsvg::rsvg_ps(
        svg = result,
        file = ps
      )
      grImport::PostScriptTrace(
        file = ps,
        outfilename = rgml
      )
      prgml <- grImport::readPicture(
        rgmlFile = rgml
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
      # result <- plantuml_run(
      #   plantuml_opt = plantuml_opt,
      #   stdout = fn,
      #   input = x$code
      # )
      puml <- png::readPNG(
        fn,
        info = TRUE
      )
      plot(
        range(0, attr(puml, "dim")[[2]]),
        range(0, attr(puml, "dim")[[1]]),
        type = "n",
        axes = FALSE,
        xlab = "",
        ylab = "",
        asp = 1
      )
      graphics::rasterImage(
        image = puml,
        xleft = 0,
        xright = attr(puml, "dim")[[2]],
        ybottom = 0,
        ytop = attr(puml, "dim")[[1]]
      )
    }
  } else if (file == "") {
    # THIS NEEDS TWEAKING!!!!!
    # result <- plantuml_run(
    #   plantuml_opt = plantuml_opt,
    #   stdout = TRUE,
    #   input = x$code
    # )
  } else {
    # result <- plantuml_run(
    #   plantuml_opt = plantuml_opt,
    #   stdout = fn,
    #   input = x$code
    # )
  }
  return(result)
}
