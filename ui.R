  ui <- fluidPage(theme = bslib::bs_theme(
    version = 4,
    bg = "#1a1a2e",  # Very dark background
    fg = "#e4e4f0",  # Light text
    primary = "#6A5ACD",  # Slate Blue
    secondary = "#2C2C54",  # Dark Gray for accents
    base_font = "Helvetica, Arial, sans-serif",  # Fallback to system fonts
    heading_font = "Verdana, Geneva, sans-serif"  # Fallback to system fonts
  ),
                tags$head(
                  tags$link(rel = "stylesheet", type = "text/css", href = "gradient.css"),
                  tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css")# Link the gradient CSS file
                ),
                navbarPage(
                  title = div(img(src = "logo_diabeta.png", height = "30px"), "from Janovapp"),
                  tabPanel("Introduction",
                           sidebarLayout(
                             sidebarPanel(
                               h1("Upload your data for further analysis"),
                               h4("For seamless analysis, please ensure your datasets are correctly formatted as CSV files. The app supports the following data inputs:"),
                               fileInput("datafile1", "Upload your CSV file to analyze nutrient composition and patterns :",
                                         accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                               fileInput("datafile2", "Import your CSV file to investigate variations and correlations in stress :",
                                         accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                               fileInput("datafile3", "Provide your glucose measurements in CSV format for detailed statistical assessment :",
                                         accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv"))
                             ),
                             mainPanel(
                               h2("Interactive Analysis of Diabetes-Related Data"),
                               p("Our platform offers a comprehensive workflow for analyzing diabetes-related data, focusing on key factors such as nutrient intake, stress levels, and glucose blood levels. The app is designed to provide robust statistical analysis and data visualization tools, facilitating the exploration and interpretation of complex datasets."),
                               
                               h3("🚀 Getting Started:"),
                               
                               h4("1. Watch the Quick Start Video:"),
                               p("Dive right in with our step-by-step tutorial. This short video will walk you through everything you need to know to get started, from importing your data to generating insightful visualizations."),
                               
                               # Embedded YouTube Video
                               tags$iframe(
                                 src = "diabetavideo.mp4",  
                                 width = "560", height = "315", frameborder = "0",
                                 allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture ; fullscreen",
                                 allowfullscreen = "allowfullscreen"
                               ),
                               
                               h4("2. Download the Google Sheets Template:"),
                               p("We've prepared a structured template to ensure your data is correctly formatted. Click the link below to access the template, make a copy, and start entering your data."),
                               
                               # Link to Google Sheets Template
                               tags$a(href = "https://docs.google.com/spreadsheets/d/1Ej_6PBFx4pqYEv_2VbgJ7stdpmkrNwEaSI1FOin0VaU/edit?usp=sharing", target = "_blank", "👉 Download Google Sheets Template"),
                               
                               h4("3. Explore the Features:"),
                               p("Navigate through the tabs to explore various analytical tools and visualizations. Our intuitive interface makes it easy to uncover trends, compare nutrient intake, and gain deeper insights into your dietary patterns."),
                               p("1. Nutrient Intake Analysis: Utilize an interactive stacked bar plot to examine and compare the intake of various nutrients across different conditions or time periods."),
                               p("2. Stress Levels Variation: Analyze the variation in stress levels and its potential impact on diabetes management."),
                               p("3. Glucose Blood Levels Assessment: Evaluate the normality and distribution of glucose levels through rigorous statistical methods."),
                               p("4. Statistical Testing: Conduct ANOVA and Tukey's post-hoc tests to determine significant differences between groups."),
                               h3("✨ Why Use DIABETA"),
                               
                               p(tags$b("User-Friendly:"), " Designed with simplicity in mind, no advanced technical skills required."),
                               p(tags$b("Customizable Visuals:"), " Tailor the charts and graphs to your preferences, making data interpretation a breeze."),
                               p(tags$b("Data Security:"), " Your data stays with you. We prioritize your privacy and do not store any of your uploaded files.")
                             )
                           ),
                           tags$footer(
                             div(
                               style = "display: flex; justify-content: center; align-items: center; background: linear-gradient(to right, #1a1a2e, #6A5ACD); color: #e4e4f0; padding: 10px; font-size: 12px;",
                               p("© 2024 JANOVAPP. All rights reserved. Created by Mohammad HICHAM POLO.", style = "margin: 0 15px;"),
                               a(href = "https://www.linkedin.com/in/mohammad-hicham-polo-071043269/", target = "_blank", 
                                 tags$i(class = "fab fa-linkedin fa-2x", style = "color: white; margin-right: 5px;"), # Larger LinkedIn icon in white
                                 tags$span("LinkedIn", style = "font-size: 18px; color: white;")
                               ),
                               p(" | ", style = "margin: 0 10px;"),
                               tags$i(class = "fas fa-phone-alt fa-lg", style = "color: white; margin-right: 5px;"),
                               span("+212 651025852", style = "font-size: 18px; color: white;")
                             )
                           )
                           
                           
                           
                           
                  ),
                  ###______________Nutrient Intake's Interactive Stacked Bar Plot_________________
                  tabPanel("Nutrient Intake's Interactive Stacked Bar Plot",
                           sidebarLayout(
                             sidebarPanel(
                               tags$h1("Graph Interaction General Panel:"),
                               tags$h4("Feel free to interact with the nutrient intake result's graph"),
                               radioButtons("stackOrder", "Stacking Order:",
                                            choices = c("Low to High" = "asc",
                                                        "High to Low" = "desc")),
                               
                               pickerInput("colorScheme", "Choose Color Scheme:",
                                           choices = list("Default" = "default",
                                                          "Rainbow" = "rainbow",
                                                          "Viridis" = "viridis"),
                                           selected = "default",
                                           options = list(style = "btn-primary")),
                               
                               radioButtons("barType", "Bar Type:",
                                            choices = c("Stacked" = "stack",
                                                        "Side by Side" = "dodge")),
                               
                               checkboxInput("showPercentage", "Show Percentage?", TRUE)
                             ),
                             mainPanel(
                               tags$h1("RESULT"),
                               plotOutput("stackedBarPlot")
                             )
                           ),
                           tags$footer(
                             div(
                               style = "display: flex; justify-content: center; align-items: center; background: linear-gradient(to right, #1a1a2e, #6A5ACD); color: #e4e4f0; padding: 10px; font-size: 12px;",
                               p("© 2024 JANOVAPP. All rights reserved. Created by Mohammad HICHAM POLO.", style = "margin: 0 15px;"),
                               a(href = "https://www.linkedin.com/in/mohammad-hicham-polo-071043269/", target = "_blank", 
                                 tags$i(class = "fab fa-linkedin fa-2x", style = "color: white; margin-right: 5px;"), # Larger LinkedIn icon in white
                                 tags$span("LinkedIn", style = "font-size: 18px; color: white;")
                               ),
                               p(" | ", style = "margin: 0 10px;"),
                               tags$i(class = "fas fa-phone-alt fa-lg", style = "color: white; margin-right: 5px;"),
                               span("+212 651025852", style = "font-size: 18px; color: white;")
                             )
                           )
                           
                           
                           
                           
                           
                           
                  ),
                  ###_________________________stress levels variation_____________________________
                  tabPanel("stress levels variation",
                           sidebarLayout(
                             sidebarPanel(
                               tags$h1("Stress Graph Interaction Panel:"),
                               tags$h4("Feel free to interact with the label's order and other features"),
                               selectInput("dotcolor", label = "Select the color of the dots :",
                                           choices = list("Red"="red", "Black"="black","Blue"="blue", "Green"="green","Yellow" = "yellow", "Pink"="pink","Purple" = "purple" , "Grey"="grey"),
                                           selected = "blue"),
                               sliderInput("dotsize", "Size of the dots",
                                           min = 1, max = 5,
                                           value = 2),
                               selectInput("linecolor", label = "Select the color of the lines :",
                                           choices = list("Red"="red", "Black"="black","Blue"="blue", "Green"="green","Yellow" = "yellow", "Pink"="pink","Purple" = "purple" , "Grey"="grey"),
                                           selected = "blue"),
                               checkboxInput("showfequency", "Show Frequency?", TRUE)  # Set default to TRUE
                             ),
                             mainPanel(
                               tags$h1("RESULT"),
                               plotOutput("scatterplotstress"),
                               plotOutput("freqplotstress"),
                               verbatimTextOutput("debugOutput")
                             )
                           ),
                           tags$footer(
                             div(
                               style = "display: flex; justify-content: center; align-items: center; background: linear-gradient(to right, #1a1a2e, #6A5ACD); color: #e4e4f0; padding: 10px; font-size: 12px;",
                               p("© 2024 JANOVAPP. All rights reserved. Created by Mohammad HICHAM POLO.", style = "margin: 0 15px;"),
                               a(href = "https://www.linkedin.com/in/mohammad-hicham-polo-071043269/", target = "_blank", 
                                 tags$i(class = "fab fa-linkedin fa-2x", style = "color: white; margin-right: 5px;"), # Larger LinkedIn icon in white
                                 tags$span("LinkedIn", style = "font-size: 18px; color: white;")
                               ),
                               p(" | ", style = "margin: 0 10px;"),
                               tags$i(class = "fas fa-phone-alt fa-lg", style = "color: white; margin-right: 5px;"),
                               span("+212 651025852", style = "font-size: 18px; color: white;")
                             )
                           )
                           
                           
                           
                           
                  ),
                  ###____Normality and Distribution of glucose blood levels in measurements_______
                  tabPanel("Distribution's normality of glucose blood levels and testing",
                           sidebarLayout(
                             sidebarPanel(
                               tags$h1("General Panel:"),
                               tags$h4("Select your data and customize your outputs:"),
                               selectInput("glucose_column", label = "Select the period:",
                                           choices = list(
                                             "Night blood glucose level (Previous day)" = "Night blood glucose level (Previous day)",
                                             "Fasting morning Blood glucose level" = "Fasting morning Blood glucose level",
                                             "Blood glucose level during breakfast" = "Blood glucose level during breakfast",
                                             "Blood glucose level 1h after breakfast" = "Blood glucose level 1h after breakfast"
                                           )),
                               checkboxInput("showmean", "Show Mean?", FALSE),
                               sliderInput("bins", "Bar plot bins width variation slider:",
                                           min = 1, max = 50, value = 10),
                               sliderInput("graphs", "Graphs per line:",
                                           min = 1, max = 3, value = 1),
                               checkboxInput("compare", "Compare with universal mean:", FALSE),
                               selectInput("glucose_compare", label = "Select value for comparison:",
                                           choices = list(
                                             "Fasting maximal value 100mg/dL" = 100,
                                             "Postprandial maximal value 140mg/dL" = 140
                                           ), selected = 140),
                               tags$h4("α = 0,05")
                             ),
                             mainPanel(
                               tags$h1("RESULT"),
                               plotOutput(outputId = "arranged"),
                               verbatimTextOutput("shapiro"),
                               verbatimTextOutput("ttest")
                             )),
                           tags$footer(
                             div(
                               style = "display: flex; justify-content: center; align-items: center; background: linear-gradient(to right, #1a1a2e, #6A5ACD); color: #e4e4f0; padding: 10px; font-size: 12px;",
                               p("© 2024 JANOVAPP. All rights reserved. Created by Mohammad HICHAM POLO.", style = "margin: 0 15px;"),
                               a(href = "https://www.linkedin.com/in/mohammad-hicham-polo-071043269/", target = "_blank", 
                                 tags$i(class = "fab fa-linkedin fa-2x", style = "color: white; margin-right: 5px;"), # Larger LinkedIn icon in white
                                 tags$span("LinkedIn", style = "font-size: 18px; color: white;")
                               ),
                               p(" | ", style = "margin: 0 10px;"),
                               tags$i(class = "fas fa-phone-alt fa-lg", style = "color: white; margin-right: 5px;"),
                               span("+212 651025852", style = "font-size: 18px; color: white;")
                             )
                           )
                           
                           
                           
                           
                           
                           
                  ),
                  ###_______________ANOVA test of all measurements distribution___________________
                  tabPanel("ANOVA test and Tukey",
                           sidebarLayout(
                             sidebarPanel(
                               tags$h1("General Panel:"),
                               tags$h4("ANOVA test and Tukey analysis of all measurements distributions"),
                               checkboxInput("pvalue", "Show P-value correspending to the significance of difference in questions ?"),
                               tags$h4("α = 0,05")
                             ),
                             mainPanel(
                               plotOutput(outputId = "TUKEY"),
                               tableOutput("pvalues")
                             )
                           ),
                           tags$footer(
                             div(
                               style = "display: flex; justify-content: center; align-items: center; background: linear-gradient(to right, #1a1a2e, #6A5ACD); color: #e4e4f0; padding: 10px; font-size: 12px;",
                               p("© 2024 JANOVAPP. All rights reserved. Created by Mohammad HICHAM POLO.", style = "margin: 0 15px;"),
                               a(href = "https://www.linkedin.com/in/mohammad-hicham-polo-071043269/", target = "_blank", 
                                 tags$i(class = "fab fa-linkedin fa-2x", style = "color: white; margin-right: 5px;"), # Larger LinkedIn icon in white
                                 tags$span("LinkedIn", style = "font-size: 18px; color: white;")
                               ),
                               p(" | ", style = "margin: 0 10px;"),
                               tags$i(class = "fas fa-phone-alt fa-lg", style = "color: white; margin-right: 5px;"),
                               span("+212 651025852", style = "font-size: 18px; color: white;")
                             )
                           )
                           
                           
                           
                  )
                  
                ) # navbarPage
                ####_______________________________UIFINISH_____________________________________
)