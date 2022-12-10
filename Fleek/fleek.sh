#!/bin/bash

while true
do

# Logo

curl -s https://raw.githubusercontent.com/mggnet/testnet/main/signature | bash
sleep 5

echo -e "\n==========INSTALLING DEPENDENCIES==========\n"
sleep 2

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install build-essential cmake curl protobuf-compiler clang pkg-config libssl-dev git ca-certificates gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
cargo install sccache

echo -e "\n==========INSTALLING URSA PACKAGE==========\n"
sleep 2

git clone https://github.com/fleek-network/ursa.git
cd ursa
rm Makefile
wget -q https://raw.githubusercontent.com/mggnet/testnet/main/Fleek/Makefile
make install
export DOCKER_BUILDKIT=1
make docker-build

echo -e "\n==========RUNNING URSA-CLI DOCKER==========\n"
sleep 2
make docker-run
