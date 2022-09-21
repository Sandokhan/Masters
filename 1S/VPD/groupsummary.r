# Load the ggplot2 package as well
library(gapminder)
library(ggplot2)
library(dplyr)

# Summarize to find the median life expectancy
gapminder |>
  summarize(meanLifeExp = median(lifeExp))

# Filter for 1957 then summarize the median life expectancy
gapminder %>%
  filter(year == 1957) %>%
  summarize(medianLifeExp = median(lifeExp))

# Filter for 1957 then summarize the median life expectancy and the maximum GDP per capita
gapminder %>%
  filter(year == 1957) %>%
  summarize(medianLifeExp = median(lifeExp), 
            maxGdpPercap = max(gdpPercap))


gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp), 
            maxGdpPercap = max(gdpPercap))