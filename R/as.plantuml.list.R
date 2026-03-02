#'
#' @rdname as.plantuml
#' @export
#'
#' @examples
#' \dontrun{
#'  ## \code{list}
#'  x <- list(
#'    num = 1:10,
#'    let = letters[1:20]
#'  )
#'  x$list <- list(x, x)
#'  x <- as.plantuml(x)
#'  plot(x)
#'  }
#'
as.plantuml.list <- function(
  x,
  complete = FALSE,
  nm = NULL,
  ...
) {
  puml <- plantuml()
  #
  if (is.null(nm)) {
    nm <- deparse(substitute(x))
  }
  #
  puml$code <-  "\n '### ### list ### ### ### \n"
  puml <- addInfo( x = x, nm = nm, puml = puml )
  puml <- addAttributes( x = x, nm = nm, puml = puml )
  #
  for (i in 1:length(x)) {
    nme <- paste0(nm, "_", i, "_", names(x)[i])
    puml$code <- paste(
      puml$code,
      as.plantuml(
        x = x[[i]],
        nm = nme
        )$code,
      " \n ",
      paste0("\"", nm, "\" *--> \"", nme, "\" \n ")
    )
  }
  if (complete) {
    puml$code <- paste("@startuml \n ", puml$code, " \n @enduml")
  }
  return(puml)
}
