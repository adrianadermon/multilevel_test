library("rstan")
library("rstanarm")
library("bayesplot")

setwd("F:/Dropbox/Forskning/Software tests/Multilevel")

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())


x <- runif(100, 0, 1)
y <- abs(2 + 3*x + rnorm(100, 0, 1))
N <- 100

df <- data.frame(y, x)

d <- list(y, x, N)


fit1 <- stan_lm(y ~ x, data = df, prior = R2(location = 0.5, what = "mean"), iter = 1000, chains = 4)

fit2 <- stan_glm(y ~ x, data = df, family = gaussian(), prior = cauchy(), prior_intercept = cauchy(), iter = 1000, chains = 4)

fit <- stan(file = 'Rstan_test.stan', iter = 1000, chains = 4, cores = 4, data = d)

mcmc_areas(as.matrix(fit), pars = c("beta[1]", "beta[2]", "sigma"))

ppc_dens_overlay(y = fit$y, yrep = posterior_predict(fit, draws = 50))
