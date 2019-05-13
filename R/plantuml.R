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
#' x <- '
#' (*) --> "Initialization"
#'
#' if "Some Test" then
#' -->[true] "Some Activity"
#' --> "Another activity"
#' -right-> (*)
#' else
#'   ->[false] "Something else"
#' -->[Ending process] (*)
#' endif
#' '
#' x <- plantuml( x )
#' plot( x )
#' }
#'
plantuml <- function(
  x = NULL
  ) {
  x <- list(
    code = x,
    x = x,
    evaluated = FALSE,
    complete = TRUE
  )
  attr(x, "class") <- "plantuml"
  return(x)
}
