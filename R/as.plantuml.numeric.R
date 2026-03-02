#'
#' @rdname as.plantuml
#' @export
#'
#' @examples
#' \dontrun{
#'  ## \code{numeric}
#'  x <- 1/(-10:10)
#'  x <- as.plantuml(x)
#'  plot(x)
#'
#'  x <- matrix(1:21, nrow = 7, ncol = 3)
#'  x <- as.plantuml(x)
#'  plot(x)
#'  }
#'
as.plantuml.numeric <- function(
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
