install.packages("ggplot2")
require(ggplot2)
install.packages("dplyr")
require(dplyr)
data("diamonds")
names(diamonds)
glimpse(diamonds)

diamonds %>% ggplot(aes(x=carat , y = price, color = cut))+
  geom_point(alpha=0.25)+
  theme_bw()

diamonds %>%
  ggplot(aes(x=carat, y = price, color = cut))+
  geom_point(alpha=0.25)+
  facet_grid((faces=.~cut))+
  scale_y_log10()+
  scale_color_manual("corte", values = c("red",
                                         "blue",
                                         "purple",
                                         "yellow",
                                         "green"
    
  ))

