library(tidyverse)
library(lubridate)


countries <- c("Portugal", "Belgium", "Germany") ## A vector with the countries to select. You can select other if you prefer.
ds_raw <-
    read_csv("https://opendata.ecdc.europa.eu/covid19/nationalcasedeath/csv/data.csv",
    col_types = "cccncncnncc") ## only for European countries

ds <- ds_raw %>%
    filter(country %in% countries) %>% ## select countries
    arrange(year_week) |>
    group_by(indicator,country) |>
    arrange(year_week) %>% ## to make sure it is sorted
    mutate(seq = row_number()) %>% ## sequential number
    mutate(wcases_pop = weekly_count / population) |>
    filter(seq > max(seq)-50) |>
    select(!c(source, note, continent)) %>% ## select all columns but 'source'
    rename(cum_count = cumulative_count) ## rename variable
## check the result of the instructions
ds
cts <- paste(countries, collapse = ', ')
ggplot(ds, aes(x=seq, y=wcases_pop, group=country, color=country)) +
  geom_line() +
  geom_point() +
  facet_wrap(vars(indicator), nrow=1, scales= 'free_y') +
  labs (x='Week of the year', y='Weekly per habitants', title = paste('Covid-19 cases and deaths - ', cts), 
        subtitle = paste("created on", Sys.Date(), 'by sdk')) +
  theme_bw() + 
  theme(
    plot.title = element_text(face = "bold", size = rel(1.5), color = 'blue', hjust = .5),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.justification = c(1, 1),
    legend.position = c(1, 1),
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )

