#' Convert a character to a \code{plantuml} object
#'
#' Convert a \code{character} to a \code{plantuml} object. This can be plotted.
#'
#' @param x plantuml code as a character string.
#'
#' @return object of class \code{plantuml} which can be plotted.
#' @export
#'
#' @examples
#' x <- '
#'  @startuml
#'   --> "First Activity"
#'  -->[You can put also labels] "Second Activity"
#'  -->
#'  @enduml
#' '
#' x <- as.plantuml( x )
#' plot( x )
as.plantuml <- function(
  x
  ) {
  x <- list(
    code = x
  )
  attr(x, "class") <- "plantuml"
  return(x)
}
