library(tidyverse)


xpto <-
  read.csv(file = './datasets/sample_dataset.csv')

head(xpto)

xpto %>%
  group_by(Gender)
