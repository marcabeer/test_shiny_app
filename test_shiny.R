setwd("C:/Users/icepi/Documents/GitHub/test_shiny_app")
library(shiny)

runApp("app1")
#install.packages(c("shinylive", "httpuv"))

# shinylive code
## tutorial for deploying app: https://medium.com/@rami.krispin/deploy-shiny-app-on-github-pages-b4cbd433bdc
library(shinylive)
library(httpuv)
shinylive::export(appdir = "./app1", destdir = "./docs")
httpuv::runStaticServer("docs/", port=8008)
