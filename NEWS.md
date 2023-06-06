# plantuml 0.6.10

- added handling of not installed java

# plantuml 0.6.9

- added support for quarto

# plantuml 0.6.8.1

- Changes in documentation
- usage of "_" instead of "." when converting lists and data.frames to plantuml code.

# plantuml 0.6.8

- if file is specified in `plot()` or `get_graph()` the directory is created, if it does not exist.

# plantuml 0.6.7

- add functionality to plot yml, jsonlite files including values and
functionality to read csv and rds files to plot structure of contained objects. The functionality can be used via the function `plantuml_file(file, ...)`
- added function `diff_yaml_json()` to highlight the differences in the values in yaml or json files.
  The implementation is rudimental and could be improved and made more stable.

# plantuml 0.6.6

- re-enabled plotting ad server control
- set `plantuml.format` for knitting to `auto` as default (solves Issue #16)

# plantuml 0.6.5

Apologies for a disastrous last release!

- The default is now to use the plantuml web server.
- A local server can be started and stopped from within R
- `svg` is the format for the graph returned from plantuml and the svg is converted to the other
  graphic formats (png, pdf, ps)
- an ASCII art can be produced using `txt`

# plantuml 0.6

Major re-factoring and change of functionality
This release uses the local in plantuml integrated PicoWeb server to generate the graph. All graphs are generated as svg files and converted to the target format. This change makes the structure much easier.

Some other follow up changes which I unfortunately do not remember were also included.

# plantuml 0.5 dev branch

## Major and Breaking changes

- included a function to generate the graph on a plantuml server, i.e. independant of a local installation.
- use Smetana instead of `dot` (see [here for details](http://plantuml.io/smetana02))
- default vector format as `svg` instead of `eps`
- Bump R dependency to >= 4.0

## New Features

- added plantuml.format "auto" to knit engine With "auto" the format is changed deepending on the output format. If the output format is html, it is "svg", otherwise "pdf". Tested for pfdf, html and doc.

## other Changes

- added knit engine registration into .onAttach() so it does not need to be called explicitely.

# plantuml 0.3.5

## Major and Breaking changes

- renamed updatePlantumlJar() to update_plantuml()!!!

## Other changes

- move jar location to R_usr_dir() so that it will not cause problems during testing or on machines withn limited access. The jar will "survive" a new installation of the package.
- add options to plantuml to make the finding oj java and the plantuml jar easier

# plantuml 0.3.4

- replace preview with png preview, as eps caused problems (see <https://github.com/rkrug/plantuml/issues/17>) - thanks @retorquere

# plantuml 0.3.3

- added `plantuml.preview` option to kitr engine which will show a preview in RStudio

# plantuml 0.3.2

- Adds `mode = "wd"` to the download of `plantuml.jar` to avoid corruption on windows

# plantuml 0.3.1

- added function to register knit engine `plantuml_knit_engine_register()`
- fixed wrong behaviour when `echo = TRUE` and `eval = TRUE`

# plantuml 0.3

- added knit engine so that PlantUML code can be directly knitted in a RMarkdown document

# plantuml 0.2.7

- `plantuml_run()`: new function to run plantuml without the need for using system calls
- `plot.plantuml()`: added the possibility to return the graph as a return value when file == "" and replaced calls   to `system2()` with `plantuml_run()`
- added tests to `plot.plantuml()`

# plantuml 0.2.6

## Bug Fix

- #9 <https://github.com/rkrug/plantuml/issues/9> path to jar not enclosed in inverted commes, therefore problems when path to jar contains spaces. Thanks at @jstrin for reporting.

# plantuml 0.2.5

## Bug fix

* remove leading and trailing whitespace

# plantuml 0.2.3.1

## Change in default behaviour

* added "-Djava.awt.headless=true -splash:no" as default java_opt to keep java quiet  
  Sebastyian Sauer reported <https://github.com/rkrug/plantuml/issues/8> which was caused by a trailing linebreak. Seems to be a probl;em in plantuml, but fixed here.
  
## Minor changes

* add argumwent *beta* to function plantuml_update() to enable download from beta versions
- added check if plantuml.jar has been downloaded - will download it automatically when not downloaded

## Diverse

* add GPL 3 License
- add DOI to Readme

# plantuml 0.2.3

* quote names of objects to avoid errors with non-text-characters

# plantuml 0.2.2.3

* add java_opt argument to plot.plantuml() to allow additional java arguments. Thanks samssann in <https://github.com/rkrug/plantuml/issues/1>
- add factor support
- Fix wrong itteration through attributes which resulted in only the first attribute being shown
- Fixes in Documentation

- CHANGES:
- Generate class diagram instead of object diagram - nicer to see tattriburtes and contains.

# plantuml 0.2.2.1

version bump

# plantuml 0.2.2.1

* fixed error when object has more than one class

# plantuml 0.2.2.1

* add BasicUsage vignette
- fix du=ocumentation errors

# plantuml 0.2.2

* fix wrong version

# plantuml 0.2.1

* revert back to using `.eps` as intermediate format instead odf `.svg`
- Added asp = 1 to `plot::plantuml()` to always plot the `.eps` in the correct ratio.

# plantuml 0.2.0

- Added a `NEWS.md` file to track changes to the package.

- Added vector format as intermediate format for plotting to device, used as defasult now.
