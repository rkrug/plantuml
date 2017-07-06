#' Update or download \code{plantuml.jar} binary
#'
#' The file \code{plantuml.jar} is downloaded from Sourceforge and saved as
#' \code{"plantuml.jar"} in the folder \code{system.file("jar", package =
#' "plantuml")} of the package.
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
updatePlantumlJar <- function(...) {
  download.file(
    url = "https://sourceforge.net/projects/plantuml/files/latest/download",
    destfile = file.path( system.file("jar", package = "plantuml"), "plantuml.jar" ),
    ...
  )
}
