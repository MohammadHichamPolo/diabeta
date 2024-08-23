server <- function(input, output, session) {
  ###_______________________Critical blood test records___________________________
  selected_plots <- eventReactive(input$submitbutton, {
    # Get the selected plot variables
    plots <- lapply(list(input$plot1, input$plot2, input$plot3, input$plot4, input$plot5), function(x) {
      if (!is.null(x) && x != "") {
        get(x) # Retrieve the plot object by name
      } else {
        NULL
      }
    })
    # Filter out any NULL values (unselected plots)
    plots <- Filter(Negate(is.null), plots)
    return(plots)
  })
  
  output$arrange <- renderPlot({
    # Only render the plots if there are any valid selections
    if (length(selected_plots()) > 0) {
      grid.arrange(grobs = selected_plots(), ncol = input$ncol)
    }
  })
  
  ###______________Nutrient Intake's Interactive Stacked Bar Plot_________________
  # Reactive value to store processed data
  data_freq_reactive <- reactiveVal(NULL)
  
  # Observe file input and process data
  observeEvent(input$datafile1, {
    req(input$datafile1)
    nutrient_data <- read.csv(input$datafile1$datapath)
    
    # Replace spaces with dots in the column names (if necessary)
    colnames(nutrient_data) <- gsub(" ", ".", colnames(nutrient_data))
    
    # Ignore the Date column (the first column) when pivoting the data
    nutrient_data_long <- nutrient_data %>%
      pivot_longer(cols = -1,  # Ignore the first column (Date)
                   names_to = c("Nutrient", "Period"),
                   names_sep = "\\.")
    
    # Calculate frequencies and percentages
    data_freq <- nutrient_data_long %>%
      group_by(Period, Nutrient, value) %>%
      summarize(Frequency = n()) %>%
      ungroup() %>%
      group_by(Period, Nutrient) %>%
      mutate(Percentage = Frequency / sum(Frequency) * 100)
    
    # Save processed data in reactive value
    data_freq_reactive(data_freq)
  })
  
  # Reactive expression to filter data based on user input
  filtered_data <- reactive({
    data_freq <- data_freq_reactive()
    req(data_freq)  # Ensure data_freq is available
    
    data_freq <- data_freq %>%
      ungroup()
    
    data_freq$Period <- factor(data_freq$Period, levels = c("Breakfast", "Dinner", "Day")) 
    
    if (input$stackOrder == "desc") {
      data_freq$value <- factor(data_freq$value, levels = c("High", "Medium", "Low"))
    } else {
      data_freq$value <- factor(data_freq$value, levels = c("Low", "Medium", "High"))
    }
    
    return(data_freq)
  })
  
  
  # Render the plot based on user inputs
  output$stackedBarPlot <- renderPlot({
    color_palette <- switch(input$colorScheme,
                            "default" = c("#1f77b4", "#ff7f0e", "#2ca02c"),
                            "rainbow" = rainbow(3),
                            "viridis" = viridis::viridis(3))
    
    p <- ggplot(filtered_data(), aes(x = Period, y = Frequency, fill = value)) +
      geom_bar(stat = "identity", position = input$barType) +
      facet_grid(. ~ Nutrient, scales = "free", space = "free") +
      labs(title = "Nutrient Intake by Period",
           x = "Meal Period",
           y = "Frequency of Qualitative Values",
           fill = "Level") +
      theme_minimal() +
      scale_x_discrete() +
      scale_fill_manual(values = color_palette) +
      theme(
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 14, face = "bold"),
        axis.title.y = element_text(size = 14, face = "bold"),
        legend.position = "right",
        legend.title = element_text(size = 12, face = "bold"),
        legend.text = element_text(size = 12),
        strip.background = element_rect(fill = "lightgray", color = NA),
        strip.text = element_text(size = 12, face = "bold")
      )
    
    if (input$showPercentage) {
      p <- p + geom_text(aes(label = paste0(round(Percentage, 1), "%")), 
                         position = position_stack(vjust = 0.5), size = 4)
    }
    
    p
  })
  
  ###_________________________stress levels variation_____________________________
  stress_data_reactive <- reactive({
    req(input$datafile2)
    stress_data <- read_csv(input$datafile2$datapath)
    
    # Add Day column
    stress_data <- stress_data %>% mutate(Day = row_number())
    
    # Handle level order based on user input
    stress_data$Stress <- factor(stress_data$Stress, 
                                 levels = c("Better", "Normal", "Little stressed", "Very stressed"))
    
    # Convert levels to numeric
    stress_data$Stress_numeric <- as.numeric(stress_data$Stress)
    
    return(stress_data)
  })
  
  # Reactive Frequency Calculation
  stress_freq_reactive <- reactive({
    processed_data <- stress_data_reactive()
    
    stress_freq <- processed_data %>%
      group_by(Stress) %>%
      summarize(Frequency = n()) %>%
      mutate(Percentage = Frequency / sum(Frequency) * 100)
    
    return(stress_freq)
  })
  
  # Plot Output
  output$scatterplotstress <- renderPlot({
    processed_data <- stress_data_reactive()
    
    if (is.null(processed_data)) return(NULL)
    
    ggplot(processed_data, aes(x = Day, y = Stress_numeric, group = 1)) +
      geom_point(color = input$dotcolor, size = input$dotsize) +
      geom_line(color = input$linecolor) +
      scale_y_continuous(breaks = 1:4, labels = c("Better", "Normal", "Little stressed", "Very stressed")) +  # Étiquettes pour l'axe y
      labs(title = "Daily Stress Levels",
           x = "Day",
           y = "Stress Level") +
      theme_minimal() +  # Thème minimal pour un look épuré
      theme(
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),  # Centrer et mettre en gras le titre
        axis.text.x = element_text(size = 12),                             # Ajuster la taille des labels de l'axe x
        axis.text.y = element_text(size = 12),                             # Ajuster la taille des labels de l'axe y
        axis.title.x = element_text(size = 14, face = "bold"),             # Formatage du titre de l'axe x
        axis.title.y = element_text(size = 14, face = "bold")              # Formatage du titre de l'axe y
      )
  })
  
  output$freqplotstress <- renderPlot({
    if (isTRUE(input$showfequency)) {
      stress_freq <- stress_freq_reactive()
      
      ggplot(stress_freq, aes(x = Stress, y = Percentage)) +
        geom_bar(stat = "identity", fill = "lightblue") +
        geom_text(aes(label = paste0(round(Percentage, 1), "%")), vjust = -0.5, size = 5) +
        labs(title = "Stress Level Frequencies",
             x = "Stress Level",
             y = "Percentage") +
        theme_minimal() +  # Thème minimal pour un look épuré
        theme(
          plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),  # Centrer et mettre en gras le titre
          axis.text.x = element_text(size = 12),                             # Ajuster la taille des labels de l'axe x
          axis.text.y = element_text(size = 12),                             # Ajuster la taille des labels de l'axe y
          axis.title.x = element_text(size = 14, face = "bold"),             # Formatage du titre de l'axe x
          axis.title.y = element_text(size = 14, face = "bold")              # Formatage du titre de l'axe y
        )
    }
  })
  ###____Normality and Distribution of glucose blood levels in measurements_______
  glucose <- reactive({
    req(input$datafile3)
    read_csv(input$datafile3$datapath)
  })
  
  selected_glucose <- reactive({
    glucose()[[input$glucose_column]]
  })
  
  numeric_glucose <- reactive({
    data <- selected_glucose()
    if (!is.numeric(data)) {
      data <- as.numeric(data)
    }
    data
  })
  
  # Shapiro-Wilk Normality Test
  output$shapiro <- renderPrint({
    shapiro_test <- shapiro.test(numeric_glucose())
    shapiro_test
  })
  
  mean_value <- reactive({
    mean(numeric_glucose(), na.rm = TRUE)
  })
  
  plotQQ <- reactive({
    ggplot(glucose(), aes(sample = numeric_glucose())) +
      stat_qq() +
      stat_qq_line() +
      labs(title = paste("Q-Q Plot for", input$glucose_column),
           x = "Theoretical Quantiles",
           y = "Sample Quantiles") +
      theme_minimal()
  })
  
  plotHIST <- reactive({
    ggplot(glucose(), aes(x = numeric_glucose())) +
      geom_histogram(binwidth = input$bins, fill = "skyblue", color = "black", alpha = 0.7) +
      theme_minimal() +
      labs(title = paste("Distribution of", input$glucose_column),
           x = input$glucose_column,
           y = "Count") +
      theme(plot.title = element_text(hjust = 0,5, size = 12),
            axis.title.x = element_text(size = 14),
            axis.title.y = element_text(size = 14),
            axis.text = element_text(size = 12))
  })
  
  plotDENS <- reactive({
    plotDS <- ggplot(glucose(), aes(x = numeric_glucose())) +
      geom_density(fill = "lightgreen", alpha = 0.7) +
      theme_minimal() +
      labs(title = paste("Density Plot of", input$glucose_column, "with Mean"),
           x = input$glucose_column,
           y = "Density") +
      theme(plot.title = element_text(hjust = 0.5, size = 12),
            axis.title.x = element_text(size = 14),
            axis.title.y = element_text(size = 14),
            axis.text = element_text(size = 12))
    
    if (input$showmean) {
      plotDS <- plotDS + geom_vline(aes(xintercept = mean_value()), color = "blue", linetype = "dashed", size = 1) +
        annotate("text", x = mean_value(), y = Inf, label = paste("Mean =", round(mean_value(), 2)), 
                 vjust = -0.5, hjust = 1, color = "blue", size = 5)
    }
    plotDS
  })
  
  output$arranged <- renderPlot({
    grid.arrange(plotQQ(), plotHIST(), plotDENS(), ncol = input$graphs)
  })
  
  output$ttest <- renderPrint({
    if (input$compare) {
      t_test <- t.test(numeric_glucose(), mu = as.numeric(input$glucose_compare))
      t_test
    }
  })
  ###_______________ANOVA test of all measurements distribution___________________
  # Tukey Test and ANOVA Logic
  glucose_long <- reactive({
    glucose() %>%
      pivot_longer(cols = c(
        "Night blood glucose level (Previous day)",
        "Fasting morning Blood glucose level",
        "Blood glucose level during breakfast",
        "Blood glucose level 1h after breakfast"
      ), 
      names_to = "group", 
      values_to = "value")
  })
  
  anova_result <- reactive({
    aov(value ~ group, data = glucose_long())
  })
  
  tukey_result <- reactive({
    TukeyHSD(anova_result())
  })
  
  output$TUKEY <- renderPlot({
    df <- as.data.frame(tukey_result()$group)
    df$comparison <- rownames(df)
    
    df$significance <- ifelse(df$`p adj` < 0.05, "*", "")
    
    ggplot(df, aes(x = comparison, y = diff, ymin = lwr, ymax = upr)) +
      geom_pointrange() +
      geom_text(aes(label = significance), vjust = -1.5, hjust = 0.5, color = "red", size = 6) +  # Add asterisks to plot
      geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
      coord_flip() +
      theme_minimal() +
      labs(title = "Tukey HSD Post-Hoc Test",
           x = "Comparisons",
           y = "Difference in Means",
           caption = "95% confidence interval") +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
            axis.title.x = element_text(size = 14),
            axis.title.y = element_text(size = 14),
            axis.text = element_text(size = 12))
  })
  
  output$pvalues <- renderTable({
    if (input$pvalue) {
      df <- as.data.frame(tukey_result()$group)
      df <- df %>%
        mutate(comparison = rownames(df),
               `p adj` = format(`p adj`, scientific = FALSE, digits = 15),
               `p adj` = ifelse(`p adj` < 0.05, paste0(`p adj`, " *"), `p adj`)) %>%  # Add asterisks to significant p-values
        dplyr::select(comparison, upr, `p adj`)  # Use dplyr::select explicitly to avoid conflicts
      return(df)  # Return the data frame to be rendered as a table
    }
  })
  ####____________________________Server FINISH___________________________________
}