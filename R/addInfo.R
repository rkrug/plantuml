#' Add info to \code{puml$code}
#'
#' Internal Only
#' @param x the object
#' @param nm the name
#' @param puml the plantuml object
#'
#' @return puml
addInfo <- function(x, nm, puml){
  puml$code <-  paste0(
    puml$code,
    # "object ", nm,
    " \n ",
    "\"", nm, "\" : class  = ", paste( class(x), collapse = "; " ), " \n ",
    "\"", nm, "\" : typeof  = ", typeof(x), " \n ",
    "\"", nm, "\" : mode  = ", mode(x), " \n ",
    "\"", nm, "\" : length = ", length(x), " \n "
  )
  return(puml)
}
