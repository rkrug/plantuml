#' Set parameter of the plantuml server addrss to the default valus
#'
#' @param location alloeed values are:
#'   - "remote": default values for the remote server
#'   - "local": default values for a local picoweb server. The serer still needs to be started!
#'   Other locations need to be set manually by setting the options directly.
#' @return invisibly the old values of plantuml options
#' @export
#' @md
#'
#' @examples
server_set <- function(
    location = "remote"
){
  if (location == "local") {
    old_server <- plantumlOptions(server_url = "http://localhost/")
    plantumlOptions(server_port = 8765)
  } else if (location == "remote") {
    old_server <- plantumlOptions(server_url = "http://www.plantuml.com/plantuml/")
    plantumlOptions(server_port = NULL)
  } else {
    stop("Non defined value for `", location, "`!")
  }

  invisible(old_server)
}
