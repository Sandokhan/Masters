# Load the ggplot2 package as well
library(gapminder)
library(ggplot2)
library(dplyr)


# Summarize the median GDP and median life expectancy per continent in 2007
by_continent_2007 <-
  gapminder %>%
  group_by(year,continent) %>%
  summarize(medianLifeExp = median(lifeExp), medianGdpPercap= median(gdpPercap))

# Use a scatter plot to compare the median GDP and median life expectancy
ggplot(by_continent_2007, aes(x= year, y=medianLifeExp, color=continent)) +
  geom_line() +
  expand_limits(y = 0)

# Summarize the median gdpPercap by year, then save it as by_year
by_year <-
  gapminder %>%
  group_by(year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap over time
ggplot(by_year, aes(x = year, y = medianGdpPercap)) +
  geom_line() +
  expand_limits(y = 0)