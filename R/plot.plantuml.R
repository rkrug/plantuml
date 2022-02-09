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
#' @param ... additional arguments for the `plot` function and the `plantuml_run` function.
#'
#' @md
#' @return returns file name (including absolute path) of the created graph.
#'
#' @export
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
    width = 1024,
    height = NULL,
    css = NULL,
    ...
){
  result <- get_graph(
    x = x,
    file = file,
  )

  pos <- regexpr("\\.([[:alnum:]]+)$", result)
  type <- ifelse( pos > -1L, substring(result, pos + 1L), "")

  if (type == "svg"){
    bmp <- as.raster(rsvg::rsvg(result, width = width, height = height))
    xrange <- c(0, ncol(bmp))
    yrange <- c(0, nrow(bmp))

    plot(
      xrange,
      yrange,
      type = "n",
      axes = FALSE,
      xlab = "",
      ylab = "",
      asp = 1
    )
    rasterImage(
      bmp,
      xleft   = 0, xright = xrange[[2]],
      ybottom = 0, ytop   = yrange[[2]]
    )
  } else if (type == "png"){
    puml <- png::readPNG(
      result,
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
  } else {
    warning("When 'file' is specified, it needs to be 'svg' or 'png' to be able to be plotted!")
  }
  return(result)
}
