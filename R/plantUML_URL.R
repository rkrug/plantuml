## Functions based on https://plantuml.com/code-javascript-synchronous and https://plantuml.com/code-php.
## Also see https://forum.plantuml.net/15331/example-on-how-to-encode-for-plantuml-server

encode64 <- function(
  data
){
  r  <- ""
  #
  for (i in seq(from = 0, to = length(data), by = 3)) {
    if (i+2 == length(data)) {
      r <- paste0(
        r,
        append3bytes(
          as.integer(data[i+1]),
          as.integer(data[i+2]),
          0
        )
      )
    } else if (i+1 == length(data)) {
      r <- paste0(
        r,
        append3bytes(
          as.integer(data[i+1]),
          0,
          0
        )
      )
    } else {
      r <- paste0(
        r,
        append3bytes(
          as.integer(data[i+1]),
          as.integer(data[i+2]),
          as.integer(data[i+3])
        )
      )
    }
  }
  return(r);
}

append3bytes <- function(
  b1,
  b2,
  b3
){
  c1 <-  bitwShiftR( a = b1, n = 2)
  c2 <-  bitwOr(
    bitwShiftL( a = bitwAnd(b1, 0x3), n = 4),
    bitwShiftR( a = b2, n = 4)
  )
  c3 <-  bitwOr(
    bitwShiftL( a = bitwAnd(b2, 0xF), n = 2),
    bitwShiftR( a = b3, n = 6)
  )
  c4 <-  bitwAnd(b3, 0x3F)
  #
  txt  <-  ""
  txt <- paste0(txt, encode6bit(bitwAnd(c1, 0x3F)))
  txt <- paste0(txt, encode6bit(bitwAnd(c2, 0x3F)))
  txt <- paste0(txt, encode6bit(bitwAnd(c3, 0x3F)))
  txt <- paste0(txt, encode6bit(bitwAnd(c4, 0x3F)))
  #
  return(txt)
}

encode6bit <- function(
  int
){
  if (int < 10) {
    return(intToUtf8(48 + int))
  }
  int  <- int - 10
  #
  if (int < 26) {
    return( intToUtf8(65 + int))
  }
  int  <- int - 26
  #
  if (int < 26) {
    return(intToUtf8(97 + int))
  }
  int  <- int - 26
  #
  if (int == 0) {
    return("-")
  }
  #
  if (int == 1) {
    return("_")
  }
  return("?")

}

#' Generate PlantUML Server URL
#'
#' @param plantuml The plantuml code
#' @param server_url The base url of the server. Should end with a single `/`
#' @param server_port port on which the plantuml server is
#' @param type the type of the returned figure. At the moment supported:
#'   `png`, `svg` `txt`, or `map`. See [https://plantuml.com/server](https://plantuml.com/server) for further details.
#' @param open_in_browser if TRUE, the result will be opened in the browser.
#'
#' @return complete url to retrieve the graph.
#' @md
#'
#' @importFrom utils browseURL
#' @export
#'
#' @examples
#'
plantuml_URL <- function(
  plantuml = "@startuml\nBob -> Alice : hello\n@enduml",
  server_url = getPlantumlOption("server_url"),
  server_port = getPlantumlOption("server_port"),
  type = "svg",
  open_in_browser = FALSE
){
  server_url <- gsub("/$", "", server_url)
  server_url <- paste0(server_url, ":", server_port, "/")

  server_url <- paste0(server_url, type, "/")

  comp <- memCompress(charToRaw(plantuml), "gzip")
  enc <- paste0("~1", encode64(comp))
  #
  url <- paste0(server_url, enc)
  #
  if (open_in_browser){
    utils::browseURL(url)
  }

  return(url)
}