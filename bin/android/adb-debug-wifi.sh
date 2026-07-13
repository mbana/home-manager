#!/usr/bin/env bash

IP=${1:-"mbana-s26-ultra"}

PORT_PAIR=${2:-"39061"}
read -p "Enter pairing port show on Android screen: " PORT_PAIR
adb pair ${IP}:${PORT_PAIR}

PORT_CONNECT=${3:-"39061"}
read -p "Enter connection port show on Android screen: " PORT_CONNECT
adb connect ${IP}:${PORT_CONNECT}
