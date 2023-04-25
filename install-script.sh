#!/bin/bash

# Request the sudo password
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

printf "\nThis script will install \n\nROS2 Humble\nGazebo Fortres\nNav2\n\n"

# Identify the Ubuntu version

ubuntu=$(lsb_release -r)
ubuntu_version=$(cut -f2 <<< "$ubuntu")

printf "You are running: Ubuntu $ubuntu_version.\n"
printf "Installing appropriate packages for your version of Ubuntu.\n"


apt-get -qq update && sudo apt-get -qq upgrade -y

apt-get -qq install -y  software-properties-common build-essential curl

add-apt-repository universe

printf "\n\nAdding the ROS2 repository\n\n"

curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

printf "\n\nInstall development tools and ROS2 tools\n\n"


if [[ "$ubuntu_version" = "20.04" ]]  
then
  echo "Ubuntu 20.04 Focal Fossa"
  python3 -m pip install -U \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-import-order \
  flake8-quotes \
  "pytest>=5.3" \
  pytest-repeat \
  pytest-rerunfailures

else
  echo "Ubuntu 22.04 Jammy Jellyfish"
  apt-get -qq install -y \
  python3-flake8-blind-except \
  python3-flake8-builtins \
  python3-flake8-class-newline \
  python3-flake8-comprehensions \
  python3-flake8-deprecated \
  python3-flake8-import-order \
  python3-flake8-quotes \
  python3-pytest-repeat \
  python3-pytest-rerunfailures
fi

# Install Gazebo
apt-get -qq install ros-humble-gazebo-ros-pkgs
apt-get -qq install ros-humble-gazebo-ros 
apt-get -qq install ros-humble-ros-core ros-humble-geometry2

  # Install Nav2
if [[ "$ubuntu_version" = "20.04" ]]  
then
  apt-get -qq install ros-humble-navigation2 ros-humble-nav2-bringup '~ros-humble-turtlebot3-.*'
else
  # Install Nav2
  apt-get -qq install ros-humble-navigation2 ros-humble-nav2-bringup ros-humble-turtlebot3*
fi

sudo -k

# Source the ROS environment on any new terminal
user=$(logname)
echo -e "\n#Source the ROS2 environment when the terminal opens \nsource /opt/ros/humble/setup.bash" >> /home/$user/.bashrc

printf "\nInstallation complete, to start using ROS2, Gazebo and Nav2 please close this terminal and open it again.\n"
