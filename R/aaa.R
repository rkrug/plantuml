#' @importFrom tools R_user_dir
#' @importFrom utils str
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
  server_start()
  si <- server_info()
  msg <- paste(names(si), ": ", unlist(si), collapse = "\n")
  packageStartupMessage(utils::str(si))
  packageStartupMessage(" You have to stop the server manually by calling `server_stop()` before quitting R!\n")
}

