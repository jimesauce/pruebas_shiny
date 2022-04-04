
# La manera mas simple- duplica el dataset en el server -------------------


library(shiny)


ui <- fluidPage(
  selectInput(inputId = "dataset", label = "Pepito", choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
  )

server <- function(input, output, session) {
  output$summary <- renderPrint({
    dataset <- get(input$dataset, "package:datasets")
    summary(dataset)
  })
  output$table <- renderTable({
    dataset <- get(input$dataset, "package:datasets")
    dataset
  })
}

shinyApp(ui, server)


# usando una expresión reactiva nos libramos de la duplicación ------------


library(shiny)

ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  output$summary <- renderPrint({
    summary(dataset())
  })
  output$table <- renderTable({
    dataset()
  })
}

shinyApp(ui, server)


# ejercicio 1.8 capitulo 1 ------------------------------------------------


ui <- fluidPage(
  textInput("name", label = "What´s your name?"),  #preguntar porque mete el 
  textOutput("greeting") # si aca en vez de textOutput usas verbatimTextOutput te queda un chunk en gris
)

server <- function(input, output, session) {
  output$greeting <- renderText({
    paste0("Hello ", input$name)
  })
}

shinyApp(ui, server)



# ejercicio 2 -------------------------------------------------------------

ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  "then x times 5 is",
  textOutput("product")
)

server <- function(input, output, session) {
  output$product <- renderText({ 
    input$x * 5 #corrijo poniendo input$x en vez de x sola
  })
}

shinyApp(ui, server)


# ejercicio 3 -------------------------------------------------------------

ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", label = "and y is", min = 1, max = 50, value = 30),
    "then x times y is",
  textOutput("product")
)

server <- function(input, output, session) {
  output$product <- renderText({ 
    input$x * input$y 
  })
}

shinyApp(ui, server)

# ejercicio 3 español -------------------------------------------------------------

ui <- fluidPage(
  sliderInput("x", label = "Si x es", min = 1, max = 50, value = 30),
  sliderInput("y", label =  "e y es", min = 1, max = 50, value = 30),
    "entonces x veces y es",
  textOutput("resultado")
)

server <- function(input, output, session) {
  output$resultado <- renderText({
    input$x * input$y
  })
}

shinyApp(ui, server)


# ejercicio 4 -------------------------------------------------------------

ui <- fluidPage(
  sliderInput("x", "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", "and y is", min = 1, max = 50, value = 5),
  "then, (x * y) is", textOutput("product"),
  "and, (x * y) + 5 is", textOutput("product_plus5"),
  "and (x * y) + 10 is", textOutput("product_plus10")
)

server <- function(input, output, session) {
  product <- reactive({
    input$x * input$y
  })
  output$product <- renderText({ 
    product()
  })
  output$product_plus5 <- renderText({ 
    product() + 5
  })
  output$product_plus10 <- renderText({ 
    product() + 10
  })
}

shinyApp(ui, server)


# ejercicio 5 -------------------------------------------------------------

library(shiny)
library(ggplot2)

datasets <- c("economics", "faithfuld", "seals")
ui <- fluidPage(
  selectInput("dataset", "Dataset", choices = datasets),
  verbatimTextOutput("summary"),
  plotOutput("plot") #en vez de table va plot
)

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:ggplot2")
  })
  output$summary <- renderPrint({ #tipo en summmry
    summary(dataset())
  })
  output$plot <- renderPlot({
    plot(dataset()) # faltaban un par de parentesis
  }, res = 96)
}

shinyApp(ui, server)
