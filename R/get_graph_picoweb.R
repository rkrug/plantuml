#' Generate PlantUML graph using PicoWeb included in PlantUml jar file
#'
#' @param x object of `plantuml` to draw the UML graph
#' @param file file name, including extension, to which the returned plantUML graph
#'   should be saved.
#'   If `NULL', the graph is saved to a temporary file.
#' @param type type of the generated graph. Only \code{png} and \code{svg} are supported.
#'   Default: \code{svg}.
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
get_graph_picoweb <- function(
  x,
  file = NULL,
  type = NULL,
  quiet = TRUE,
  ...
){
  if (!(type %in% c("svg", "png"))) {
    stop("Unsupported file type for the selected PicoWeb server included in plantuml!\n",
    "Only 'svg' and 'png' are supportd.")
  }

  url <- plantuml_URL(
    plantuml = x,
    type = type
  )

  result <- utils::download.file(
    url,
    file,
    quiet = quiet
  )

  if (result != 0) {
    unlink(file)
    stop("Error in download!")
  }

  return(file)
}
