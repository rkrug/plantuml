#' Knit engine for plantuml
#'
#' This function provides a knit engine for the plantuml. It has the following additional functions:
#'  - **plantuml.format**: the format of the generated image.
#'    For formats which return images, these will be inserted,
#'    formats resulting in text qill be included as text.
#'    At the moment, the following are supported:
#'      - **png**	To generate image using PNG format (default).
#'      - **svg**	To generate image using SVG format.
#'      - **eps**	To generate text in EPS format.
#'  - **plantuml.path**: the path where the resulting files will be saved.
#'    Default is the same directory as the `.Rmd` file is in. The path will be created if it does not exist.
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
  ##
  if (is.null(options$plantuml.path)) {
    path <-  "."
  } else {
    path <- options$plantuml.path
  }
  ###
  result <- list(out = "", code = "")
  if (options$eval) {
    #
    puml <- paste0(options$code, collapse = "\n")
    ###

    if (options$plantuml.format == "auto"){
      options$plantuml.format <- ifelse(
        knitr::is_html_output(),
        "svg",
        "pdf"
      )
    }

    if (!(options$plantuml.format %in% getPlantumlOption("supported_formats"))){
      stop(
        "The option 'plantuml.format = ", options$plantuml.format, "' is not supported!\n",
        "see 'getPlantumlOption('supported_formats')' for a list of supported options."
      )
    }
    if (is.null(options$plantuml.format)){
      options$plantuml.format <- "png"
    }
    fig <- paste0(options$label, ".", options$plantuml.format)

    ###
    fig <- file.path(tempdir(), fig)
    ###
    get_graph(
      x = puml,
      file = fig
    )

    # file.copy( tmp_fig, fig )
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
