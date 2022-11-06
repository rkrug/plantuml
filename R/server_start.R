#' Start a PlantUML Picoweb Server on localhost
#'
#' If the port `getPlantumlOption("server_port")` on localhostis is available,
#' i.e. no other server is running on that port, a PantUML PicoWeb Server is started.
#' The return value indicates if a server was started and if not, why.
#' @return `integer` or `list()` as returned from `server_status()`
#'    - **-999**: unknown error
#'    -  **1**  : unknown server running on the port on localhost
#'    - **2**   : PlantUML Web Server running on that port on localhost
#'    - **`server_info()`** ehen PicoWeb Server already running or started
#' @export
#' @md
#'
#' @examples
server_start <- function(
){

  if (plantumlOptions()$server_url != "http://localhost/") {
    stop("Server needs to be set to localhost by running `server_set(\"local\"!)`")
  }
  plantumlOptions(server_port = "8765")
  result <- -999

  # Checks ------------------------------------------------------------------


  status <- server_status()
  if (status == 0) {
    warning("There is an unknown server running on port ", getPlantumlOption("server_port"), "!")
    result <- 1
  }
  if (status == 1) {
    warning("There is already a PicoWeb Server running on port ", getPlantumlOption("server_port"), "!")
    result <- 1
  }
  if (status == 2) {
    stop("There is a PlantUML Web Server running on port ", getPlantumlOption("server_port"), "!")
    result <- 2
  }

  if (result == -999){

    # Starting PicoWeb Server -------------------------------------------------

    plantuml_run(
      x = NULL,
      plantuml_opt = paste0("-picowebstop:", getPlantumlOption("server_port"), ":localhost")
    )
    result <- 1
  }

  if (result > 0){
    Sys.sleep(1)
    result <- server_info()
  }

  return(result)
}
