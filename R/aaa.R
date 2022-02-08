#' @import backports
.onLoad <- function(libname, pkgname) {
  backports::import(pkgname, c("R_user_dir"), force = TRUE)
}
.onAttach <- function(libname, pkgname) {
  plantumlOptions(
    jar_name = file.path( R_user_dir(package = "plantuml", "cache"), "jar", "plantuml.jar"),
    java_bin = Sys.which("java"),
    java_opt = "-Djava.awt.headless=true -splash:no",
    plantuml_opt = "-Playout=smetana",
    server_url = "http://www.plantuml.com/plantuml/",
    method = "server",  # "local" "server"
    supported_formats = c("svg", "png", "pdf", "ps", "txt")
  )
}
