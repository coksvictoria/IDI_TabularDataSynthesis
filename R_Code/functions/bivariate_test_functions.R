## the following script is used to define functions used in the bivariate 
## analysis of the synthetic and original data

# Created by Matthew Hancock 08 August 2023
# Last edited by Matthew Hancock 08 August 2023

cor_matrix_creator <- function(var_type, df) { 
  
  # define the number of rows and columns in the matrix by the number of cols in
  # the dataframe
  n <- ncol(df)

# create the empty matrix and name the rows and columns
cor_matrix <- matrix(NA, nrow = n, ncol = n)
colnames(cor_matrix) <- names(df)
rownames(cor_matrix) <- names(df)

# loop through the combinations of variables in the in the data frame and find 
# what type of varibale it is

for(i in 1:n) {
  for(j in 1:n) {
    var1 <- df[, i]
    var2 <- df[, j]
    var1_type <- var_type$test_cat[var_type$var_name == names(df)[i]]
    var2_type <- var_type$test_cat[var_type$var_name == names(df)[j]]
    
    # apply the right correlation function based on what test_cat we have id'd
    # for each test if it can't be applied just give it a NA
    if (var1_type == "continuous" && var2_type == "continuous") {
      cor_matrix[i, j] <- tryCatch({stats::cor(var1, var2, method = "pearson")
      }, error = function(e) {
        NA
      }) 
    } else if (var1_type == "nominal" && var2_type == "nominal") {
      cor_matrix[i, j] <-  tryCatch({lsr::cramersV(var1,var2)
      }, error = function(e) {
        NA
      })
    } else if (var1_type == "dichotomous" && var2_type == "dichotomous") {
      cor_matrix[i, j] <-  tryCatch({vcd::assocstats(table(data.frame(var1, var2)))$phi
      }, error = function(e) {
        NA
      })
    } else if (var1_type == "continuous" && var2_type == "dichotomous") {
      cor_matrix[i, j] <-  tryCatch({stats::cor.test(as.numeric(var1), as.numeric(factor(as.vector(var2), levels=sort(unique(as.vector(var2)))))-1)$estimate
      }, error = function(e) {
        NA
      })
    } else if (var1_type == "dichotomous" && var2_type == "continuous") {
      cor_matrix[i, j] <-  tryCatch({stats::cor.test(as.numeric(var1), as.numeric(factor(as.vector(var2), levels=sort(unique(as.vector(var2)))))-1)$estimate
      }, error = function(e) {
        NA
      })
    } else if (var1_type == "continuous" && var2_type == "nominal") {
      cor_matrix[i, j] <-  tryCatch({as.vector(data.frame(lsr::etaSquared(aov(var1 ~ var2))) %>% 
                                                               select(eta.sq))$eta.sq
      }, error = function(e) {
        NA
      })
    } else if (var1_type == "nominal" && var2_type == "continuous") {
      cor_matrix[i, j] <-  tryCatch({as.vector(data.frame(lsr::etaSquared(aov(var1 ~ var2))) %>% 
                                                 select(eta.sq))$eta.sq
      }, error = function(e) {
        NA
      })
    }
  }
}
return(cor_matrix)
}

# Create a function for retaing in the lower triangle of the matrix and NA the
# upper half

get_lower_tri<-function(cor_matrix){
  cor_matrix[upper.tri(cor_matrix)] <- NA
  return(cor_matrix)
}
