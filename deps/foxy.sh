#/usr/bin/env bash

export ROS_DISTRO=foxy

sudo apt-get update
sudo apt-get install -y --no-install-recommends --allow-unauthenticated \
     locales \
     curl \
     gnupg2 \
     lsb-release \
     libflann-dev \
     libpcl-dev \
     libboost-all-dev \
     libeigen-stl-containers-dev \
     libqhull-dev \
     librosconsole-bridge-dev \
     libccd-dev \
     python3-pykdl \
     doxygen \
     redis-tools \
     redis-server \
    && apt-get autoclean \
    && apt-get autoremove

sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# setup keys
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg

# setup sources.list
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

# install ros2 packages
sudo apt-get update

sudo apt-get install -y --no-install-recommends ros-${ROS_DISTRO}-desktop \
     ros-${ROS_DISTRO}-cv-bridge \
     ros-${ROS_DISTRO}-ament-*

sudo pip3 install pytest --upgrade
sudo apt-get install -y python3-colcon-common-extensions \
     python3-vcstool

echo "\033[33mInstalled ROS ${ROS_DISTRO} \033[0m"
