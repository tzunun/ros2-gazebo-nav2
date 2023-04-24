#!/bin/bash

printf "\nThis script will install \n\nROS2 Humble\nGazebo Fortres\nNav2\n\n"

# Identify the Ubuntu version

ubuntu=$(lsb_release -r)
ubuntu_version=$(cut -f2 <<< "$ubuntu")

printf "You are running: Ubuntu $ubuntu_version.\n"
printf "Installing appropriate packages for your version of Ubuntu.\n"

#sudo apt update && sudo apt upgrade -y
#
#sudo apt install -y -qq software-properties-common build-essential curl
#
#sudo add-apt-repository universe
#
#prinft "\n\nAdding the ROS2 repository\n\n"
#
#sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
#echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
#
#printf "\n\nInstall development tools and Ros tools\n\n"
#


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
      sudo apt install -y \
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
