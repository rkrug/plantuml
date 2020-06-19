#' Update or download \code{plantuml.jar} binary
#'
#' The file \code{plantuml.jar} is downloaded from Sourceforge and saved as
#' \code{"plantuml.jar"} in the folder \code{system.file("jar", package =
#' "plantuml")} of the package.
#' @param beta should the beta version be downloaded, default \code{FALSE}
#' @param ... additional arguments for the \code{download.file()} function
#'
#' @return the result from the \code{download.file()}
#' @export
#'
#' @importFrom utils download.file
#' @examples
#' \dontrun{
#' updatePlantumlJar()
#' }
updatePlantumlJar <- function(
  beta = FALSE,
  ...
) {
  url <- ifelse(
    beta,
    "http://beta.plantuml.net/plantuml.jar",
    "https://sourceforge.net/projects/plantuml/files/latest/download"
  )
  ##
  download.file(
    url = url,
    destfile = file.path(
      system.file("jar", package = "plantuml"),
      "plantuml.jar"
    ),
    mode = "wb",
    ...
  )
}
