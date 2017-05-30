# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        # Define the top suggestion
        output$value <- renderPrint({
                
                as.String(suggest_next_word(input$text)[1,1])
                
                
                })
        
        # Define the wordcloud
        output$plot1 <- renderPlot({
                # Take the input
                i <- suggest_next_word(input$text)
                # Check if the input words were found 
                if(i[1,1]!="No suggestion available"){
                
                        # If input available check if the input is not 0
                        if(nchar(input$text)!=0){
                                # Create words
                                words <- as.data.frame(i)[,1]
                                # Create frequency
                                freq <- as.data.frame(i)[,2]
                                # Create wordcloud
                                wordcloud(words, freq=freq, colors=brewer.pal(6,"Dark2"), scale=c(5,2))
                        }
                }
        })
        
  
})


