library(pdftools)
library(tidytext)
library(dplyr)
library(ggplot2)
library(wordcloud)
library("SnowballC")
library(tm)


text <- pdf_text('./artigo.pdf')
text_df<- data_frame(line=1:15,text=text)

#quebrar sentenças em tokens
tidy_artigo <- text_df %>%
  unnest_tokens(word,text)
  
  stopwords_pt <- c(stopwords("pt"), "de", '2675', "é", 'bem', 'china', "sr", "sra",'ainda','meio','mai', "que", 'forma', 'academica',
                    "a", "curitiba", "2020", 'silva','acad�mica', 'maio', 'revis�o', '�', 'p�s', 'literatura', '1', 'al�m','podem', 'ser', 'al�m','casos', 'além', 'campos', 'sobre', 'acadêmica', 'sendo',"2021", '457','4711','individuos', 'menos','2675', 'jun', 'cov', '471',"19","al","2","revisão", "pós","archives","sp", "v.exa")
stopwords_pt_df <- data.frame(word = stopwords_pt)

tidy_artigo <- tidy_artigo %>%
  anti_join(stopwords_pt_df, by = "word")


tidy_artigo %>% 
  count(word, sort= TRUE)



#wordcloud

tidy_artigo %>%
  anti_join(stop_words)%>%
  count(word)%>%
  with(wordcloud(word, n, max.words=50, colors=brewer.pal(7, "Dark2")))
  

