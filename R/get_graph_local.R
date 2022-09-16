#' Generate PlantUML graph using PlantUml jar file
#'
#' @param x plantuml code to draw the UML graph
#' @param file file name, including extension, to which the returned plantUML graph
#'   should be saved.
#'   If `NULL', the graph is saved to a temporary file.
#'
#' @return name of the file with the graph
#' @md
#' @export
#'
#' @examples
get_graph_local <- function(
  x,
  file = NULL
){
  stop("Needs Work!!!!!")
  result <- plantuml_run(
    x = x,
    file = file
  )

  if (result != 0) {
    unlink(file)
    stop("Error in generating graph!")
  }

  return(file)
}
