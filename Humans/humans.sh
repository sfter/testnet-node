#!/bin/bash
clear

curl -s https://raw.githubusercontent.com/mggnet/testnet/main/signature | bash

sleep 2

echo -e "\e[1m\e[32m1. Install the packages... \e[0m" && sleep 1
# update
cd $HOME
sudo apt update && sudo apt upgrade -y
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y
echo -e "\e[1m\e[32m1. Install Material... \e[0m" && sleep 1
wget https://github.com/humansdotai/humans/releases/download/latest/humans_latest_linux_amd64.tar.gz
tar -xvf humans_latest_linux_amd64.tar.gz
export PATH=<path-to-humansd>:$PATH
sudo cp humansd /usr/local/bin/humansd
echo -e "\e[1m\e[32m1. Update  packages... \e[0m" && sleep 1
sudo apt-get update
sudo apt-get upgrade
sudo apt install git build-essential ufw curl jq snapd --yes
echo -e "\e[1m\e[32m1. Install Go... \e[0m" && sleep 1
wget https://golang.org/dl/go1.18.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
echo -e "\e[1m\e[32m1. Please Wait... \e[0m" && sleep 1
cd $HOME
git clone https://github.com/humansdotai/humans
cd humans
git checkout v1.0.0
go build -o humansd cmd/humansd/main.go
sudo cp humansd /usr/local/bin/humansd
echo '--------------DONE----------------'
