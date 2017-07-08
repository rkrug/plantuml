#' Convert a character to a \code{plantuml} object
#'
#' Convert a \code{character} to a \code{plantuml} object.
#' This can be plotted.
#'
#' @param x character sting containing plantuml code.
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
  nm = NULL
  ) {
  puml <- plantuml()
  #
  if (is.null(nm)) {
    nm <- deparse(substitute(x))
  }
  #
  puml$code <-  paste0(
      "object ", nm,
      " \n ",
      nm, " : class  = ", class(x), " \n ",
      nm, " : length = ", length(x), " \n "
    )
  if (is.array(x)) {
    puml$code <- paste0(
      puml$code,
      nm, " : dim      = ", paste(dim(x), collapse = " "), " \n ",
      nm, " : dimnames = ", paste(dimnames(x), collapse = " "), " \n "
    )
  }
  #
  if (complete) {
    puml$code <- paste("@startuml \n ", puml$code, " \n @enduml")
  }
  #
  return(puml)
}
