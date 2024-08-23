# Load the necessary packages
library(shiny)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(tidyverse)
library(shinyWidgets)
library(multcomp)
library(agricolae)
library(dplyr)
library(bslib)

# Source your app components
source("diaBeta_webapp/globals.R")
source("diaBeta_webapp/ui.R")
source("diaBeta_webapp/server.R")

# Run the Shiny app
shinyApp(ui = ui, server = server)
