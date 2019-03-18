library("ggplot2")
library("RColorBrewer")

#x <- dat_raw[, 1]
#y <- dat_raw[, 2]
#x_truth <- dat_raw[,4]
#y_truth <- dat_raw[,5]

dat_plot = dat_raw
dat_plot[,1] = dat_plot[,1] - dat_plot[1,1]
dat_plot[,2] = dat_plot[,2] - dat_plot[1,2]

dat_plot[1,3] = dat_plot[2,3]
dat_plot[1,4] = dat_plot[2,4]
dat_plot[1,5] = dat_plot[2,5]
dat_plot[,3] = dat_plot[,3] - dat_plot[1,3]
dat_plot[,4] = dat_plot[,4] - dat_plot[1,4]
dat_plot[,5] = dat_plot[,5] - dat_plot[1,5]

mycolors<-brewer.pal(9,"YlGnBu")

# https://ggplot2.tidyverse.org/reference/geom_path.html
ggplot(dat_plot) +
  geom_path(aes(x = y_slam, y = x_slam, color = mycolors[5])) +
  geom_path(aes(x = y_odom, y = x_odom, color = mycolors[6])) +
  guides(color=guide_legend(title="Data")) +
  scale_colour_discrete(labels = c('Hector_Improv','Ground_Truth'))