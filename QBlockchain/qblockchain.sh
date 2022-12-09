#!/bin/bash
clear

curl -s https://raw.githubusercontent.com/mggnet/testnet/main/signature | bash

sleep 2

echo -e "\e[1m\e[32m1. Install docker... \e[0m" && sleep 1
sudo apt-get update && sudo apt install jq && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin && sudo apt-get install docker-compose-plugin

echo -e "\e[1m\e[32m1. Clone repo... \e[0m" && sleep 1
git clone https://gitlab.com/q-dev/testnet-public-tools.git

echo -e "\e[1m\e[32m1. Membuat dir... \e[0m" && sleep 1
mkdir -p /root/testnet-public-tools/testnet-validator/keystore

echo '╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬ </DONE> ╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬'
