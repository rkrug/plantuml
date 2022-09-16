#' Update or download \code{plantuml.jar} binary
#'
#' The file \code{plantuml.jar} is downloaded from Sourceforge and saved as
#' \code{"plantuml.jar"} in the folder \code{system.file("jar", package =
#' "plantuml")} of the package. The source code for \code{plantuml} can be
#' found at \url{https://github.com/plantuml/plantuml}
#' @param tag tag of the version to be downloaded. Allowed values are
#'   - **"release**    : the last release
#'   - **"snapshot"**  : the last snapshot - **Not ready for gneral use**
#' @param ... additional arguments for the \code{download.file()} function
#'
#' @return the path and name of the downloaded file
#'
#' @md
#' @export
#'
#' @importFrom utils download.file
#' @examples
#' \dontrun{
#' plantuml_update()
#' }
plantuml_update <- function(
  tag = "release",
  ...
) {
  url <- ifelse(
    beta,
    "http://beta.plantuml.net/plantuml.jar",
    "https://sourceforge.net/projects/plantuml/files/latest/download"
  )
  ##
  dir.create(
    dirname(getPlantumlOption("jar_name")),
    showWarnings = FALSE,
    recursive = TRUE
  )
  ##
  download.file(
    url = url,
    destfile = getPlantumlOption("jar_name"),
    mode = "wb",
    ...
  )
  invisible(TRUE)
}


#' RENAMED to plantuml_update()!
#'
#' @param ... some parameter
#'
#'
#' @export
updatePlantumlJar <- function(...) {
  warning("The function `updatePlantumlJar()` has been renamed to `plantuml_update()`!\nPlease change in your scripts!")
  plantuml_update(...)
}
