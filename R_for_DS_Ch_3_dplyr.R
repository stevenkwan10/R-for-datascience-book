# Chapter 3 - Data Transformation ####
# dplyr package provides functions for data manipulation

# Install nycflights13
install.packages("nycflights13")

# Load tidyverse, nycflights13 packages
library(tidyverse)
library(nycflights13)

# filter() allows you to keep rows based on the values of the columns
# filter() not using pipe
filter(flights, dep_delay > 120)

# filter() using pipe
# filter flights that have origin of JFK and destination of LAX
flights |>
  filter(origin == "JFK" & dest == "LAX")

# filter flights that departed in January and February
flights |>
  filter(month == 1 | month == 2)

# Save results of filter to a variable
jan_departures = flights |>
  filter(month == 1)

# Print jan_departures (jan_departures is a tibble)
print(jan_departures)

# arrange() sorts the rows based on the columns names
# sort by month descending, if tie, sort by day ascending etc:
flights |>
  arrange(desc(month), day, dep_time)

# distinct() finds all the unique rows in a data set
# find all unique origin and destination pairs
flights |>
  distinct(origin, dest)

# if you want to keep all columns:
flights |>
  distinct(origin, dest, .keep_all = TRUE)



# Four functions that affect columns without changing rows ####

# mutate() adds new columns that are calculated from the existing columns
# returns a new tibble (i.e. does not mutate the original tibble)
# use .before or .after to specify where to place new column
flights |>
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )

# rename()

# relocate ()

# select() selects specific columns
flights |>
  select(origin, dest)

# Combining functions/verbs. Find the fastest flights to Houston IAH
# And sort by speed descending (highest speed first)
flights |>
  filter(dest == "IAH") |>
  mutate(speed = distance / air_time * 60) |>
  select(year:day, dep_time, carrier, flight, speed) |>
  arrange(desc(speed))


# group_by() and summarize() and arrange()
# from flights, group by month the average departure delay in descending order
# provide the count as column "n" using n()
flights |>
  group_by(month) |>
  summarize(
    delay = mean(dep_delay, na.rm = TRUE),
    n = n()
  ) |>
  arrange(desc(delay))


# Install Lahman (baseball stats) package
install.packages("Lahman")

# from the Lahman package save a table as "batters" group by playerID creating
# new columns `performance` (hits per at bat) and n (number of times at bat) 
batters <- Lahman::Batting |>
  group_by(playerID) |>
  summarize(
    performance = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    n = sum(AB, na.rm = TRUE)
  )

# print batters
print(batters)

# combining ggplot2 with dplyr ####
# filter batters where n is greater than 100
# then plot the data where xaxis is number of times at bat (n) and yaxis is performance
batters |>
  filter(n > 100) |>
  ggplot(
    aes(x = n, y = performance)
  ) +
  geom_point(alpha = 0.1) +  # make points more transparent
  geom_smooth(se = FALSE)   # remove shaded confidence ribbon


# Unload packages
detach("package:tidyverse", unload = TRUE)
detach("package:nycflights13", unload = TRUE)
detach("package:Lahman::Batting", unload = TRUE)

