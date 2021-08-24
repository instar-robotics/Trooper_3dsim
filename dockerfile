FROM ros:noetic

MAINTAINER Alexis Hou "alexis.hou@instar-robotics.com"

# Ajouter un utilisateur
RUN useradd -ms /bin/bash trooper

# Paramètre d'environnement
ENV HOME=/home/trooper
ENV INSTALL=$HOME/workspace/Bootstrap
ENV CONFIG=$INSTALL/configfile

WORKDIR $HOME
RUN mkdir $HOME/catkin_ws

# Dépendences à lancer en root
RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
 git-all \
 curl

RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
inetutils-ping \
vim \
findutils

RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
netplan.io \
wget

RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
unzip

RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
ros-noetic-rviz \
ros-noetic-rqt \
ros-noetic-rqt-common-plugins \
ros-noetic-gazebo-ros-pkgs \
ros-noetic-rqt-robot-steering \
ros-noetic-gazebo-ros-control \
ros-noetic-robot-state-publisher \
ros-noetic-xacro \
ros-noetic-joint-state-controller \
ros-noetic-position-controllers \
ros-noetic-diff-drive-controller \
ros-noetic-urdf-tutorial \
gedit \
gdb \
meld \
kate \
ctags \
exuberant-ctags

# Réduction de la taille de l'image
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
