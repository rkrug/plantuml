#'
#' @rdname as.plantuml
#' @export
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
  puml$code <- "\n '### ### default ### ### ### \n"
  puml <- addInfo( x = x, nm = nm, puml = puml )
  puml <- addAttributes( x = x, nm = nm, puml = puml )
  #
  if (complete) {
    puml$code <- paste("@startuml \n ", puml$code, " \n @enduml")
  }
  #
  return(puml)
}
