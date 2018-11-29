# Shiny App
# November 28 2018
# Jessica

# ShinyApp is an r package that build interactive web apps
# use R coding and web inerativeness to create a reactive experience
# ui - user interface: this is the control / apperance the app.
# server - the coding instructions for the shiny app
# control widgets: web elements that users will interact with.

library(shiny)
# Define ui --
# ui <- fluidPage(
#   titlePanel(""),
#   sidebarLayout(
#     sidebarPanel(),
#     mainPanel()
#   )
# )
# 
# # Define server
# server <- function(input, output){
#   
# }
# 
# # run the app
# library(shiny)
# 
# ui <- fluidPage(
#   
# )
# 
# server <- function(input, output, session) {
#   
# }
# 
# shinyApp(ui=ui, server=server)

library(shiny)
ui <- fluidPage(
  
  # add a title
  titlePanel("This is a test shiny"),
  
  # create sidebar
  sidebarLayout(position = "right",
                sidebarPanel(
                  #add a header in sider panel
                  h1("this is my first header"),
                  h2("second"),
                  h3("third"),
                  selectInput("X", label = 'X', names(trees)),
                  selectInput("Y", label = "Y", names(trees)),
                  mainPanel(
                    # add a header
                    h1("header"),
                    strong("this is important text"),
                    # add a paragraph
                    p("This is a paragraph about my graph"),
                    br(),
                    #add in an image
                    img(src="ant.jpg", height = 75, width = 75),
                    plotOutput("TreePlot")
                  )
                )
                )
)



server <- function(input,output){
  
  selectedData <- reactive({
    trees[, c(input$X, input$Y)]
  })
  
  # use reender plot to add reactive element to plot
  output$TreePlot <- renderPlot({
    
    # basic plot function that is built into r
    plot(selectedData(),
         type = "p",
         
         # change point: pch values stored plot: 21.25 - color and fill points, 19 - point
         pch = 21.25,
         col = "black",
         bg = "blue",
         
         # add main title to the graph
         main = "this is the title",
         
         # subtitle
         sub = "This is a good place to put a caption")
  }
  )
}

# call to shiny app
shinyApp(ui=ui, server=server)