# R for Data Science Chapter 1 - Data Visualization (ggplot2)

# Load tidyverse package ####
library(tidyverse)

# Install and load the palmerpenguins package
install.packages("palmerpenguins")
library(palmerpenguins)

# Install and load the ggthemes package (offers colorblind safe color palatte)
install.packages("ggthemes")
library(ggthemes)

# Display the penguins tibble
penguins

# Define the data and data mappings for x and y
# Include geom_point (geometric function to display points)
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y= body_mass_g)
) +
  geom_point()


# Add distinct global color to distinguish species of penguin
ggplot(
  data = penguins,
  mapping = aes(
    x = flipper_length_mm,
    y = body_mass_g,
    color = species
  )
) +
  geom_point()


# Add another layer using geom_smooth() with method = "lm" for linear model.
ggplot(
  data = penguins,
  mapping = aes(
    x = flipper_length_mm,
    y = body_mass_g,
    color = species
  )
) +
  geom_point() +
  geom_smooth(method = "lm")


# Specify local color and shape on geom_point geometric object
ggplot(
  penguins,
  aes(
    x = flipper_length_mm,
    y = body_mass_g
  )
) +
  geom_point(
    aes(
      color = species,
      shape = species)
    ) +
  geom_smooth(method = "lm")


# Add labels using labs() and use colorblind safe colors
ggplot(
  penguins, #data
  aes(x = flipper_length_mm, y = body_mass_g) #mapping
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimesions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()


# Clean Up ####
detach("package:palmerpenguins", unload = TRUE)
detach("package:tidyverse", unload = TRUE)
detach("package:ggthemes", unload = TRUE)
