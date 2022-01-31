#' Getter and Setter for options
#'
#' Allow the user to set and examine the parameter used by the package `plantuml`
#' @param x a character string holding an option name.
#' @param default if the specified option is not set in the options list, this
#'   value is returned. This facilitates retrieving an option and checking
#'   whether it is set and setting it separately if not.
#' @param plantuml_opt additional options for plantuml in addition to \code{-p}
#'   and \code{-tFILETYPE}. See `plantuml_run() for a list of available file formats.
#' @param vector if \code{TRUE} use `svg` as intermediate format, if \code{FALSE}
#'   use `png`. Only effects plotting in device.
#'
#' @return - `getPlantumlOption()`: the value of the option
#' - `plantumlOptions()`: the old value of the plantuml options
#'
#' @md
#' @rdname options
#' @export
#'
getPlantumlOption <- function(x, default = NULL){
  if (missing(x)) {
    stop('Error in getPlantumlOption() : argument "x" is missing, with no default')
  } else {
    getOption("plantuml")[[x]]
  }
}


#'
#' @param ... named value to be set in the form of \code{name = value}
#'
#' @rdname options
#' @export
#'
#' @examples
#' getPlantumlOption("jar_name")
#'
#' plantumlOptions(jar_name = "something useless!")
#'
#' getPlantumlOption("jar_name")
#'
plantumlOptions <- function(...){
  oldPlantuml <- getOption("plantuml")
  if (...length() > 0) {
    ###
    plantuml <- oldPlantuml
    name <- names(list(...))
    value <- unlist(list(...))
    for (i in 1:...length()) {
      plantuml[[name[[i]]]] <- value[[i]]
    }
    options(plantuml = plantuml)
    ###
    return(invisible(oldPlantuml))
  }
  return(oldPlantuml)
}

# `colnames<-.default` <- base::`colnames<-`
