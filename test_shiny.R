setwd("C:/Users/icepi/Documents/GitHub/test_shiny_app")
library(shiny)

runApp("app1")
#install.packages(c("shinylive", "httpuv"))

r1 = raster("./app1/data/r1.tif")
r2 = raster("./app1/data/r2.tif")

r1_df = as.data.frame(r1, xy=TRUE)
r2_df = as.data.frame(r2, xy=TRUE)
colnames(r1_df)[3] = "z"
colnames(r2_df)[3] = "z"


rasters = list(r1_df, r2_df)

# shinylive code
## tutorial for deploying app: https://medium.com/@rami.krispin/deploy-shiny-app-on-github-pages-b4cbd433bdc
library(shinylive)
library(httpuv)
shinylive::export(appdir = "./app1", destdir = "./docs")
httpuv::runStaticServer("docs/", port=8008)
