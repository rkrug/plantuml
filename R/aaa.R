#' @import backports
#' @importFrom utils getFromNamespace
.onAttach <- function(libname, pkgname) {
  setPlantumlOption(
    jar_path = file.path( utils::getFromNamespace("R_user_dir", "backports")(package = "plantuml"), "jar"),
    jar_name = "plantuml.jar",
    java_bin = Sys.which("java"),
    java_opt = "-Djava.awt.headless=true -splash:no"
  )
}
