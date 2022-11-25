setwd("C:/Users/hmz19/Desktop/YuKi's Projects/Self-Tagging/task/task1/R_code")
library(bruceR)
library(tidyverse)
raw <- bruceR::import("C:/Users/hmz19/Desktop/YuKi's Projects/Self-Tagging/task/task1/R_code/RawData.xlsx") %>%
  dplyr::select(Shape,Condition,rt, Exclude, Phase) %>%
  dplyr::filter(Exclude == 0) %>%
  dplyr::select(-Exclude) %>%
  dplyr::mutate(rt = as.numeric(rt),
                Target = (ifelse(Shape== "P1","self",
                         (ifelse(Shape == "P2", "partner", "stanger"))))) %>%
  dplyr::mutate(rt = round(rt,3)) %>%
  drop_na()








df <- raw %>%
  dplyr::group_by(Target,Condition,Phase) %>%
  dplyr::summarise(mean=mean(rt),sd=sd(rt)) %>%
  dplyr::mutate(mean = mean * 1000,
                sd = sd * 1000)

write.csv(df,"C:/Users/hmz19/Desktop/YuKi's Projects/Self-Tagging/task/task1/R_code/output.csv")
