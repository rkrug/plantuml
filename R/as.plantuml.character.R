#'
#' @rdname as.plantuml
#' @export
#'
#' @examples
#' \dontrun{
#'  x <- LETTERS
#'  x <- as.plantuml(x)
#'  plot(x)
#'  }
#'
as.plantuml.character <- function(
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
