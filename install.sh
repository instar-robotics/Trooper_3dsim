#!/usr/bin/env bash

# Logging
declare -A levels=([DEBUG]=0 [INFO]=1 [WARN]=2 [ERROR]=3)
script_logging_level="DEBUG"

# CONSTANT PARAMETERS
VERSION_SCRIPT="V0.3"
VERSION_IMAGE="1.0"

# PARAMETERS
HELP=false
VERSION=false
WORKSPACE_PATH="/home/everdream/tempo"
WORKSPACE_PATH_CONTAINER=""

# Color logs, display only the level you want and add an header like 'debug',...
logThis() {
    local log_message=$1
    local log_priority=$2

    #check if level exists
    [[ ${levels[$log_priority]} ]] || return 1

    #check if level is enough
    (( ${levels[$log_priority]} < ${levels[$script_logging_level]} )) && return 2

    #log here
    if [ ${levels[$log_priority]} == ${levels[DEBUG]} ]; then
      echo -e "\e[36m${log_priority} : ${log_message}\e[0m"
    elif [ ${levels[$log_priority]} == ${levels[INFO]} ]; then
      echo "${log_priority} : ${log_message}"
    elif [ ${levels[$log_priority]} == ${levels[WARN]} ]; then
      echo -e "\e[33m${log_priority} : ${log_message}\e[0m"
    elif [ ${levels[$log_priority]} == ${levels[ERROR]} ]; then
      echo -e "\e[31m${log_priority} : ${log_message}\e[0m"
    fi
}

function print_usage
{
    echo "Usage: install.sh [-h]"
    echo ""
    echo "This script create a docker image"
    echo "for the trooper project"
    echo "And then launch a container"
    echo ""
    echo "Options:"
    echo "-h --help : Display help"
    echo ""
}

function print_version
{
  echo $VERSION_SCRIPT
  echo ""
}


POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    HELP=true
    shift # past argument
    shift # past value
    ;;
    -v|--version)
    VERSION=true
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters


# Test arguments
if [ "${HELP}" == true ]; then
	print_usage
    exit 0
elif [ "${VERSION}" == true ]; then
  print_version
    exit 0
fi

# Interruption
control_c() {
    local result

    logThis "Une interruption keyboard a été détectée." "WARNING"
    logThis "Arrêt du script..." "INFO"

    exit 1
}

# Interruption si ctrl+C
trap control_c SIGINT

# Création de l'image
logThis "Création de l'image de notre docker..." "INFO"
docker-compose build

# Lancement du container
logThis "Lancement du container..." "INFO"

# On donne les permissions chez moi obligé de donner les permissions en root
# ce qui est pas ouf à modifier pour plus de sécurité
xhost +local:root
# Ne pas oublier de faire xhost -local:root pour retirer les permissions

# Docker Containers with X11 support
docker run -it --privileged --net=host --ipc=host \
	--device=/dev/dri:/dev/dri \
	-v /dev/bus/usb:/dev/bus/usb \
	-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
	-v $HOME/.ssh:/root/.ssh \
	-v $HOME/.Xauthority:/home/$(id -un)/.Xauthority -e XAUTHORITY=/home/$(id -un)/.Xauthority \
	-v $WORKSPACE_PATH:/home/trooper/catkin_ws \
	-e DOCKER_USER_NAME=$(id -un) \
	-e DOCKER_USER_ID=$(id -u) \
	-e DOCKER_USER_GROUP_NAME=$(id -gn) \
	-e DOCKER_USER_GROUP_ID=$(id -g) \
	-e ROS_IP=127.0.0.1 \
	instar/gazebo:$VERSION_IMAGE


logThis "Votre container est lancé..." "INFO"
logThis "N'oubliez pas de retirer les permission pour le display avec la commande xhost -local:root en fin d'utilisation !" "WARNING"
