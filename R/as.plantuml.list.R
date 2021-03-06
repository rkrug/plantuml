#' Convert a list to a \code{plantuml} object
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
#'  x <- as.plantuml( x )
#'  plot( x ) }
#'
as.plantuml.list <- function(
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
  puml$code <-  "\n '### ### list ### ### ### \n"
  puml <- addInfo( x = x, nm = nm, puml = puml )
  puml <- addAttributes( x = x, nm = nm, puml = puml )
  #
  for (i in 1:length(x)) {
    nme <- paste0(nm, ".", i, ".", names(x)[i])
    puml$code <- paste(
      puml$code,
      as.plantuml(
        x = x[[i]],
        nm = nme
        )$code,
      " \n ",
      paste0("\"", nm, "\" *--> \"", nme, "\" \n ")
    )
  }
  if (complete) {
    puml$code <- paste("@startuml \n ", puml$code, " \n @enduml")
  }
  return(puml)
}
