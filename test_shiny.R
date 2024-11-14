setwd("C:/Users/icepi/Documents/GitHub/test_shiny_app")
library(shiny)

runApp("app1")
install.packages(c("shinylive", "httpuv"))

# shinylive code
shinylive::export(appdir = "./app1", destdir = "./docs")
httpuv::runStaticServer("docs/", port=8008)
