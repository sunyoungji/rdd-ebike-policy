# RDD Analysis of a Free E-Bike Policy and Student Performance

This repository contains R code for evaluating the causal effect of a free e-bike policy on student academic performance using a Regression Discontinuity Design (RDD). 

---

## Overview

This study applies a Regression Discontinuity Design (RDD) to estimate the causal effect of a free bicycle policy on students' academic performance. Under the policy, students living within 5 kilometers of school are eligible to receive a bicycle, which creates a sharp cutoff for identifying treatment and control groups. The analysis focuses on students near this threshold and finds that those who received a bicycle scored, on average, 0.98 points higher on their exams than those who did not. This project was completed as part of the **Causality and Programme Evaluation** course at Universität Duisburg-Essen.

---

## required libraries

- **`rddtools`**: Provides a complete workflow for RDD analysis, including data preparation, visualisation, estimation of treatment effects, sensitivity analysis and placebo testing. It supports both sharp and fuzzy designs.

- **`rdd`**: Offers core estimation tools for RDD using local linear regression. It includes functions for estimating treatment effects, selecting optimal bandwidths and testing for sorting violations near the cutoff (McCrary test).

---

## Data

| Variable           | Description                                          | Type     |
|--------------------|------------------------------------------------------|----------|
| `distance`         | Distance to school (in km)                           | Numeric  |
| `free_bicycle`     | 1 if student received a bike, 0 otherwise            | Binary   |
| `score`            | Student's exam score                                 | Numeric  |
| `income_hh`        | Household income                                     | Numeric  |
| `edu_maternal`     | Mother's education level (0 = high school, 3 = MSc)  | Ordinal  |
| `number_roomates`  | Number of flatmates                                  | Integer  |
| `age`              | Age of student                                       | Integer  |

> **Note:** Treatment is assigned based on whether `distance < 5`.  
> Covariates such as household income, maternal education, and number of roommates are included in the model for robustness.
