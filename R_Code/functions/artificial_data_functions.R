## This script was generated to bring together all functions
## required to generate artificial data

# created Matthew Hancock 23 June 2023
# last updated Matthew Hancock 23 June 2023

# Create unique strings
unique_string_gen<- function(n=100,char_len=5){
  pool <- c(letters, LETTERS, 0:9)
  res <- vector(mode="character") # pre-allocating vector is much faster than growing it
  if(length(char_len)==1){
    char_lens<-rep(char_len,n)
  }else{
  char_lens<-sample(char_len,n,replace = TRUE)
  }
  for(i in seq(n)){
    this_res <- paste0(sample(pool, char_lens[i], replace = TRUE), collapse = "")
    while(this_res %in% res){ # if there was a duplicate, redo
      this_res <- paste0(sample(pool, char_lens[i], replace = TRUE), collapse = "")
    }
    res[i] <- this_res
  }
  return(res)
}

# Create unique strings and slightly less unique strings
unique_strings <-unique_string_gen(n=30,char_len = 5:10)
less_unique_strings <- unique_string_gen(n=10,char_len = 5:10)
  
# create a list of random words (50 from online generator + common connecting words)
words <- c("scarf", "bad", "manage","finicky","test","grotesque","start",
           "like","fry","loose","horn","ring","spooky","strengthen","ill",
           "spring","unsightly","deeply","dime","second","bucket","bottle",
           "tin","pumped","whispering","pour","burst","paddle","rate",
           "friends","long-term","huge","friend","march","expand","wretched",
           "authority","painful","nose","bolt","shivering","step","straw",
           "kill","destroy","punishment","quartz","decay","dolls","premium",
           "I","and","to","a","if","what","when","where","why","you","the")

# Create functions for c_int, and n_int data types

c_int <- function() {
     as.character(sample(1:100, 100, replace = TRUE))
}

n_int <- function() {
  sample(1:100, 100, replace = TRUE)
}


# Create function for n_flo data types

n_flo <- function() {
    round(runif(n=100, min = 1, max = 100), digits = 3)
}


# Create function for c_bin data types

c_bin<-function(f_logical=TRUE){
  if(f_logical){
    sample(c(TRUE,FALSE),100,replace = TRUE)
  }
  else{
    sample(c(0,1),100,replace = TRUE)
  }
}


# Create functions for d_nas, d_oth (essentially just a load of nas)

d_nas<-function(){
  rep(NA,100)
}

d_oth <-function(){
  rep(NA,100)
}

# Create functions for c_con

c_con<-function(){
  rep("constant",100)
}

# create function for date types (date and dtm)

n_dat<-function(n=100,
                   start_date="2022/01/01",
                   by="days",
                   feature_eng=FALSE)
{
  s_d<-as.Date(start_date)
  samples<-seq(s_d,by=by,length.out=n)
  
  if (feature_eng){
    table<-data.frame(
      "Date"=samples,
      "Year"=year(samples),
      "Quarter"=quarter(samples),
      "Month"=month(samples,label=TRUE),
      "Week"=week(samples),
      "Day"=day(samples),
      "WorkDay"=wday(samples,label=TRUE))
    return(table)
  }
  else{
    return(samples)
  }
}


# Create function for n_dtm data types

n_dtm <- function() {

  as_datetime(runif(n=100, 946684800, 1687198388))

}


# Create function for c_text data types which creates random sentences and samples them
c_txt <- function(data_table) {

    number_of_words <- sample(10:20,1)
    sentence <- sample(words,number_of_words, replace = TRUE)
    sentence <- paste(sentence, collapse = " ")
    sample(sentence,100 , replace = TRUE)
  }


# Create function for c_pii
c_pii <- function() {

stri_rand_strings(n = 100, sample(5:11, 5, replace=TRUE), pattern = "[A-Za-z]")

}


# Create function for c_hca
c_hca <- function(data_table) {

   sample(unique_strings, 100, replace = TRUE)
  
}

# Create function for c_cat
c_cat <- function() {
       
  sample(less_unique_strings, 100, replace = TRUE)

}

