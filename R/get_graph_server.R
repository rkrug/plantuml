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
  vector = TRUE,
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

  if ( is.null(file) ) {
    if (vector) {
      file <- tempfile( fileext = ".svg")
    } else {
      file <- tempfile( fileext = ".png")
    }
  }

  pos <- regexpr("\\.([[:alnum:]]+)$", file)
  type <- ifelse( pos > -1L, substring(file, pos + 1L), "")

  if (!(type %in% c("svg", "png", "txt"))) {
    stop(
      "Type ", type, " not supported buy plantUML server!",
    )
    result <- get_graph_local(
      x = x,
      file = file,
      vector = vector,
      ...
    )
  }

  url <- plantuml_URL(
    plantuml = x,
    type = type
  )

  result <- utils::download.file(url, file)
  if (result != 0) {
    unlink(file)
    stop("Error in download!")
  } else {
    result <- file
  }

  return(result)
}
