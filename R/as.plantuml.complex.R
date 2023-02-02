#'
#' @rdname as.plantuml
#' @export
#'
#' @examples
#' \dontrun{
#' #' \dontrun{
#'  x <- 1:2 + 1i*(8:9)
#'  x <- as.plantuml(x)
#'  plot(x)
#'  }
#'
as.plantuml.complex <- function(
  x,
  complete = FALSE,
  nm = NULL,
  ...
) {
  return(
    as.plantuml.vma(
      x = x,
      complete = complete,
      nm = nm
    )
  )
}
