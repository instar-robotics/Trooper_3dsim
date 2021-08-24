# Requirements
* Having ROS 1 installed
* Having gazebo, RVIZ installed
* Some needed packages:
```
ros-noetic-rviz
ros-noetic-rqt
ros-noetic-rqt-common-plugins
ros-noetic-gazebo-ros-pkgs
ros-noetic-rqt-robot-steering
ros-noetic-gazebo-ros-control
ros-noetic-robot-state-publisher
ros-noetic-xacro
ros-noetic-joint-state-controller
ros-noetic-position-controllers
ros-noetic-diff-drive-controller
ros-noetic-urdf-tutorial
```
* You also need to install the velodyne package
```
git clone https://bitbucket.org/DataspeedInc/velodyne_simulator.git
```

# Installation
* Create a ROS workspace, for instance:
```
mkdir -p catkin_ws/src
cd catkin_ws
catkin_make
```

* Add the velodyne packages (description and plugin) in your ros workspace along the *trooper_gazebo* and *trooper_description*
package.
* Compile everything
```
cd ~/catkin_ws
catkin_make
source ./devel/setup.bash
```
* And use your fresh installation. For that go to **USAGE**

# Docker
To test it out, you can also mount the dockerfile by launching the script *install.sh*.
Before doing so, you need to specify your workspace from your host, so that you can make further developments from your host.

# USAGE
./launch_gazebo  --> Start a gazebo simulation with a functionnal 3d model of robot trooper. A 2 axis virtual controller allows steering the robot.

./launch_rviz    --> Start a rviz simulation with trooper. A publisher allows to control each joint independantly.

# NOTES
* Currently, the launch file are using trooper.urdf.xacro file but you can also use
the simple .urdf file.
* I did not modify the *gazebo_labo.launch* file.
* You can add the vizualization of your lidar in gazebo
* Don't forget to change the published topic name of your cloud to be able to use_gui
it with your other nodes!
