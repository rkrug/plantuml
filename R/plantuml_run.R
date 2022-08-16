#' Run the plantuml binary
#'
#' The in the package installation included `plantuml` binary is executed using
#' the provided java and plantuml commands. This is effectively a wrapper around
#' `system2()` with some values set to run `plantuml`.
#' @param x plantuml code to draw the UML graph
#' @param file file name, including extension, to which the generated plantUML graph
#'   should be saved. The extension determines the format of the graph.
#'   If `NULL', the graph is returned as a ASCII art, i.e. a `character` vector..
#' @param plantuml_jar path and name of the plantuml jar file. The dafault is read from
#'   `getPlantumlOption("plantuml_jar")`.
#' @param plantuml_opt options for the call of `java`. The default is
#'   read from `getPlantumlOption("plantuml_opt")`.
#' @param java_bin path to the `java` binary. The dafault is read from
#'   `getPlantumlOption("java_bin")`.
#' @param java_opt options for the call of `java`. The default is
#'   read from `getPlantumlOption("java_opt")`.

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
  x = NULL,
  file = "",
  plantuml_jar = getPlantumlOption("jar_name"),
  plantuml_opt = getPlantumlOption("plantuml_opt"),
  java_bin = getPlantumlOption("java_bin"),
  java_opt = getPlantumlOption("java_opt")
){

  # Checks ------------------------------------------------------------------
  if (!file.exists(plantuml_jar)) {
    message(
      "##############################\n",
      "plantuml.jar file has not been downloaded.\n",
      "Trying to download it by running the command 'plantuml_update()' to download the file...\n",
      "##############################\n"
    )
    plantuml_update()
    message(
      "Done!\n",
      "##############################\n"
    )
  }

  # Run plantuml ------------------------------------------------------------

  if (!is.null(file)) {
    pos <- regexpr("\\.([[:alnum:]]+)$", file)
    type <- ifelse( pos > -1L, substring(file, pos + 1L), "")
  } else {
    stop("Invalid type for PlantUml graph!")
  }
  plantuml_opt = paste0("-p -t",type, " ", plantuml_opt)

  cmd <- paste0(
    "-jar \"",
    plantuml_jar,
    "\""
  )

  result <- system2(
    command = java_bin,
    args = paste(java_opt, cmd, plantuml_opt),
    stdout = file,
    stderr = "",
    stdin = "",
    input = x
  )

  return(result)
}
