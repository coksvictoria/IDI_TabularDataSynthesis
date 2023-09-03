schema_detect<-function (v, cat_threshold = 30) 
{ vector_class <- class(v)[1]

  
  if (vector_class %in% c("blob")){
    return("d_oth")
  }

  vector_size <- length(v)
  number_of_uniques <- n_distinct(v, na.rm = TRUE)
  n_na<-sum(is.na(v))

  # if(all(is.na(v))){
  #   return(NA)
  # }
  
  if (vector_size  == n_na) {
    return("d_nas")
  }

  if (vector_class == "logical") {
    return("c_bin")
  }
  
  if (number_of_uniques == 1) {
    return("c_con")
  }
  if (number_of_uniques == 2) {
    return("c_bin")
  }
  
  
  if (vector_class %in% c("character","factor")) {
    mean_number_of_words <- mean(stringr::str_count(v, " +"),na.rm = TRUE) + 1
    
    if (number_of_uniques>vector_size-2 & vector_size>cat_threshold) {
      return("c_pii")
    }
    
    # 
    # if(class(anytime::anydate(v))=='Date'){
    #   return("n_dat")
    # }
    
    if (number_of_uniques/vector_size > 0.001 & number_of_uniques > cat_threshold) {
      return("c_hca")
    }
    
    if (mean_number_of_words > 10) {
      return("c_txt")
    }
    
    
    return("c_cat")
  }
  
  
  if (vector_class %in% c("numeric","integer")){
    
    if (number_of_uniques < cat_threshold) {
      return("c_int")
    }
    
    if (all(v == floor(v), na.rm = TRUE)) {
      return("n_int")
    }
    return("n_flo")
  }
  
  if (vector_class == "Date") {
    return("n_dat")
  }
  
  if (vector_class %in% c("POSIXct","POSIXlt")){
    return("n_dtm")
  }
  
}

get_mean <- function(v) {
  
  vector_class <- class(v)[1]
  
  if (vector_class %in% c("blob")){
    return(NA)
  }
  
  if(all(is.na(v))){
    return(NA)
  }
  
  vector_class=class(v)[1]
  if (vector_class %in% c("numeric","integer")){
    return(mean(v,na.rm=TRUE))
  }
  else{
    return(getmode(v))
  }
}

get_min<-function(v){
  vector_class <- class(v)[1]
  
  if (vector_class %in% c("blob")){
    return(NA)
  }
  
  if(all(is.na(v))){
    return(NA)
  }
  
  if (vector_class %in% c("numeric","integer","Date","POSIXct","POSIXlt")){
    return(min(v,na.rm=TRUE))
  }
  else{
    ct<-table(v)
    return(names(ct[which.min(ct)]))
  }
}

get_n_distinct<-function(v){
  vector_class <- class(v)[1]
  if (vector_class %in% c("blob")){
    return(NA)
  }
  if(all(is.na(v))){
    return(NA)
  }
  
  return(n_distinct(v))
}

get_max<-function(v){
  vector_class <- class(v)[1]
  
  if (vector_class %in% c("blob")){
    return(NA)
  }
  if(all(is.na(v))){
    return(NA)
  }
  
  
  if (vector_class %in% c("numeric","integer","Date","POSIXct","POSIXlt")){
    return(max(v,na.rm=TRUE))
  }
  else{
    ct<-table(v)
    return(names(ct[which.max(ct)]))
  }
}

n_missing<-function (v) 
{vector_class <- class(v)[1]
if (vector_class %in% c("blob")){
  return(NA)
}
  n_m<-sum(is.na(v))
  return(n_m)
}

p_missing<-function (v) 
{vector_class <- class(v)[1]
  if (vector_class %in% c("blob")){
    return(NA)
  }
  vector_size <- length(v)
  n_m<-sum(is.na(v))/vector_size*100
  return(n_m)
}

flag_string<-function(v,s){
  vector_class <- class(v)[1]
  
  if (vector_class %in% c("blob")){
    return(NA)
  }
  
  if(all(is.na(v))){
    return(NA)
  } else{
    sum(stringr::str_count(v, s),na.rm = TRUE)
  }
}

# Create the function.
getmode <- function(v) {
  
  vector_class <- class(v)[1]
  
  if (vector_class %in% c("blob")){
    return(NA)
  }
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

average_char<-function (v) 
{vector_class <- class(v)[1]
if (vector_class %in% c("blob")){
  return(NA)
}
  
  if(all(is.na(v))){
    return(NA)
  } else{
    round(mean(nchar(as.character(v)),na.rm = TRUE),0) 
  }
  
}