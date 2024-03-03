#'
#' @rdname as.plantuml
#' @export
#'
#' @examples
#' \dontrun{
#'  ## \code{factor}
#'  x <- factor(LETTERS)
#'  x <- as.plantuml(x)
#'  plot(x)
#'  }
#'
as.plantuml.factor <- function(
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
