FROM rocker/r-ver:4.3.1


## RUN DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:cran/imagemagick

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libgit2-dev \
    default-libmysqlclient-dev \
    libpq-dev \
    libsasl2-dev \
    libsqlite3-dev \
    libssh2-1-dev \
    libxtst6 \
    libcurl4-openssl-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    unixodbc-dev \
    librsvg2-dev \
    default-jre \
    libmagick++-dev \
    \
    mc 

## CRAN Packages

RUN install2.r -n 10 -r https://cloud.r-project.org/ --error \
    --deps TRUE \
    tidyverse \
    devtools \
    rmarkdown \
    BiocManager \
    vroom \
    gert \
    httpgd \
    vscDebugger \
    languageserver \
    here

## dplyr database backends
RUN install2.r --error --skipmissing --skipinstalled -n "$NCPUS" \
    arrow \
    dbplyr \
    DBI \
    dtplyr \
    duckdb \
    nycflights13 \
    Lahman \
    RMariaDB \
    RPostgres \
    RSQLite \
    fst

# Clean up
RUN rm -rf /var/lib/apt/lists/* & \
    rm -rf /tmp/downloaded_packages

# ## Bioconductor packages

# RUN R -e "install.packages('BiocManager')" 

# RUN R -e 'BiocManager::install("cytolib")'
# RUN  R -e 'BiocManager::install("flowCore")'  


# RUN mkdir -p /home/rstudio/LEEF/tools \
#     && mkdir -p /home/rstudio/LEEF/0.raw.data \
#     && mkdir -p /home/rstudio/LEEF/1.pre-processed.data \ 
#     && mkdir -p /home/rstudio/LEEF/2.extracted.data \ 
#     && mkdir -p /home/rstudio/LEEF/3.archived.data \ 
#     && mkdir -p /home/rstudio/LEEF/9.backend \
#     \
#     && cd /home/rstudio/LEEF/tools \
#     \
#     && wget --no-verbose http://downloads.openmicroscopy.org/latest/bio-formats5.6/artifacts/bftools.zip \
#     && unzip ./bftools.zip \
#     && rm ./bftools.zip \  
#     \
#     && wget --no-verbose https://downloads.imagej.net/fiji/archive/20191027-2045/fiji-linux64.zip \
#     && unzip ./fiji-linux64.zip \
#     && rm ./fiji-linux64.zip \
#     \
#     && wget --no-verbose https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz \
#     && tar -xf ffmpeg-release-amd64-static.tar.xz --wildcards --strip=1 */ffmpeg \
#     && rm ./ffmpeg-release-amd64-static.tar.xz \
#     \
#     && wget --no-verbose https://github.com/LEEF-UZH/LEEF.measurement.bemovi/raw/LEEF-2/inst/ParticleLinker/ParticleLinker.jar




