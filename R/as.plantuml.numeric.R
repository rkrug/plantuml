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
as.plantuml.numeric <- function(
  x,
  complete = FALSE,
  nm = NULL
) {
  return(
    as.plantuml.vma(
      x = x,
      complete = complete,
      nm = nm
    )
  )
}
