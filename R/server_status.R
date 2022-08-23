#' Get the status of the server
#'
#' The parameter (URL and port) as in the `getPlantumlOption()` specified are used.
#' @return `integer` value indicating the status:
#'    - **-999**: undetermined error (should not happen)!
#'    - **-404**: URL not reachable
#'    - **0**  : server reachable but not a known PlantUml Web Server or PicWeb Plantuml Server
#'    - **1**  : server is PicoWeb Server
#'    - **2**  : server is PlantUML Web Server
#' @md
#' @importFrom
#' @export
#'
#' @examples
server_status <- function(
){
  fn <- tempfile()
  response <- -999

  url <- paste0(getPlantumlOption("server_url"), ":", getPlantumlOption("server_port"))
  url <- gsub("/:", ":", url)


# Check if reachable ------------------------------------------------------


  response <- tryCatch(
    {
      suppressWarnings(
        utils::download.file(
          url = url,
          destfile = fn,
          quiet = TRUE
        )
      )
    },
    error = function(err) {
      occur <- grep("cannot open URL", capture.output(err))
      if(length(occur) > 0) -404
    }
  )


  # Check if PlantUML (PicoWeb) Server --------------------------------------


  if ((response != -404)&(response != -999)){
    reply <- readLines(fn, n = 1)

    if (reply == "\x89PNG"){
      response <- 1
    } else if (reply == "<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/>"){
      response <- 2
    } else {
      response <- 0
    }
  }

  names(response) <- url
  return(response)
}
