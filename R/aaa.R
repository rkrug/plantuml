
#' @importFrom tools R_user_dir
.onAttach <- function(libname, pkgname) {
  plantumlOptions(
    jar_name = file.path( tools::R_user_dir(package = "plantuml", "cache"), "jar", "plantuml.jar"),
    java_bin = Sys.which("java"),
    java_opt = "-Djava.awt.headless=true -splash:no",
    plantuml_opt = "-Playout=smetana",
    server_url = "http://www.plantuml.com/plantuml/",
    method = "server",  # "local" "server"
    supported_formats = c("svg", "png", "pdf", "ps", "txt")
  )
  plantuml_knit_engine_register()
}
