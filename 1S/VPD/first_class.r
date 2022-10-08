library(tidyverse)
library(readxl)
library(infotheo) ## a useful package
library(arules) # a package that also has a discretize function
library(discretization)
library(funModeling)

# Nominal and ordinal data in R
expenses <- 
  read_xlsx( './datasets/Member_Travel_Expenses.xlsx')
expenses <- 
  mutate (expenses , Destination = as.factor(Destination) , Purpose = as.factor(Purpose))
exp_num <- 
  select_if (expenses , is.numeric)
pairs(exp_num)

# Discretization

a <- c(13, 15, 16, 16, 19, 20, 21, 22, 22, 25, 30, 33, 35, 35, 36, 40, 45)
x1 <- discretize( a , disc = "equalwidth" , nbins = 4)
x2 <- discretize( a , disc = "equalfreq" , nbins = 4)
identical(x1 , x2)

# Load dataset
bank <- read_delim("./datasets/bank_data_short.csv", delim=";" , col_names = TRUE)

# equal width and equal frequency
discretize( bank$age, disc = "interval" , breaks = 3 )
discretize( bank$age, disc = "frequency" , breaks = 3 )

# add column with discretized value to the dataframe
bank$age_bin_ew <- as.vector ( discretize( bank$age, disc="interval", nbins=3 ) )

## scatter
ggplot(data = bank, aes(x=age, y=income)) +
  geom_point()

## boxplots
ggplot(data=bank, aes(x=age_bin_ew, y = income )) + 
  geom_boxplot()

# chiMerge in R
ds <- read_delim("./datasets/chi_squared.csv" , delim = ";" , col_names = TRUE)
chiM(data.frame(ds) , alpha = 0.1)

## gain ratio discretization
discretize_rgr(bank$age, bank$pep)
