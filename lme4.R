# This code estimates multilevel models using the lme4 package and saves the estimation times to disk

setwd("F:/Dropbox/Forskning/Software tests/Multilevel")

library(feather)
library(microbenchmark)
library(dplyr)
library(lme4)

Small <- read_feather("data_small.feather")
Medium <- read_feather("data_medium.feather")
Large <- read_feather("data_large.feather")

sizes <- c("Small", "Medium", "Large")

# Convert to factors
Small <- Small %>% mutate(by = as.factor(by), gender = as.factor(gender), id3 = as.factor(id3), id2 = as.factor(id2), id1 = as.factor(id1))
Medium <- Medium %>% mutate(by = as.factor(by), gender = as.factor(gender), id3 = as.factor(id3), id2 = as.factor(id2), id1 = as.factor(id1))
Large <- Large %>% mutate(by = as.factor(by), gender = as.factor(gender), id3 = as.factor(id3), id2 = as.factor(id2), id1 = as.factor(id1))


# Set number of replications
times = 10

# Run benchmarks for lme4
for (i in sizes) {
  res <- microbenchmark(
    reml_2 = lme4_reml2 <- lmer(y ~ by + gender + (1 | id2), data = eval(parse(text = i)), REML = TRUE),
    ml_2 = lme4_ml2 <- lmer(y ~ by + gender + (1 | id2), data = eval(parse(text = i)), REML = FALSE),
    reml_3 = lme4_reml3 <- lmer(y ~ by + gender + (1 | id3) + (1 | id2), data = eval(parse(text = i)), REML = TRUE),
    ml_3 = lme4_ml3 <- lmer(y ~ by + gender + (1 | id3) + (1 | id2), data = eval(parse(text = i)), REML = FALSE),
    times = times
  )
  assign(
    paste0("lme4_", i),
    data.frame(type = res$expr, time = res$time/1e9, data = i, package = "lme4")
  )
}


# Put everything into one data frame
R_test_data <- rbind(lme4_Small, lme4_Medium, lme4_Large)

# save write test results to file
write_feather(R_test_data, "R_test_data.feather")
