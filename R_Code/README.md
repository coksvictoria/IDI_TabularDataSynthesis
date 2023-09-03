##Installation

# Required Packages
library(tidyverse) # grooming etc
library(odbc) # database management
library(readxl) # excel loading
library(dplyr) # data wrangling
library(openxlsx) # excel loading
library(skimr) # tool for data profiling
library(glue) # used for gluing strings
library(stringi) # used to generate random strings
library(lubridate) # used to generate dates
library(OpenML) # used in production of synth data
library(farff) # used in production of synth data
library(purrr) # used in production of synth data

library(synthpop) # used in generating high fidelity synthetic data
library(recipes) # used in pipeline
library(themis) # used in smote for data generation
library(superml) # tentative - for label encoding
library(xgboost) # load xgboost for classification
library(vip) # feature importance
library(car) # contains levene's test function
library(lawstat) # contains another levene's test function
library(lsr) # Eta test
library(rcompanion) # Phi
library(psych) # Phi
library(vcd) # phi
library(reshape2) # visualise correlation matrix
library(ggthemes)# visualise correlation matrix
library(httr) # API
library(jsonlite) # handling JSON
library(plotly) # just for the development process - remove at the end


# Run the profile functions and script
source("functions/profile_functions.R")
source("profile_production_code/data_profile.R")

# Run the artificial data functions and script
source("functions/artificial_data_functions.R")
source("profile_production_code/artificial_data.R")

# Run the lo-fi data functions and script
source("functions/synthetic_data_functions.R")
source("functions/profile_functions.R")
source("profile_production_code/lo_fi_synthetic_data.R")

# Run the hi-fi data functions and script
source("functions/synthetic_data_functions.R")
source("functions/profile_functions.R")
source("profile_production_code/hi_fi_synthetic_data.R")
