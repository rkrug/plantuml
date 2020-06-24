#' Getter and Setter for options
#'
#' @param name name of the option. if \code{NULL}, all will be returned as a \code{list.}
#'
#' @return - `getPlantumlOption()`: the value of the option
#' - `setPlantumlOption()`: the old value of the plantuml options
#' @md
#' @rdname options
#' @export
#'
getPlantumlOption <- function(name = NULL){
  if (is.null(name)) {
    getOption("plantuml")
  } else {
    getOption("plantuml")[[name]]
  }
}


#'
#' @param ... named value to be set in the form of \code{name = value}
#'
#' @rdname options
#' @export
#'
#' @examples
#' getPlantumlOption("jar_path")
#'
#' setPlantumlOption(jar_path = "something useless!")
#'
#' getPlantumlOption("jar_path")
#'
setPlantumlOption <- function(...){
  oldPlantuml <- getPlantumlOption()
  ###
  plantuml <- oldPlantuml
  name <- names(list(...))
  value <- unlist(list(...))
  for (i in 1:...length()) {
    plantuml[[name[[i]]]] <- value[[i]]
  }
  options(plantuml = plantuml)
  ###
  invisible(oldPlantuml)
}

# `colnames<-.default` <- base::`colnames<-`
