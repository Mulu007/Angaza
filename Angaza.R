# Packages installation
library(tidyverse)
install.packages("pdftools")
library(pdftools)
library(lubridate)
library(janitor)
library(scales)
library(ggplot2)

# Project structure
dirs <- c(
  "angaza/data/raw",
  "angaza/data/cleaned",
  "angaza/data/outputs",
  "angaza/scripts",
  "angaza/visualizations",
  "angaza/docs"
)

# Create all folders at once
sapply(dirs, dir.create, recursive = TRUE, showWarnings = FALSE)

# KEMSA
kemsa_data <- tibble(
  month = seq(as.Date("2020-03-01"), 
              as.Date("2020-10-01"), 
              by = "month"),
  
  # Actual disbursements in KES millions
  # Source: Controller of Budget / AG Report
  actual_spend = c(
    180,   # March  — initial emergency release
    2100,  # April  — massive spike, irregular
    3200,  # May    — continued spike
    1800,  # June   — still elevated
    420,   # July   — sudden drop
    180,   # August — near stop
    95,    # September
    25     # October
  ),
  
  # What was actually delivered (PPE, equipment)
  # Source: Parliamentary committee findings
  delivery_value = c(
    160,   # March  — reasonable delivery
    800,   # April  — far below spend
    900,   # May    — far below spend
    750,   # June
    390,   # July
    170,   # August
    90,    # September
    20     # October
  ),
  
  project = "KEMSA COVID Procurement",
  total_budget = 7800,  # KES 7.8 Billion total
  county = "National"
)

# Quick look at what we have
glimpse(kemsa_data)
view(kemsa_data)

# S-Curve Baseline
