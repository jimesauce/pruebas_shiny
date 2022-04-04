
# ejercicio 1 -------------------------------------------------------------


library(shiny)

ui <- fluidPage(
  textInput("name", NULL, value = "your name"),
    )

server <- function(input, output, session){
  output$name <- renderText(
    input$name
  )
}
shinyApp(ui, server)



# ejercicio 2 -------------------------------------------------------------

library(shiny)
runExample("05_sliders")

library(shiny)

ui <- fluidPage(
  sliderInput("date", "Cuando me fui de ultima vez de vacas?", 
              value = as.Date("2020-03-20"), 
              min = as.Date("2020-03-2020"), 
              max = as.Date("2022-04-04"),
              timeFormat ="%Y-%m-%d")
)

server <- function(input, output, session){
  
} 

shinyApp(ui, server)


# ejercicio 3 -------------------------------------------------------------

ui <- fluidPage(
  sliderInput("ID", NULL,
              min = 0,
              max = 100,
              value = 50,
              step = 5,
              animate = animationOptions(
                interval = 500, # a menos número más rápido va la animación
                loop = FALSE,
                playButton = NULL,
                pauseButton = NULL
              ))
)
server <- function(input, output, session){
  
}
shinyApp(ui, server)
