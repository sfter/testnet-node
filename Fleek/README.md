<p align="center">
  <img height="300" height="auto" src="https://fleek-team-bucket.storage.fleek.co/FleekIntro.jpg">
</p>

# FLEEK node setup for Testnet

Thanks to:
>- [Bayy & Airdropfind](https://github.com/bayy420-999)

## Hardware Requirements

### Minimum Hardware Requirements
 - 3x CPUs; the faster clock speed the better
 - 4GB RAM
 - 80GB Disk
 - Permanent Internet connection (traffic will be minimal during testnet; 10Mbps will be plenty - for production at least 100Mbps is expected)

### Recommended Hardware Requirements 
 - 4x CPUs; the faster clock speed the better
 - 8GB RAM
 - 200GB of storage (SSD or NVME)
 - Permanent Internet connection (traffic will be minimal during testnet; 10Mbps will be plenty - for production at least 100Mbps is expected)

## Set up your Node 👇
### Automatic Script

* Install `screen` dan `wget`
  ```console
  apt-get install screen wget
  ```
* Download script `run.sh`
  ```console
  rm run.sh
  wget -O fleek.sh https://raw.githubusercontent.com/mggnet/testnet/main/Fleek/fleek.sh && chmod +x fleek.sh && ./fleek.sh
  ```
* Change `run.sh` to executable
  ```console
  chmod +x run.sh
  ```
* Open a new terminal using `screen`
  ```console
  screen -Rd fleek
  ```
  > Once the new terminal is open, run the script
* Run the script
  ```console
  ./run.sh
  ```

### Setup Manual

* Update apt
  ```console
  sudo apt-get update
  sudo apt-get upgrade
  ```
* Instal `rust`
  ```console
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  ```
  > If there is a prompt, just press Enter
* Load environment variable `rust`
  ```console
  source "$HOME/.cargo/env"
  ```
* Check if `rust is installed`
  ```console
  cargo --version
  ```
  If `rust` is installed then the following output will appear in the terminal
  ```console
  cargo 1.65.0 (4bc8f24d3 2022-10-20)
  ```
* (OPSIONAL) Instal `scchace`
  ```console
  cargo install sccache
  ```
* Instal dependensi Linux
  ```console
  sudo apt-get install build-essential git curl screen cmake clang pkg-config libssl-dev protobuf-compiler
  ```
* Instal `Docker`
  ```console
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
  ```
* Open a new terminal using `screen`
  ```console
  screen -Rd fleek
  ```
  > Once the new terminal is open, proceed to the next step
* Download `Ursa-cli`
  ```console
  git clone https://github.com/fleek-network/ursa.git
  ```
* Enter the `ursa` folder
  ```console
  cd ursa
  ```
* Update Makefile
  ```console
  rm Makefile
  wget -q https://raw.githubusercontent.com/mggnet/testnet/main/Fleek/Makefile
  ```
* Instal `Ursa-cli`
  ```console
  make install
  ```
* Check if `Ursa-cli` is installed
  ```console
  ursa-cli --help
  ```
* Build container `Docker`
  ```console
  make docker-build
  ```
* Jalankan container `Docker`
  ```console
  make docker-run
  ```
