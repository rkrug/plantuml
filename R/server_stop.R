#' Stop a PlantUML Picoweb Server running on localhost
#'
#' The server is expscted at the port `getPlantumlOption("server_port")` on localhost.
#' @return `integer` or `list()` as returned from `server_status()`
#'    - **-999**: unknown error
#'    - **-1**  : unknown server running on the port on localhost
#'    - **-2**  : PlantUML Web Server running on that port on localhost
#'    - **0**   : PicoWeb Server in the process of stopping or no server running on tat port
#'
#' @md
#' @export
#'
#' @examples
server_stop <- function(){

  result <- -999
  fn <- tempfile(pattern = "serverinfo_", fileext = ".json")

  on.exit(
    {
      unlink(fn)
    }
  )

  # Checks ------------------------------------------------------------------


  status <- server_status()
  if (status == -404) {
    warning("No server running on port ", getPlantumlOption("server_port"), "!")
    result <- 0
  }
  if (status == 0) {
    warning(
      "There is an unknown server running on port ", getPlantumlOption("server_port"), "!",
      "Can not stop this Server!"
    )
    result <- -1
  }
  if (status == 1) {
    result <- 1
  }
  if (status == -2) {
    stop(
      "There is a PlantUML Web Server running on port ", getPlantumlOption("server_port"), "!",
      "Can not stop this Server!"
    )
    result <- 2
  }

  if (result == 1){

    # Stopping PicoWeb Server -------------------------------------------------

    try(
      {
        result <- utils::download.file(
          url = paste0(paste0("http://localhost:", getPlantumlOption("server_port")), "/stopserver"),
          destfile = fn,
          quiet = TRUE
        )
      }
    )
    if (result == 0){
      if (readLines(fn, n = 1) != "<html>Stoping...</html>"){
        warning("Could not stop PicoreWeb Server on ", getPlantumlOption("server_port"), "!")
        result <- -999
      }
    }
  }

  return(result)
}
