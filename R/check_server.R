#' Check if server is available
#'
#' This function tries to download a file from the server.
#' This is suboptimal - suggestions welcome.
#' @return `TRUE` if server is available, `FALSE` otherwise
#' @md
#' @export
#'
#' @examples
server_available <- function(){
  r <- -99
  suppressWarnings(
    try(
      {
        r <- download.file(
          getPlantumlOption("server_url"),
          tempfile(),
          quiet = TRUE
        )
      },
      silent = TRUE
    )
  )
  return(r == 0)
}

#' Set the method to be used to generate the plantUML graph
#'
#' The plantuml option `method` is set. When called with default values, it
#' will set the method to `server` if the server can be reached, otherwise to `local`
#' @param method Method to be used to generate the plantUML graph
#'   - `auto`: irrespective of the value of `check_server`, the method
#'     is set to `local` if the server is not available
#'     (`server_available() == FALSE`), and to `server`
#'     if it is available (`server_available() == TRUE`)
#' @param check_server If `TRUE`, the server availability is checked
#'   before setting to `server` and if it does not exist, set to `local`
#'
#' @return the new value of `method`
#' @md
#' @export
#'
#' @examples
set_method <- function(
    method = "auto",
    check_server = TRUE
){
  if (!(method %in% c("auto", "local", "server"))){
    stop("Not supported method!")
  }
  if (method == "auto"){
    check_server <- TRUE
  }
  if (check_server){
    method <- switch (
      method,
      auto = ifelse(server_available(), "server", "local"),
      server = "server",
      local = "local"
    )
  }
  plantumlOptions(method = method)
  return(method)
}

