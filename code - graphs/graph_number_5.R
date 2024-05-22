library(ggplot2)
library(dplyr)
library(stringr)

data_selected = read.csv('Stack_YearsCoding.csv', sep=",")

ggplot(data_selected, aes(x=StackOverflowVisit, y = StackOverflowHasAccount, color = Years_of_professional_coding)) + 
  geom_jitter() +
  scale_color_manual(values = c('#FF6978', '#6D435A', '#23395B')) +
  ggtitle("Stackoverflow users and their experience") +
  labs(y = "having an account", x = "how many visits") +
  theme_minimal() +
  theme(plot.title = element_text(size = 20, hjust = 0.5),
        axis.text.x = element_text(angle = 45, size = 11, hjust=1),
        axis.text.y = element_text(size = 11, face = "bold"),  
        axis.title = element_text(size = 14, face = "bold"), 
        axis.title.x = element_text(margin = margin(t = 20)),  
        axis.title.y = element_text(margin = margin(r = 20))
        ) +
  theme(legend.position="top")
