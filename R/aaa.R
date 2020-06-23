
.onAttach <- function(libname, pkgname) {

  if ( is.null(getOption("plantuml.jar")) ){
    options( plantuml.jar = path.expand("~/jar/plantuml.jar") )
  }

  if ( is.null(getOption("plantuml.opt")) ){
    options( plantuml.jar = path.expand("-help") )
  }

  if ( is.null(getOption("plantuml.java")) ){
    options( plantuml.jar = Sys.which("java") )
  }

  if ( is.null(getOption("plantuml.java_opt")) ){
    options( plantuml.jar = "-Djava.awt.headless=true -splash:no" )
  }

}
