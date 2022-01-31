# plantuml 0.4 dev branch
## Major and Breaking changes
- included a function to generate the graph on a plantuml server, i.e. independant of a local installation. 
- use Smetana instead of `dot` (see [here for details](https://plantuml.io/smetana02))
- default vector format as `svg` instead of `eps`

# plantuml 0.3.5
## Major and Breaking changes
- renamed updatePlantumlJar() to update_plantuml()!!!

## Other changes
- move jar location to R_usr_dir() so that it will not cause problems during testing or on machines withn limited access. The jar will "survive" a new installation of the package.
- add options to plantuml to make the finding oj java and the plantuml jar easier

# plantuml 0.3.4
- replace preview with png preview, as eps caused problems (see https://github.com/rkrug/plantuml/issues/17) - thanks @retorquere

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
- #9 https://github.com/rkrug/plantuml/issues/9 path to jar not enclosed in inverted commes, therefore problems when path to jar contains spaces. Thanks at @jstrin for reporting.

# plantuml 0.2.5

## Bug fix
* remove leading and trailing whitespace


# plantuml 0.2.3.1

## Change in default behaviour
* added "-Djava.awt.headless=true -splash:no" as default java_opt to keep java quiet  
  Sebastyian Sauer reported https://github.com/rkrug/plantuml/issues/8 which was caused by a trailing linebreak. Seems to be a probl;em in plantuml, but fixed here.
  
## Minor changes
* add argumwent *beta* to function plantuml_update() to enable download from beta versions
* added check if plantuml.jar has been downloaded - will download it automatically when not downloaded

## Diverse
* add GPL 3 License
* add DOI to Readme

# plantuml 0.2.3
* quote names of objects to avoid errors with non-text-characters

# plantuml 0.2.2.3
* add java_opt argument to plot.plantuml() to allow additional java arguments. Thanks samssann in https://github.com/rkrug/plantuml/issues/1
* add factor support
* Fix wrong itteration through attributes which resulted in only the first attribute being shown
* Fixes in Documentation

* CHANGES:
* Generate class diagram instead of object diagram - nicer to see tattriburtes and contains.

# plantuml 0.2.2.1
version bump

# plantuml 0.2.2.1
* fixed error when object has more than one class

# plantuml 0.2.2.1
* add BasicUsage vignette
* fix du=ocumentation errors

# plantuml 0.2.2
* fix wrong version

# plantuml 0.2.1
* revert back to using `.eps` as intermediate format instead odf `.svg`
* Added asp = 1 to `plot::plantuml()` to always plot the `.eps` in the correct ratio.

# plantuml 0.2.0

* Added a `NEWS.md` file to track changes to the package.

* Added vector format as intermediate format for plotting to device, used as defasult now.

