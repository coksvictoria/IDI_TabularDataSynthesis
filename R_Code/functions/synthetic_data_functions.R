## The following script is used to store all the functions
## Required to generate synthetic data 

# Created by Matthew Hancock 23 June 2023
# Last Update by Matthew Hancock 23 June 2023

##calculate conditional entropy (from information theory) between all categorical variables
##such as wellington <-> north island relationship will be picked up
calculate_conditional_entropy <- function(x,y) {
  
  df <- data.frame(x = x, y = y)
  
  x_counter <- dplyr::count(df, x, name = "x_count")
  xy_counter <- dplyr::count(df, x, y, name = "xy_count")
  xy_counter <- dplyr::left_join(xy_counter, x_counter, by = "x")
  
  xy_counter <- dplyr::mutate(
    xy_counter,
    total_occurrences = nrow(df),
    p_xy = xy_count / total_occurrences,
    p_x = x_count / total_occurrences,
    e = ifelse(
      p_xy == 0,
      0,
      p_xy*log(p_x / p_xy)
    )
  )
  sum(xy_counter$e)
}


calculate_conditional_entropy_df <- function(df,c_col) {
  
  all_columns <- dplyr::filter(
    tidyr::expand_grid(c_cola = c_col, c_colb = c_col), c_cola != c_colb)
  
  all_columns$Entropy <-
    purrr::map2_dbl(
      all_columns$c_cola,
      all_columns$c_colb,
      ~ calculate_conditional_entropy(df[[.x]], df[[.y]])
    )
  
  dplyr::arrange(all_columns, Entropy)
}

# Calculate distribution

calculate_category_distribution <- function(v) {
  values <- unique(v)
  dist <- purrr::map_int(values, ~ sum(v == .x,na.rm = TRUE))
  names(dist) <- values
  return(dist)
}

# Calculate quartiles

calculate_quantiles <- function(v, number_of_quantiles = 4, include_range = TRUE, na.rm = TRUE) {
  
  ##quantiles set to 4 by default, which means there are 4 groups, with 5 range points
  ##i.e. q1(min-25) q2(2 to median) q3(median-75) q4(75 - max)
  if (!na.rm && any(is.na(v))) {
    stop("The vector `v` contains one or more NA values, which means we cannot calculate quantiles.")
  }
  
  space_between_quantiles <- 1 / number_of_quantiles
  quantile_divisions <- seq(0, 1, space_between_quantiles)
  
  if (!include_range) {
    quantile_divisions <- quantile_divisions[!quantile_divisions %in% c(0, 1)]
  }
  
  as.vector(stats::quantile(v, quantile_divisions, na.rm = na.rm))
}

generate_probability <- function(n_categories = 10) {
  rv_probabilities <- stats::runif(n_categories)
  probabilities <- rv_probabilities / sum(rv_probabilities)
  return(probabilities)
}


generate_category <- function(n = 100, values = letters[1:10]) {
  categories <- NULL
  probabilities <- NULL
  
  # Unnamed vectors will use random probability
  if (is.null(names(values))) {
    categories <- values
    probabilities <- generate_probability(length(categories))
  }
  categories <- names(values)
  probabilities <- as.vector(na.omit(values)) ##remove nas
  
  sample(x = categories, size = n, replace = TRUE, prob = probabilities)
}


generate_number <- function(count=100, quantiles = numeric(), shuffle = TRUE) {
  # We need create `count` values. Let's evenly assign these values to our quantiles
  number_of_quantiles <- length(quantiles) +1
  samples_per_quantile <- count / number_of_quantiles
  
  quantile_stocks <- rep(samples_per_quantile, number_of_quantiles)
  
  # Assign character
  character_df_names <- paste0("q", 1:number_of_quantiles)
  
  character_df <- purrr::map_dfr(1:number_of_quantiles, function(i) {
    # Step 1: generate data for rows completely inside the quartile
    number_of_interior_samples <- floor(quantile_stocks[i])
    
    interior_list <- purrr::map(
      1:number_of_quantiles, ~
        rep(ifelse(.x == i, 1, 0), number_of_interior_samples)
    )
    
    names(interior_list) <- character_df_names
    
    interior_df <- as.data.frame(interior_list)
    
    quantile_stocks[i] <<- quantile_stocks[i] %% 1
    
    # Step 2: create fractional assignment, if required
    exterior_df <- NULL
    if (quantile_stocks[i] > 0) {
      exterior_vec <- rep(0, number_of_quantiles)
      
      exterior_vec[i] <- quantile_stocks[i]
      exterior_vec[i+1] <- 1 - quantile_stocks[i]
      
      quantile_stocks[i] <<- 0
      quantile_stocks[i+1] <<- quantile_stocks[i+1] - exterior_vec[i+1]
      
      names(exterior_vec) <- character_df_names
      
      exterior_df <- as.data.frame(as.list(exterior_vec))
    }
    dplyr::bind_rows(interior_df, exterior_df)
  }
  )
  
  # At this point we know what character each row has. Let's assign some random
  # numbers and calculate
  min<-quantiles[1]
  max<-tail(quantiles,1)
  
  quantile_range_minima <- c(min, as.vector(quantiles))
  quantile_range_maxima <- c(as.vector(quantiles), max)
  
  for (i in 1:number_of_quantiles) {
    column_name <- paste0("v", i)
    weighting_name <- paste0("q", i)
    
    weighting <- character_df[[weighting_name]]
    value <- stats::runif(n = count, min = quantile_range_minima[i], max = quantile_range_maxima[i])
    
    character_df[[column_name]] <- value * weighting
  }
  
  # Build final value by summing all values
  series <- rowSums(character_df[stringr::str_starts(names(character_df), "v")])
  
  if (shuffle) {
    series <- sample(series)
  }
  
  return(series)
}


df_generation<-function(n_samples,col_names,c_col,cat_dist,num_dist,int_col,missing_value){
  synthetic_list <- list()
  for (column_name in col_names) {
    if (column_name %in% c_col){
      synthetic_list[[column_name]]<-generate_category(n_samples,cat_dist[[column_name]])
    }
    
    else if (column_name %in% int_col) {
      synthetic_list[[column_name]]<-round(generate_number(n_samples,num_dist[[column_name]]))  
    }
    
    else{
      synthetic_list[[column_name]]<-generate_number(n_samples,num_dist[[column_name]])
    }
    
    n_missing<-missing_value[[column_name]]
    
    if (n_missing>0){
      if (n_samples>n_missing){
        synthetic_list[[column_name]][sample(n_samples,n_missing)]<-NA
      }
    }
  }
  return(as.data.frame(synthetic_list))
}