<p align="center">
  <img height="300" height="auto" src="https://user-images.githubusercontent.com/50621007/205657849-4fa816f7-6471-4e47-9832-ef9374a706b0.png">
</p>

# MARS GentX node setup for Testnet

Thanks to:
>- [Kj89](https://github.com/kj89)

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

## Setting up vars
Here you have to put name of your moniker (validator) that will be visible in explorer
```
NODENAME=<YOUR_MONIKER_NAME_GOES_HERE>
```

Save and import variables into system
```
echo "export NODENAME=$NODENAME" >> $HOME/.bash_profile
echo "export WALLET=wallet" >> $HOME/.bash_profile
echo "export CHAIN_ID=mars-1" >> $HOME/.bash_profile
source $HOME/.bash_profile
```

## Update packages
```
sudo apt update && sudo apt upgrade -y
```

## Install dependencies
```
sudo apt-get install make build-essential gcc git jq chrony -y
```

## Install go
```
ver="1.18.2"
cd $HOME
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
source ~/.bash_profile
```

## Download and install binaries
```
cd $HOME
git clone https://github.com/mars-protocol/hub.git
cd hub
git checkout v1.0.0
make install
```

## Config app
```
marsd config chain-id $CHAIN_ID
marsd config keyring-backend test
```

## Init node
```
marsd init $NODENAME --chain-id $CHAIN_ID
```

## Recover or create new wallet for testnet
Option 1 - generate new wallet
```
marsd keys add $WALLET
```

Option 2 - recover existing wallet
```
marsd keys add $WALLET --recover
```

## Add genesis account
```
WALLET_ADDRESS=$(marsd keys show $WALLET -a)
marsd genesis add-account $WALLET_ADDRESS 1000000umars
```

## Generate gentx
```
marsd genesis gentx $WALLET 1000000umars \
--chain-id $CHAIN_ID \
--moniker=$NODENAME \
--commission-max-change-rate=0.01 \
--commission-max-rate=1.0 \
--commission-rate=0.05 \
--identity="" \
--website="" \
--details="" \
--min-self-delegation=1
```

## Things you have to backup
- `24 word mnemonic` of your generated wallet
- contents of `$HOME/.mars/config/*`

## Submit PR with Gentx
1. Copy the contents of ${HOME}/.mars/config/gentx/gentx-XXXXXXXX.json.
2. Fork https://github.com/mars-protocol/networks
3. Create a file `gentx-<VALIDATOR_NAME>.json` under the `mars-1/gentxs` folder in the forked repo, paste the copied text into the file.
4. Create a Pull Request to the main branch of the repository

### Await further instructions!
