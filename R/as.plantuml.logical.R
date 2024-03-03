#'
#' @rdname as.plantuml
#' @export
#'
#' @examples
#' \dontrun{
#'   ## \code{logical}
#'   x <- c(True, FALSE, TRUE, NA)
#'   x <- as.plantuml(x)
#'   plot(x)
#'  }
#'
as.plantuml.logical <- function(
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
