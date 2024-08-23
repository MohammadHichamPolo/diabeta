#__________________________________LIBRARIES____________________________________
library(shiny)
library(shinythemes)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(tidyverse)
library(shinyWidgets)
library(multcomp)
library(agricolae)
library(dplyr)
library(bslib)
#__________________________________OUTER CODE___________________________________
###____________________________________ANOVA____________________________________
col1 <- "Night blood glucose level (Previous day)"
col2 <- "Fasting morning Blood glucose level"
col3 <- "Blood glucose level during breakfast"
col4 <- "Blood glucose level 1h after breakfast"