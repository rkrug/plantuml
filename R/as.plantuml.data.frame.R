#'
#' @rdname as.plantuml
#' @export
#'
#' \dontrun{
#'  x <- data.frame(
#'    id = 1:10,
#'    random = runif(10),
#'    letters = letters[1:10]
#'  )
#'  row.names(x) <- LETTERS[1:10]
#'  x <- as.plantuml(x)
#'  plot(x)
#'  }
#'
as.plantuml.data.frame <- function(
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
  puml$code <- "\n '### ### data.frame ### ### ### \n"
  puml <- addInfo( x = x, nm = nm, puml = puml )
  puml <- addAttributes( x = x, nm = nm, puml = puml )
  #
  for (i in 1:length(x)) {
    nme <- paste0(nm, "_", i, "_", names(x)[i])
    puml$code <- paste(
      puml$code,
      as.plantuml( x = x[[i]], nm = nme )$code, " \n ",
      paste0("\"", nm, "\" *--> \"", nme, "\" \n ")
    )
  }
  if (complete) {
    puml$code <- paste("@startuml \n ", puml$code, " \n @enduml")
  }
  return(puml)
}
