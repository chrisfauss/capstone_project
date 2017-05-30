### Libraries
#########
        library(wordcloud)
        library(tm)
        library(wordcloud)
        library(shiny)
        library(ngram)
        library(data.table)


### Data
#########
        # Data path
                pd <- "./data/"

        # Load data to app
                d_1 <- data.table(readRDS(paste0(pd,"d_1.rds")))
                d_2 <- data.table(readRDS(paste0(pd,"d_2.rds")))
                d_3 <- data.table(readRDS(paste0(pd,"d_3.rds")))
                d_4 <- data.table(readRDS(paste0(pd,"d_4.rds")))
data.table
        # d_1 <- data.table(readRDS("d_1.rds"))
        # d_2 <- data.table(readRDS("d_2.rds"))
        # d_3 <- data.table(readRDS("d_3.rds"))
        # d_4 <- data.table(readRDS("d_4.rds"))

                
                
### Functions             
#########
                
        ############
        # Gets the last words separated by "_"
                get_last_x_words <- function(input,x){
                        v <- tokenize(input)
                        len_v <- length(v)
                        if(grepl(" ",input)==FALSE){
                                lastwords <- v
                                lastwords
                        } else {
                                lastwords <- paste(v[c((len_v-(x-1)):len_v)],collapse = "_")
                                lastwords
                        }
                        
                }
                
        ############
        # Creats a tokenized vector
                tokenize <- function(input_vector){
                        # Make the input vector to string
                        string_vector <- as.String(input_vector)
                        # Create a tokenized version of the string_vector
                        string_vector[wordpunct_tokenizer(string_vector)]
                }

        #############
        # Algorithm!!!
                suggest_next_word <- function(input){
                        # If input empty stop function
                        if(nchar(input)!=0){
                        
                                # Adapt input
                                tospace <- content_transformer(function(x, pattern) {return (gsub(pattern," ", x))})        
                                # Create corpus
                                input <- Corpus(VectorSource(input))
                
                                # Delete punctuation
                                input <- tm_map(input, removePunctuation)
                                # Make docs tolower
                                input <- tm_map(input, content_transformer(tolower))
                                # # Delete spaces
                                input <- tm_map(input, stripWhitespace)
                                
                                # Create vector
                                input <- concatenate(lapply(input ,"[", 1))
                                
                                # Delete " " if at the end
                                input <- gsub(" $","",input)
                                
                                
                                # Prepare the input string
                                three_last <- get_last_x_words(input, 3)
                                two_last <- get_last_x_words(input,2) # Get the two last words of the inputstring
                                one_last <- get_last_x_words(input,1)
                                
                                # Check if there is a hit in 4gram otherwise jump to previous etc.
                                
                                hit_group <- d_4[firstterms == three_last]
                                hit_group <- hit_group[order(freq,decreasing = TRUE)]
                                hit_group <- hit_group[c(1:(ifelse(nrow(hit_group)<10,nrow(hit_group),10))),c("lastterm","freq")]
                
                                if(is.na(hit_group[1,1])==FALSE){
                                        hit_group
                                } else {
                                        hit_group <- d_3[firstterms == two_last]
                                        hit_group <- hit_group[order(freq,decreasing = TRUE)]
                                        hit_group <- hit_group[c(1:(ifelse(nrow(hit_group)<10,nrow(hit_group),10))),c("lastterm","freq")]
                
                                        if(is.na(hit_group[1,1])==FALSE){
                                                hit_group 
                                        } else {
                                                hit_group <- d_2[firstterms == one_last]
                                                hit_group <- hit_group[order(freq,decreasing = TRUE)]
                                                hit_group <- hit_group[c(1:(ifelse(nrow(hit_group)<10,nrow(hit_group),10))),c("lastterm","freq")]
                
                                                if(is.na(hit_group[1,1])==FALSE){
                                                        hit_group    
                                                } else {
                                                        as.data.frame("No suggestion available")
                                                }}}
                        } else {
                                as.data.frame("Input missing")
                        }
                        
                        
                }
                
                
                
                
                
                