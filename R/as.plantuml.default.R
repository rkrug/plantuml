#' Convert a character to a \code{plantuml} object
#'
#' Convert a \code{character} to a \code{plantuml} object.
#' This can be plotted.
#'
#' @param x character sting containing plantuml code.
#' @param complete if \code{TRUE}, enclose the plantuml statements in \code{"@startuml"} and \code{"@enduml"}
#' @param nm normally not for user - TODO I have to check... embarassing
#' @param ... additional arguments - not used here
#'
#' @return object of class \code{plantuml} which can be plotted.
#' @export
#'
#' @examples
#' \dontrun{
#'  x <- '
#'  @startuml --> "First Activity" -->[You can put also labels] "Second Activity"
#'  -->
#'  @enduml
#'  '
#'  x <- plantuml( x )
#'  plot( x ) }
#'
as.plantuml.default <- function(
  x,
  complete = FALSE,
  nm = NULL,
  ...
) {
  puml <- plantuml()
  #
  if (is.null(nm)) {
    nm <- deparse(substitute(x))
  }
  #
  puml$code <-  paste0(
    "\n '### ### default ### ### ### \n ",
    "object ", nm,
    " \n ",
    nm, " : class  = ", paste( class(x), collapse = "; " ), " \n ",
    nm, " : typeof  = ", typeof(x), " \n ",
    nm, " : mode  = ", mode(x), " \n ",
    nm, " : length = ", length(x), " \n ",
    nm, " : Not Further Supported in plantuml!", " \n "
  )
  #
  if (complete) {
    puml$code <- paste("@startuml \n ", puml$code, " \n @enduml")
  }
  #
  return(puml)
}
