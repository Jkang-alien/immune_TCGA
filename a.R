til_map <- read.delim('TILMap_TableS1.txt')
cluster <- read.delim('class_TCGA_combined.txt', sep = ' ')

summary(til_map)

library(dplyr)
lung <- til_map %>% 
  filter (Study == 'LUAD' | Study == 'LUSC')

colnames(cluster)
colnames(til_map)

head(lung$ParticipantBarcode, 5)

data <- merge(cluster, lung, by.x = 'ID', by.y = 'ParticipantBarcode', all = FALSE)

table(data$class, data$Immune.Subtype)
table(data$class, data$Global_Pattern)
library(ggplot2)
ggplot(data, aes(x = class, y = til_percentage)) +
  geom_boxplot() +
  scale_y_continuous(trans='log10')

ggplot(data, aes(x = class, y = Leukocyte.Fraction)) +
  geom_boxplot() +
  scale_y_continuous(trans='log10')
