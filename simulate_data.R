# This code simulates three multilevel datasets of different sizes

setwd("F:/Dropbox/Forskning/Software tests/Multilevel")

library(dplyr)
library(feather)
library(haven)

# Define function to simulate three-level data
simulate_multilevel <- function(sd3, sd2, sd1, n){
  # Level three
  
  # Generate random extended family effect
  v_k <- rnorm(n, mean = 0, sd = sd3)
  
  # Generate extended family indicator
  id3 <- seq_len(n)
  
  # Randomize family size
  famsize3 <- as.integer(rpois(n, 2))
  
  # Put in dataframe
  df <- data.frame(id3, v_k, famsize3)
  
  # Expand data set to families with 2-8 children
  df <- data.frame(df[rep(seq_len(n), df$famsize3), ])
  # Reset weird rownamea
  rownames(df) <- NULL
  
  # Level two
  
  n <- nrow(df)
  
  # Generate random family effect
  df$u_jk <- rnorm(n, mean = 0, sd = sd2)
  
  # Generate family indicator
  df$id2 <- seq_len(n)
  
  # Randomize family size
  df$famsize2 <- as.integer(rpois(n, 2))
  
  # Expand data set to families with 2-8 children
  df <- data.frame(df[rep(seq_len(n), df$famsize2), ])
  # Reset weird rownamea
  rownames(df) <- NULL
  
  # Level one
  
  n <- nrow(df)
  
  # Generate random individual effects
  df$e_ijk <- rnorm(n, mean = 0, sd = sd1)
  
  # Generate individual identifiers
  df$id1 <- seq_len(n)
  
  # Generate random birth year
  df$by <- runif(n, min = 1965, max = 1985) %>% round()
  
  # Generate random gender dummy
  df$gender <- rbinom(n, 1, 0.5)

  # Generate random gender effects
  df <- df %>% group_by(gender) %>% mutate(e_g = rnorm(1, 0, 1)) %>% ungroup()
  
  # Generate random birth year effects
  df <- df %>% group_by(by) %>% mutate(e_by = rnorm(1, 0, 1)) %>% ungroup()
  
  # Generate outcome
  df <- df %>% mutate(y = v_k + u_jk + e_ijk + e_g + e_by)
    
  # Drop unwanted variables
  df <- df[c("id3", "id2", "id1", "gender", "by", "y")]
  
  return(df)
}


# Simulate three-level data
#--------------------------
set.seed(1)

# Number of observations
n <- 10000

sd3 = 3
sd2 = 5
sd1 = 6

df_small <- simulate_multilevel(sd3, sd2, sd1, 10000)
df_medium <- simulate_multilevel(sd3, sd2, sd1, 100000)
df_large <- simulate_multilevel(sd3, sd2, sd1, 1000000)


write_feather(df_small, "data_small.feather")
write_dta(df_small, "data_small.dta")

write_feather(df_medium, "data_medium.feather")
write_dta(df_medium, "data_medium.dta")

write_feather(df_large, "data_large.feather")
write_dta(df_large, "data_large.dta")
