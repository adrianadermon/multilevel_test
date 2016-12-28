library(feather)
library(haven)
library(ggplot2)
library(dplyr)
library(tidyr)
library(stringr)
library(forcats)

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


df %>% 
  group_by(package, type, levels, data) %>% 
  summarise(time = 100*median(time)) %>% 
  ungroup() %>% 
  ggplot(aes(x = data, y = time, fill = package)) + 
  geom_bar(stat = "Identity", position = "dodge") +
  geom_text(aes(label = round(time/100)), position = position_dodge(width = 0.9), hjust = 1) +
  facet_wrap(~type + levels) +
  coord_flip() + 
  scale_y_log10() +
  theme(legend.position = "bottom")





tt <- theme_grey() + theme(panel.background = element_blank(),
                           panel.grid = element_blank(),
                           strip.background = element_blank(),
                           axis.title.x = element_blank(),
                           axis.title.y = element_blank(),
                           legend.position = "none"
)

theme_set(tt)

df_R %>% 
  separate(type, c("method", "levels"), sep = "_") %>% 
  group_by(method, levels, data) %>% 
  summarise(time = median(time)) %>% 
  ungroup %>% 
  ggplot(aes(y = time, x = data, fill = data)) +
  facet_grid(method ~ levels) +
  geom_bar(stat = "identity") + 
  coord_flip()


df_R %>% 
  separate(type, c("method", "levels"), sep = "_") %>% 
  group_by(method, levels, data) %>% 
  summarise(time = median(time)) %>% 
  ungroup %>% 
  ggplot(aes(y = time, x = method, fill = data)) +
  facet_grid(data ~ levels) +
  geom_bar(stat = "identity") + 
  coord_flip()


df_R %>% 
  separate(type, c("method", "levels"), sep = "_") %>% 
  group_by(method, levels, data) %>% 
  summarise(time = median(time)) %>% 
  ungroup %>% 
  ggplot(aes(y = time, x = levels, fill = method)) +
  geom_bar(stat = "identity", position = "dodge") + 
  facet_wrap(~data)


df_R %>% 
  separate(type, c("method", "levels"), sep = "_") %>% 
  group_by(method, levels, data) %>% 
  summarise(time = median(time)) %>% 
  ungroup %>% 
  ggplot(aes(y = time, x = data, fill = method, alpha = levels)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme(legend.position = "bottom")

