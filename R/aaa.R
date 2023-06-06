#' @importFrom tools R_user_dir
#' @importFrom utils str
.onAttach <- function(libname, pkgname) {
  plantumlOptions(
    jar_name = file.path( tools::R_user_dir(package = "plantuml", "cache"), "jar", "plantuml.jar"),
    java_bin = Sys.which("java"),
    java_opt = "-Djava.awt.headless=true -splash:no",
    plantuml_opt = "-Playout=smetana",
    server_url = "http://www.plantuml.com/plantuml/",
    server_port = NULL
  )
  plantuml_knit_engine_register()
  packageStartupMessage(
    "The package is by default using the online plantuml server\n",
    "at http://www.plantuml.com/plantuml/\n",
    "If you want to use a different server or the local plantuml server,\n",
    "please set the addresss and the port by e.g.\n\n",
    "   plantumlOptions(server_url = 'http://localhost/')\n",
    "   plantumlOptions(server_port = '8080')\n\n",
    "If you are using the local plantuml server, you have to start it by\n\n",
    "   server_set(\"local\")\n",
    "   server_start()\n\n",
    "and stop it t the end using\n\n",
    "   stop_server()",
    "   server_set(\"local\")"
  )

  if (getPlantumlOption("java_bin") == "") {
    warning("Java is not installed. Therefore you can only use the online Plantuml server!")
  }
}

