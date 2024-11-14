library(shiny)
library(bslib)
library(raster)
library(ggplot2)

#r = raster("./data/r1.tif")

# ui <- basicPage(
#   
#   # output the raster
#   plotOutput(outputId = "plot1")
#   
# )

# sidebarPanel(titlePanel("Select scenario"),
#              width = 4)
# 
# mainPanel(titlePanel("Map"),
#           plotOutput(outputId = "plot1"),
#           width = 8)

ui = fluidPage(
  titlePanel(fluidRow(column(width=4, offset=4, "Data explorer"))),
  sidebarPanel(h1("Options"),
               selectInput("data", "Select dataset", choices = c("Raster 1", "Raster 2")),
               selectInput("color", "Select color scheme", choices = c("viridis", "mako", "magma")),
               width = 4),
  
  mainPanel(plotOutput(outputId = "plot1"),
            width = 8),
  position = "left",
  fluid = TRUE
)

server <- function(input, output) {
  
  # convert raster to df for plotting
  ## probably want to do this in advance for large rasters
  ## and load in R object
  # r_df = as.data.frame(r, xy=TRUE)
  # colnames(r_df) = c("x", "y", "z")
  # 
  # 
  # output plot
  
  # load in dataframes of all rasters
  rasters = readRDS("./data/rasters")
  
  ## note that several options are reactive
  # dataset
  # fill color scheme
  output$plot1 = renderPlot({
    
    if (input$data == "Raster 1"){
      r_df = rasters[[1]]
    }
    if (input$data == "Raster 2"){
      r_df = rasters[[2]]
    }
    
    # # create df from raster for plotting
    # r_df = as.data.frame(r, xy=TRUE)
    # colnames(r_df) = c("x", "y", "z")
    
    # create plot
    ggplot(data=r_df, mapping=aes(x=x, y=y, fill=z))+
    geom_tile()+
    scale_fill_viridis_c(option=input$color)+
    labs(x="Longitude", y="Latitude", fill="Env")+
    coord_equal()
  },
  res=96
  )
  
  # output$plot1 = renderPlot({
  #   ggplot(data=data.frame(x=1:10, y=21:30), mapping=aes(x=x, y=y))+
  #     geom_point()
  # }, res=96)
  
}

shinyApp(ui = ui, server = server)
