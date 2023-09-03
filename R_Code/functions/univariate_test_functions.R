# The following script contains all the functions required to do univariate
# testing of the synthetic data vs the original data.

# Created by Matthew Hancock 17 July 2023
# Last updated by Matthew Hancock 17 July 2023

# KS Test - null hypothesis = distributions are the same------------------------

apply_ks_test <- function(df1, df2)
  
  # apply to the same column in each dataset or warn
{if (!identical(colnames(df1),
                colnames(df2))) {
  stop("Data frames must have the same column names.")
}
  # Create empty list
  results <- list()
  
  # fill list with columns and p value outcome of the test
  for(col in colnames(df1)) {
    
    # dont stop on error if test no applicable to var type just report and move
    # on
    tryCatch({
      p_value <- ks.test(df1[[col]],
                         df2[[col]])$p.value
      results[[col]] <- p_value
    }, error = function(e) {
      cat("test could not be aplied to this variable", col, "\n")
    })
  }
  return(results)
}

# MW Test - null hypothesis = populations are the same-------------------------- 

apply_wilcox_test <- function(df1, df2)
  
  # apply to the same column in each dataset or warn
{if (!identical(colnames(df1),
                colnames(df2))) {
  stop("Data frames must have the same column names.")
}
  # Create empty list
  results <- list()
  
  # fill list with columns and p value outcome of the test
  for(col in colnames(df1)) {
    
    # dont stop on error if test no applicable to var type just report and move
    # on
    tryCatch({
      p_value <- wilcox.test(df1[[col]],
                             df2[[col]])$p.value
      results[[col]] <- p_value
    }, error = function(e) {
      cat("test could not be aplied to this variable", col, "\n")
    })
  }
  return(results)
}

# MD Test - null hypothese = population medians are equal-----------------------

apply_moods_median_test <- function(df1, df2)
  
  # apply to the same column in each dataset or warn
{if (!identical(colnames(df1),
                colnames(df2))) {
  stop("Data frames must have the same column names.")
}
  # Create empty list
  results <- list()
  
  # fill list with columns and p value outcome of the test
  for(col in colnames(df1)) {
    
    # dont stop on error if test no applicable to var type just report and move
    # on
    tryCatch({
      p_value <- mood.test(df1[[col]],
                           df2[[col]])$p.value
      results[[col]] <- p_value
    }, error = function(e) {
      cat("test could not be aplied to this variable", col, "\n")
    })
  }
  return(results)
}

# LE Test - null hypothesis test = population variances are equal---------------

apply_levene_test <- function(df1, df2)
  
  # apply to the same column in each dataset or warn
{if (!identical(colnames(df1),
                colnames(df2))) {
  stop("Data frames must have the same column names.")
}
  # Create empty list
  results <- list()
  
  # fill list with columns and p value outcome of the test
  for(col in colnames(df1)) {
    
    # dont stop on error if test no applicable to var type just report and move
    # on
    tryCatch({
      p_value <- car::leveneTest(df1[[col]],
                                 df2[[col]])$`Pr(>F)`
      results[[col]] <- p_value
    }, error = function(e) {
      cat("test could not be aplied to this variable", col, "\n")
    })
  }
  return(results)
}

# Chi-sq Test - null hypothesis test = population variances are equal-----------

apply_chi_test <- function(df1, df2)
  
  # apply to the same column in each dataset or warn
{if (!identical(colnames(df1),
                colnames(df2))) {
  stop("Data frames must have the same column names.")
}
  # Create empty list
  results <- list()
  
  # fill list with columns and p value outcome of the test
  for(col in colnames(df1)) {
    
    # dont stop on error if test no applicable to var type just report and move
    # on
    tryCatch({
      p_value <- chisq.test(df1[[col]],
                            df2[[col]])$p.value
      results[[col]] <- p_value
    }, error = function(e) {
      cat("test could not be aplied to this variable", col, "\n")
    })
  }
  return(results)
}