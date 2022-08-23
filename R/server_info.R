#' Get info about the plantuml server
#'
#' The parameter (URL and port) as in the `getPlantumlOption()` specified are used.
#' @param url URL of the server, including port
#'
#' @return list with the following arguments:
#'    - **server**: type of the server, **PicoWeb Server** or **PlantUML Web Server**
#'    - **supported_formats: supported formats of the server
#' @md
#' @importFrom
#' @export
#'
#' @examples
server_info <- function(
){

  result <- list(
    version = NULL,
    PicoWebServer = NULL,
    formats = NULL
  )

  ss <- server_status()

  if (ss <= 0){
    return(result)
  }

  url <- paste0(getPlantumlOption("server_url"), ":", getPlantumlOption("server_port"), "/serverinfo")
  url <- gsub("/:", ":", url)
  url <- gsub("//serverinfo", "/serverinfo", url)

  try(
    {
      result <- jsonlite::fromJSON(url)
    },
    silent = TRUE
  )


  if (is.null(result$version)) {
    switch(
      ss,
      "1" = result <- list(
        version = NULL,
        PicoWebServer = "PicoWebServer",
        formats = c("png", "svg", "txt")
      ),
      "2" = result <- list(
        version = NULL,
        PicoWebServer = "PlanUMLWebServer",
        formats = c("png", "svg", "txt")
      ),
      stop("Strange error!")
    )
  }
  return(result)
}
