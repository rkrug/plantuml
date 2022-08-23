
#' @importFrom tools R_user_dir
.onAttach <- function(libname, pkgname) {
  plantumlOptions(
    jar_name = file.path( tools::R_user_dir(package = "plantuml", "cache"), "jar", "plantuml.jar"),
    java_bin = Sys.which("java"),
    java_opt = "-Djava.awt.headless=true -splash:no",
    plantuml_opt = "-Playout=smetana",
    server_url = "http://localhost/",
    server_port = 8765
  )
  plantuml_knit_engine_register()
}
