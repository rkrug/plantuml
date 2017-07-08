#' Convert an R object to a Class uml object
#'
#' Generic function to convert an R object to a \code{plantuml} Class object. This can
#' be plotted.
#'
#' @param x R object to be converted
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
#' x <- as.plantuml( x )
#' plot( x ) }
#'
as.plantuml <- function(x, ...) {
  UseMethod("as.plantuml", x)
}

