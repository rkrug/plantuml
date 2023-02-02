#'
#' @rdname as.plantuml
#' @export
#'
#' @examples
#' \dontrun{
#'  x <- 1L:10L
#'  names(x) <- letters[1:10]
#'  x <- as.plantuml(x)
#'  plot(x)
#'  }
#'
as.plantuml.integer <- function(
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
