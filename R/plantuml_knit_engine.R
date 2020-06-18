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
  if (options$eval) {
    #
    puml <- plantuml(options$code)
    ###

    if ( is.null(options$plantuml.format) ) {
      fig_type <- "png"
      fig_opt <- "-tpng"
      output_type <- "image"
      fig <- paste0(options$label, ".", "png")
    } else {
      switch(
        options$plantuml.format,
        "png" = {
          fig_type <- "png"
          fig_opt <- "-tpng"
          output_type <- "image"
          fig <- paste0(options$label, ".", fig_type)
        },
        "svg" = {
          fig_type <- "svg"
          fig_opt <- "-tsvg"
          output_type <- "image"
          fig <- paste0(options$label, ".", fig_type)
        },
        "eps" = {
          fig_type <- "eps"
          fig_opt <- "-teps"
          output_type <- "text"
          fig <- paste0(options$label, ".", fig_type)
        },
        stop("Unsupported `plantuml.format`!")
      )
    }

    ###
    tmp_fig <- tempfile(fileext = fig_type)
    dir.create(path, showWarnings = FALSE, recursive = TRUE)
    fig <- file.path(path, fig)
    ###
    plot(
      x = puml,
      file = fig,
      plantuml_opt = fig_opt
    )
    file.copy( tmp_fig, fig )
    if (output_type == "image") {
      out <- list(knitr::include_graphics(fig))
    } else {
      out <- list(readLines(fig))
    }
    ###
    knitr::engine_output(
      options = options,
      out = out,
      # code = options$code
    )
  } else {
    out <- NULL
    knitr::engine_output(
      options = options,
      code = options$code,
      out = out
    )
  }
}
