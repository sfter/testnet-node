<p align="center">
  <img height="100" height="auto" src="https://ironfish.network/img/logo.svg">
</p>

# Ironfish node setup for Testnet

Thanks to:
>- [NodeX](https://github.com/nodexcapital)

Explorer:
>-  https://explorer.ironfish.network/
## Hardware Requirements

### Recommended Hardware Requirements 
 - 8x CPUs; the faster clock speed the better
 - 16GB RAM
 - 500GB of storage (SSD or NVME)
 - Permanent Internet connection (traffic will be minimal during testnet; 10Mbps will be plenty - for production at least 100Mbps is expected)

## Set up your Node 👇
### Automatic Script
```
wget -q -O ironfish.sh https://raw.githubusercontent.com/mggnet/testnet/main/Ironfish/ironfish.sh && chmod +x ironfish.sh && sudo /bin/bash ironfish.sh
```
Choose you wanted option (for example option 1 – simply installing the node), enter preferred node name and wait for installation to complete.

## Post installation
The steps below are optional, you only need to start mining to increase your balance, and mining will start as soon as you sync the node. By default, a wallet is created with the `default` name, which used for mining rewards, so you do not need to create a new one.


## Load variables:
```
. $HOME/.bashrc
. $HOME/.bash_profile
```

## Set your node name 
(if you have empty config, you can check that by the command cat $HOME/.ironfish/config.json)

```
ironfish config:set nodeName $IRONFISH_NODENAME
ironfish config:set blockGraffiti $IRONFISH_NODENAME
```
The name you specify here should also be specified when registering in the leaderboard.

## Create wallet
```
ironfish accounts:create $IRONFISH_WALLET
```

## Set created wallet as default wallet:
```
ironfish accounts:use $IRONFISH_WALLET
```

## Check balance:
```
ironfish accounts:balance $IRONFISH_WALLET
```

## Usefull command
Before starting the miner, make sure that your node is synchronized with the network by running the command:
```
ironfish status -f
```
Enable Telemetry
```
ironfish config:set enableTelemetry true
```
Send a transaction using your default account
```
ironfish accounts:pay
```
If you want to send the transaction from another account, you can use the `-f` flag
.
```
ironfish accounts:pay -f MySecondAccount
```
In order to receive a transaction, you just need to tell the sender the public key of your account. If you do not know your public key, run the following command
```
ironfish accounts:publickey
```
To get the public key of your another account running the command
```
ironfish accounts:publickey -a MySecondAccount
```
View the list of accounts on your node
```
ironfish accounts:list
```
Export an account to a file
```
ironfish accounts:export AccountName filename
```
Import an account from a file
```
ironfish accounts:import filename
```
Delete your account
```
ironfish accounts:remove MyAccount
```
You can get information about connection status and errors by running the following command:
```
ironfish peers:list -fe
```
Export keys
```
mkdir -p $HOME/.ironfish/keys
ironfish accounts:export $IRONFISH_WALLET $HOME/.ironfish/keys/$IRONFISH_WALLET.json
```
Import keys
```
ironfish accounts:import PATH_TO_THE_KEY
```
Check ironfish status
```
ironfish status -f
```
Check the node
```
journalctl -u ironfishd -f
```
Check the miner
```
journalctl -u ironfishd-miner -f
```
Stop the node
```
service ironfishd stop
```
Stop the miner
```
service ironfishd-miner stop
```


