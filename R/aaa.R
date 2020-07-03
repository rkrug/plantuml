#' @import backports
#' @importFrom utils getFromNamespace

.onLoad <- function(libname, pkgname) {
  backports::import(pkgname, c("R_user_dir"), force = TRUE)
}
.onAttach <- function(libname, pkgname) {

  setPlantumlOption(
    jar_path = file.path( tools::R_user_dir(package = "plantuml", "cache"), "jar"),
    jar_name = "plantuml.jar",
    java_bin = Sys.which("java"),
    java_opt = "-Djava.awt.headless=true -splash:no"
  )
}
