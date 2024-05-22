library(reticulate)
library(dplyr)
library(tidyr)
library(ggplot2)
library(magrittr)
library(plotly)
library(shiny)
library(stringr)

row_data = read.csv("survey_results_2023.csv", sep=",")
data_selected <- na.omit(row_data %>% select(Age, YearsCode, 
                                       YearsCodePro))

data_selected <- data_selected[data_selected$YearsCodePro != "More than 50 years", ]
data_selected <- data_selected[data_selected$YearsCodePro != "Less than 1 year", ]
data_selected$YearsCodePro <- as.numeric(data_selected$YearsCodePro)
data_selected$YearsCode <- as.numeric(data_selected$YearsCode)
data_selected$Age <- str_wrap(data_selected$Age, width = 50)

data_selected <- na.omit(data_selected)

data_selected <- data_selected %>%
  group_by(Age, YearsCode, YearsCodePro) %>%
  mutate(Count = n()) %>%
  ungroup()

selected_samples <- data_selected %>% 
  sample_n(100, replace = FALSE)

ggplot(selected_samples, aes(x = YearsCode, y = YearsCodePro)) +
  geom_point(aes(size = Count, color = Age), alpha = 0.5) +
  scale_color_manual(values = c("#fbb4ae", "#b3cde3","#ccebc5", "#decbe4", "#fed9a6","#ffffcc", "#e5d8bd")) +
  scale_size(range = c(0.5, 12)) +
  theme_minimal() +
  theme(plot.title = element_text(size = 20, hjust = 0.5),
        axis.text.x = element_text(angle = 45, size = 11, hjust=1),
        axis.text.y = element_text(size = 11, face = "bold"),  
        axis.title = element_text(size = 14, face = "bold"), 
        axis.title.x = element_text(margin = margin(t = 20)),  
        axis.title.y = element_text(margin = margin(r = 20))
  ) +
  theme(legend.position= c(0.8, 0.2)) +
  guides(size = "none")

