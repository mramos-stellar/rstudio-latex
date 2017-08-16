# rstudio-latex
This is a docker including rstudio server and texlive 2016.
This is based on the followings:
+ https://github.com/rocker-org/verse
+ https://github.com/rchurchley/docker-texlive


## usage
+ Install Docker
+ On Terminal, run the follwing command:
```
docker pull mramos-stellar/rstudio-latex
```
+ Make a working directory, for example `~/work`.
+ Then, run the follonwing command:
```
docker run -d -p 8787:8787 -v ~/work:/home/rstudio/work mramos-stellar/rstudio-latex
```
+ On browser, enter `localhost:8787` and log on with username `rstudio` and password: `rstudio`.
