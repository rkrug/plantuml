#' Knit engine for plantuml
#'
#' This function provides a knit engine for the plantuml. It has the following additional functions:
#'  - **plantuml.format**: the format of the generated image.
#'    For formats which return images, these will be inserted,
#'    formats resulting in text qill be included as text.
#'    At the moment, the following are supported:
#'      - **auto** (default) uses `svg` if output is `html` and `pdf` if output is `pdf`
#'      - **png**	 To generate image using PNG format (default).
#'      - **svg**	 To generate image using SVG format.
#'      - **eps**	 To generate text in EPS format; or generates an image when
#'      outputting LaTeX rather than HTML formats.
#'  - **plantuml.path**: the path where the resulting files will be saved.
#'    Default is the same directory as the `.Rmd` file is in in a directory named
#'  ` plantuml. The path will be created if it does not exist. The name of each
#'    plantuml figure is the label of thre chunk with the extension as specified.
#'  - **plantuml.preview**: if `TRUE`, an inline preview will be shown in RStudio.
#'    **Attention: the processing takse twice as long as without this option!**.
#'
#' Thanks to Emiliano Heyns (retorquere) for giving me the idea for this
#' functiion https://github.com/rkrug/plantuml/issues/10#issue-639795529
#' See \code{knit_engines} in the knitr packages for details
#' @param options knitr options see \code{knitr}
#'
#' @md
#' @return See \code{knit_engines} in the knitr packages for details
#' @export
#'
#' @examples
#' \dontrun{
#' ## see
#' system.file("plantuml.Rmd", package = "plantuml")
#' ## for an example RMarkdown file usint this knit engine.
#' }
plantuml_knit_engine <-  function(options) {
  if (system.file(package = "knitr") == "") {
    stop ("This function need the package `knitr` to be installed!")
  }


  # Options -----------------------------------------------------------------


  ## plantuml.path -----------------------------------------------------------


  if (is.null(options$plantuml.path)) {
    options$plantuml.path <- file.path(".", "plantuml_figures")
  } else {
    options$plantuml.path <- options$plantuml.path
  }

  ## plantuml.format ---------------------------------------------------------


  if (!(options$plantuml.format %in% c("png", "svg", "pdf", "png", "txt", "ps", "auto"))){
    stop(
      "The option 'plantuml.format = ", options$plantuml.format, "' is not supported!\n",
      "see 'getPlantumlOption('supported_formats')' for a list of supported options."
    )
  }

  if (is.null(options$plantuml.format)) {
    options$plantuml.format <-  "auto"
  }

  if (options$plantuml.format == "auto"){
    options$plantuml.format <- ifelse(
      knitr::is_html_output(),
      "svg",
      "pdf"
    )
  } else if (is.null(options$plantuml.format)){
    options$plantuml.format <- "png"
  }


# Determine Result --------------------------------------------------------


  result <- list(out = "", code = "")

  if (options$eval) {

    puml <- paste0(options$code, collapse = "\n")
    ###

    fig <- file.path(
      options$plantuml.path,
      paste0(knitr::opts_current$get("label"), ".", options$plantuml.format)
    )


    ###
    get_graph(
      x = puml,
      file = fig
    )

    ###

    if (options$plantuml.format %in% c("svg", "png", "pdf")) {
      out <- list(knitr::include_graphics(fig))
    } else {
      out <- list(readLines(fig))
    }

    ###

    result$out <- knitr::engine_output(
      options = options,
      out = out
    )

    ###

    if (isTRUE(options$plantuml.preview)) {
      plot(
        x = plantuml(puml)
      )
    }

  }

  if (options$echo) {
    result$code <- knitr::engine_output(
      options = options,
      code = options$code,
      out = NULL
    )
  }

  return(paste(result$code, result$out, sep = "\n\n"))
}
