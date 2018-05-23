#' Convert an R object to a Class uml object
#'
#' Generic function to convert an R object to a \code{plantuml} Class object.
#' This can be plotted.
#'
#' @param x R object to be converted
#' @param ... other argunents passed on to generic functions
#'
#' @return object of class \code{plantuml} which can be plotted.
#' @export
#'
#' @examples
#' \dontrun{
#' x <- list(
#'   a = 1:10,
#'   b = letters[1:4],
#'   c = data.frame(
#'     x = 1:10,
#'     y = c(TRUE, FALSE)
#'   )
#' )
#' x <- plantuml(x)
#' plot( x )
#' }
#'
as.plantuml <- function(x, ...) {
  UseMethod("as.plantuml", x)
}
