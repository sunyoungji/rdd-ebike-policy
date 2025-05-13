library(tidyverse)
library(dplyr)
library(readr)
library(rdd)
library(rddtools)

# setting

ebike <- read_csv("dataset1.csv")
ebike <- as_tibble(ebike)
view(ebike)
# edu_maternal: level of maternal education (for example 0 is high school and 3 is M.Sc.).
# neighborhood: this is the neighborhood ID the students live.
# income_hh: The income of the family of the student.
# number_roomates: With how many people the student shares with her flat.

# task(a)

threshold <- ggplot(ebike,
                    aes(x = distance, y = free_bicycle)) +
  geom_point() +
  labs(x = "Distance", y = "Free bicycle",
       title = ("The compliance with the 5km rule")) +

  theme(plot.title = element_text(hjust = 0.5)) +
  geom_vline(xintercept = 5, colour = "red",
             size = 1, linetype = "dashed") +

  annotate("text", x = 4, y = 1, label = "5km",
           size=4, color = "red")

# the graph above shows that the threshold separates the treatment and control group exactly → sharp RD

# task(b)

rdd_data <- rdd_data(x = ebike$distance, y = ebike$score,
                     covar = ebike$age + ebike$income_hh +
                       ebike$number_roomates + ebike$edu_maternal,
                     cutpoint = 5)

plot_rdd_data <- rdd_data %>%
  ggplot(aes(x, y)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_brewer(palette = "Accent") +
  guides(color = "none") +
  geom_vline(xintercept = 5, color = "red",
             size = 1, linetype = "dashed") +
  labs(y = "Exam Score",
       x = "Distance")

treated_rdd <- rdd_data(x = treated$distance, y = treated$score,
                        covar = treated$age + treated$income_hh +
                          treated$number_roomates + treated$edu_maternal,
                        cutpoint = mean(treated$distance))

control_rdd <- rdd_data(x = control$distance, y = control$score,
                        covar = control$age + control$income_hh +
                          control$number_roomates + control$edu_maternal,
                        cutpoint = mean(control$distance))

plot(treated_rdd)
plot(control_rdd)

plot_rdd_data <- rdd_data %>%
  ggplot(aes(x, y)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_brewer(palette = "Accent") +
  guides(color = "none") +
  geom_vline(xintercept = 5, color = "red",
             size = 1, linetype = "dashed") +
  labs(y = "Exam score",
       x = "Distance")


rdd_same <- rdd_data(x = ebike$distance, y = ebike$score,
           cutpoint = 5) %>%
  rdd_reg_lm(slope = "same") %>%
  summary() # D = 0.599

rdd_diff <- rdd_data(x = ebike$distance, y = ebike$score,
                     cutpoint = 5) %>%
  rdd_reg_lm(slope = "separate") %>%
  summary() # D = 0.634



# task(c)

# grouping
treated <- ebike %>% filter(free_bicycle == 1)
control <- filter(ebike, free_bicycle == 0)

# the probability to be assigned to treated group
prob_treated <- nrow(treated) / sum(nrow(treated) + nrow(control))

# histogram of score
score_hist <- ggplot(ebike, aes(score)) +
  geom_histogram(binwidth = 5)
