#' @import backports
.onLoad <- function(libname, pkgname) {
  backports::import(pkgname, c("R_user_dir"), force = TRUE)

  setPlantumlOption(
    jar_path = file.path( R_user_dir(package = "plantuml", "cache"), "jar"),
    jar_name = "plantuml.jar",
    java_bin = Sys.which("java"),
    java_opt = "-Djava.awt.headless=true -splash:no"
  )
}

