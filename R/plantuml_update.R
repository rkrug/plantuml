#' Update or download \code{plantuml.jar} binary
#'
#' The file \code{plantuml.jar} is downloaded from Sourceforge and saved as
#' \code{"plantuml.jar"} in the folder \code{system.file("jar", package =
#' "plantuml")} of the package. The source code for \code{plantuml} can be
#' found at \url{https://github.com/plantuml/plantuml}
#' @param tag tag of the version to be downloaded. Allowed values are
#'   - **"release**    : the last release
#'   - **"snapshot"**  : the last snapshot - **Not ready for gneral use**
#'
#' @return the path and name of the downloaded file
#'
#' @md
#' @export
#'
#' @importFrom httr2 request req_perform
#' @examples
#' \dontrun{
#' plantuml_update()
#' }
plantuml_update <- function(
  tag = "release"
) {
  url <- ifelse(
    tag == "snapshot",
    "https://github.com/plantuml/plantuml/releases/download/snapshot/plantuml-SNAPSHOT.jar",
    "https://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar"
  )
  ##
  dir.create(
    dirname(getPlantumlOption("jar_name")),
    showWarnings = FALSE,
    recursive = TRUE
  )
  ##

  httr2::request(url) |>
    httr2::req_perform(
      path = getPlantumlOption("jar_name")
    )

  # download.file(
  #   url = url,
  #   destfile = getPlantumlOption("jar_name"),
  #   mode = "wb",
  #   ...
  # )
  invisible(TRUE)
}


#' RENAMED to plantuml_update()!
#'
#' @param ... some parameter
#'
#'
#' @export
updatePlantumlJar <- function(...) {
  warning(
    "The function `updatePlantumlJar()` has been renamed to `plantuml_update()`!\nPlease change in your scripts!"
  )
  plantuml_update(...)
}
