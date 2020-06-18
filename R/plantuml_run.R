#' Run the plantuml binary
#'
#' The in the package installation included `plantuml` binary is executed using
#' the provided java and plantuml commands.
#' This is effectively a wrapper around `system2()` with some values set to run `plantuml`.
#' @param plantuml_opt options for plantuml. The default is `-help` to show all
#'   options of plantuml
#' @param java_bin path to the `java` binary. The dafaulkt is `java`, i;e; it
#'   assumes that the binary is in the path
#' @param java_opt options for the call of `java`. The default is
#'   `-Djava.awt.headless=true -splash:no` to enable a headless and silent
#'   execution of plantuml
#' @param stdout See `system2()`
#' @param stderr See `system2()`
#' @param stdin See `system2()`
#' @param input See `system2()`
#'
#' @md
#'
#' @return the result from the call to `system2()`
#'
#' @export
#' @examples
#' \dontrun{
#' # This will take some time when you run it
#' # for the first time as it will download \code{plantuml.jar}
#'   plantuml_run()
#' }
plantuml_run <- function(
  plantuml_opt = "-help",
  java_bin = "java",
  java_opt = "-Djava.awt.headless=true -splash:no",
  stdout = "",
  stderr = "",
  stdin = "",
  input = NULL
){

  # Checks ------------------------------------------------------------------

  if (system.file("jar", "plantuml.jar", package = "plantuml") == "") {
    message(
      "##############################\n",
      "plantuml.jar file has not been downloaded.\n",
      "Trying to download it by running the command 'updatePlantumlJar()' to download the file...\n",
      "##############################\n"
    )
    updatePlantumlJar()
    message(
      "Done!\n",
      "##############################\n"
    )
  }

  # Run plantuml ------------------------------------------------------------

  cmd <- paste0(
    "-jar \"",
    system.file("jar", "plantuml.jar", package = "plantuml"),
    "\""
  )
  result <- system2(
    command = java_bin,
    args = paste(java_opt, cmd, plantuml_opt),
    stdout = stdout,
    stderr =stderr,
    stdin = stdin,
    input = input
  )

  return(result)
}
