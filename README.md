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
* Add the package in your ros workspace along the *trooper_gazebo* and *trooper_description*
package.
* Compile everything
* And use your fresh installation. For that go to **USAGE**

# Docker
To test it out, you can also mount the dockerfile by launching the script *install.sh*.
Before doing so, you need to specify your workspace from your host, so that you can make further developments from your host.

#USAGE
./launch_gazebo  --> Start a gazebo simulation with a functionnal 3d model of robot trooper. A 2 axis virtual controller allows steering the robot.

./launch_rviz    --> Start a rviz simulation with trooper. A publisher allows to control each joint independantly.
