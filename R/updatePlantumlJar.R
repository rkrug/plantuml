#' Update or download \code{plantuml.jar} binary
#'
#' The file \code{plantuml.jar} is downloaded from Sourceforge and saved as
#' \code{"plantuml.jar"} in the folder \code{system.file("jar", package =
#' "plantuml")} of the package. The source code for \code{plantuml} can be
#' found at \url{https://github.com/plantuml/plantuml}
#' @param beta should the beta version be downloaded, default \code{FALSE}
#' @param agree if TRUE, agree to create a directory into which to download the \code{plantuml.jar} file
#' @param ... additional arguments for the \code{download.file()} function
#'
#' @return the path and name of the downloaded file
#' @export
#'
#' @importFrom utils download.file
#' @examples
#' \dontrun{
#' updatePlantumlJar()
#' }
updatePlantumlJar <- function(
  beta = FALSE,
  agree = NULL,
  ...
) {
  url <- ifelse(
    beta,
    "http://beta.plantuml.net/plantuml.jar",
    "https://sourceforge.net/projects/plantuml/files/latest/download"
  )
  ##
  if (!dir.exists(getPlantumlOption("jar_path"))) {
    if (isTRUE(agree)) {
      dir.create(
        getPlantumlOption("jar_path"),
        showWarnings = FALSE,
        recursive = TRUE
      )
    } else {
      stop(
        "\n",
        "\n",
        "This option will create the folder \"", getPlantumlOption("jar_path"), "\" and download the `plantuml.jar` file.\n",
        "from https://plantuml.com .\n",
        "The source code can be found at https://github.com/plantuml .\n",
        "This is required for the package to work.",
        "\n",
        "Please run the command Running the command\n",
        "   `updatePlantumlJar(agree = TRUE)` \n",
        "to agree to this and download the jar file.",
        "This is requred only once per user.\n",
        "\n",
        "\n"
      )
    }
  }
  ##
  jarfile <- file.path(getPlantumlOption("jar_path"), getPlantumlOption("jar_name"))
  download.file(
    url = url,
    destfile = jarfile,
    mode = "wb",
    ...
  )
  return(jarfile)
}
