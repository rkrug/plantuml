#' Add attributes to \code{puml$code}
#'
#' Internal Only
#' @param x the object
#' @param nm the name
#' @param puml the plantuml object
#'
#' @return puml
addAttributes <- function(x, nm, puml){
  if (!is.null(attributes(x))) {
    puml$code <- paste0(
      puml$code, " \n ",
      "\"", nm, "\" : __attributes__",
      " \n "
    )
    for (i in 1:length(attributes(x))) {
      if (names(attributes(x))[i] != "class") {
        attrval <- paste0(attributes(x)[[i]], collapse = " ")
        attrval <- gsub("[\r\n]", "", attrval)
        puml$code <- paste0(
          puml$code, " \n ",
          "\"", nm, "\" : .", names(attributes(x))[i], " = ", attrval,
          " \n "
        )
      }
    }
  }
  return(puml)
}
