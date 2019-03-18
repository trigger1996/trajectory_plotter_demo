library("ggplot2")

# load data from ORB-SLAM2
x_slam <- MH01_Easy_CameraTrajectory[, 2]
y_slam <- MH01_Easy_CameraTrajectory[, 3]
z_slam <- MH01_Easy_CameraTrajectory[, 4]

q <- list()
q[1:4] <- MH01_Easy_CameraTrajectory[, 5:8]
#q[[1]]

dat_esti <- data.frame(x_slam <- x_slam, y_slam <- y_slam, z_slam <- z_slam)

# load data from estimated ground_truth
#for (i in 1 : dim(MH01_Easy_ground_truth[]))

x_truth <- MH01_Easy_GroundTruth[,2]
y_truth <- MH01_Easy_GroundTruth[,3]
z_truth <- MH01_Easy_GroundTruth[,4]

dat_truth <- data.frame(x_truth <- x_truth, y_truth <- y_truth, z_truth <- z_truth)

#ggplot(dat_esti) +
#  geom_path(aes(x = x_slam, y = y_slam))

#ggplot(dat_truth) +
#  geom_path(aes(x = -x_truth, y = -y_truth))





# 暴力画图，slam的采样率低，那就画完以后一直在最后画最后一个点
x_slam_extended = array()
y_slam_extended = array()
z_slam_extended = array()
start = length(x_slam) + 1 
len = length(x_slam) * 10
for (i in 1 : len) {
  if (i <= start) {
    x_slam_extended[i] = x_slam[i]
    y_slam_extended[i] = y_slam[i]
    z_slam_extended[i] = z_slam[i]
  } else {
    x_slam_extended[i] = x_slam[start - 1]
    y_slam_extended[i] = y_slam[start - 1]
    z_slam_extended[i] = z_slam[start - 1]  
  }
}

# 这个时候应该是slam的点的数量多于ground_truth
x_truth_extended = array()
y_truth_extended = array()
z_truth_extended = array()
start = length(x_truth) + 1
len = length(x_slam) * 10
for (i in 1 : len) {
  if (i <= start) {
    x_truth_extended[i] = x_truth[i]
    y_truth_extended[i] = y_truth[i]
    z_truth_extended[i] = z_truth[i]
  } else {
    x_truth_extended[i] = x_truth[start - 1]
    y_truth_extended[i] = y_truth[start - 1]
    z_truth_extended[i] = z_truth[start - 1]  
  }
}

x_slam_extended = x_slam_extended - x_slam_extended[1]
y_slam_extended = y_slam_extended - y_slam_extended[1]
#z_slam_extended = z_slam_extended - z_slam_extended[1]
z_slam_extended = z_slam_extended + abs(y_slam_extended[which.min(y_slam_extended)])

x_truth_extended = x_truth_extended - x_truth_extended[1]
y_truth_extended = y_truth_extended - y_truth_extended[1]
#z_truth_extended = z_truth_extended - z_truth_extended[1]
z_truth_extended = z_truth_extended + abs(z_truth_extended[which.min(z_truth_extended)])

#x_slam_extended = -x_slam_extended
#y_slam_extended = -y_slam_extended

dat_extended <- data.frame( x_slam_extended,  y_slam_extended,  Zslam  <- z_slam_extended, 
                            x_truth_extended, y_truth_extended, Ztruth <- z_truth_extended)


mycolors<-brewer.pal(9,"YlGnBu")
# https://ggplot2.tidyverse.org/reference/geom_path.html
ggplot(dat_extended) +
  geom_path(aes(x = y_slam_extended, y = x_slam_extended, color = "red")) +
  geom_path(aes(x = x_truth_extended, y = y_truth_extended, color = "blue")) +
  guides(color=guide_legend(title="data_type")) +    ## 如果是NULL, 就是对color产生的图例去掉标题
  scale_colour_discrete(labels = c('orb-slam2','ground truth'))

ggplot(dat_extended) +
  geom_path(aes(x = y_slam_extended, y = x_slam_extended,   color = Zslam))

# https://blog.csdn.net/songzhilian22/article/details/49388677/
ggplot(dat_extended) +
  geom_path(aes(x = y_slam_extended, y = x_slam_extended)) +
  geom_path(aes(x = x_truth_extended, y = y_truth_extended, color = Ztruth)) + 
  scale_color_gradientn(colours = terrain.colors(10))

ggplot(dat_extended) +
  geom_path(aes(x = y_slam_extended, y = x_slam_extended, color = Zslam)) +
  geom_path(aes(x = x_truth_extended, y = y_truth_extended, color = Ztruth)) + 
  scale_color_gradientn(colours = terrain.colors(10))

ggplot(dat_extended) +
  geom_path(aes(x = y_slam_extended, y = x_slam_extended)) +
  geom_path(aes(x = x_truth_extended, y = y_truth_extended, color = Ztruth)) + 
  scale_color_gradient2(low = 'blue', high = 'red', midpoint = 150)
