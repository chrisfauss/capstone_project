# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title and helpline
  titlePanel("Word suggestion"),
  helpText("Type in some words to the input field to get the next word suggested."),
  
  # Sidebar with input text field 
  sidebarLayout(
    sidebarPanel(
            textInput("text", label = h3("Type in your text"), value = "Example: I am so")
    ),
    
    # Main part showing the top suggestion and the wordcloud
    mainPanel(
            em("Here is your suggested next word:"),
            h4(fluidRow(column(3, textOutput("value")))),
            em("Here are some other possible suggestions:"),
            plotOutput("plot1")
            
            
    )
  )
))




