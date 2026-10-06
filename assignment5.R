setwd("~/be623_assignment5")
library(dplyr)
library(ggplot2)

circ_df <- data.frame(
  Sample = paste0("S", 1:12),
  Gene = c(
    rep("PER2", 6),
    rep("BMAL1", 6)
  ),
  ZT = c(
    0, 4, 8, 12, 16, 20,
    0, 4, 8, 12, 16, 20
  ),
  Expressio = c(
    1.8, 3.2, 6.5, 9.4, 7.1, 3.6,
    8.6, 5.9, 2.7, 1.5, 3.4, 6.8
  )
)
str(circ_df)
summary(circ_df)

per2_rows <- circ_df[circ_df$Gene == "PER2", ]
mean(per2_rows$expression)
median(per2_rows$expression)
sd(per2_rows$expression) # standard deviation
summary(per2_rows$expression)

write.csv(circ_df, "circadian_expression.csv", row.names = FALSE)
circ_reloaded <- read.csv("circadian_expression.csv")
str(circ_reloaded)
identical(circ_df$Expression, circ_reloaded$Expression)

per2_sorted <- circ_df %>%
  filter(Gene == "PER2") %>%
  arrange(desc(expression))

bmal1_sorted <- circ_df %>%
  filter(Gene == "BMAL1") %>%
  arrange(desc(expression))

library(ggplot2)
rhythm_plot <- ggplot(circ_df, aes(x = ZT, y = expression, color = Gene)) +
  geom_point(size = 3) +
  labs(
    title = "Gene Expression over Time",
    x = "ZT",
    y = "Expression",
    color = "Gene"
  )
rhythm_plot
ggsave("rhythm_plot.png", width = 6, height = 4, dpi = 300)

library(ggplot2)
expression_plot <- ggplot(circ_df, aes(x = Gene, y = expression, fill = Gene)) +
  geom_boxplot() +
  labs(
    title = "Expression distribution by Gene",
    x = "Gene",
    y = "Expression"
  )
expression_plot
ggsave("expression_plot.png", width = 6, height = 4, dpi = 300)
