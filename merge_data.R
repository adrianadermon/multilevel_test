library(feather)
library(haven)
library(dplyr)
library(tidyr)
library(stringr)

setwd("C:/Users/adria/Dropbox/Forskning/Software tests/Multilevel")

df_R <- read_feather("R_test_data.feather")

df_julia <- read_feather("julia_test_data.feather")
df_julia <- df_julia %>% mutate(type = "ml")

df_stata <- bind_rows(read_stata("Stata_test_small.dta"), read_stata("Stata_test_medium.dta"), read_stata("Stata_test_large.dta"))

# Capitalize data size values
df_stata <- df_stata %>% mutate(data = str_to_title(data))

df_stata <- df_stata %>% rename(package = format)

df_stata <- df_stata %>% gather(type, time, reml_2:ml_3)

df_stata <- df_stata %>% filter(is.nan(time) == FALSE)


df <- bind_rows(df_R, df_stata)

df <- df %>% separate(type, c("type", "levels") , sep = "_")
df <- df %>% mutate(levels = as.integer(levels))


df <- bind_rows(df, df_julia)



df <- df %>% mutate(package = ifelse(
  package == "lme4", "R", ifelse(
    package == "MixedModels", "julia", package
  )
))

# Write merged data to disk
write_feather(df, "results.feather")
