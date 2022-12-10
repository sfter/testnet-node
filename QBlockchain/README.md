<p align="center">
  <img height="300" height="auto" src="https://pbs.twimg.com/media/FjiAgtxXEAEaPF_?format=jpg&name=large">
</p>

# Q-Blockchain node setup for Testnet

Thanks to:
>- [Megumiiiiii](https://github.com/Megumiiiiii)
>- [BeritaCryptoo](https://t.me/BeritaCryptoo)

Explorer:
>-  https://stats.qtestnet.org/

Incentive Form:
>-  https://itn.qdev.li/

## Hardware Requirements

### Minimum Hardware Requirements
 - 4x CPUs; the faster clock speed the better
 - 8GB RAM
 - 200GB of storage (SSD or NVME)
 - Permanent Internet connection (traffic will be minimal during testnet; 10Mbps will be plenty - for production at least 100Mbps is expected)

## Set up your Node 👇
### Update
```
sudo apt update && \
sudo apt upgrade
```

### Install Docker
```
sudo apt-get update && sudo apt install jq && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin && sudo apt-get install docker-compose-plugin
```
`y` 

### Install Docker Compose
```
apt install docker-compose
```

### Automatic Script
```
wget -O qblockchain.sh https://raw.githubusercontent.com/mggnet/testnet/main/QBlockchain/qblockchain.sh && chmod +x qblockchain.sh && ./qblockchain.sh
```

## Creating a Wallet Password

```
cd ~/testnet-public-tools/testnet-validator
nano keystore/pwd.txt
```

> * Create a password that is easy to remember, 8 digits
> * Save, CTRL+X Y Enter

## Create Wallet

```
docker run --entrypoint="" --rm -v $PWD:/data -it qblockchain/q-client:testnet geth account new --datadir=/data --password=/data/keystore/pwd.txt
```

<figure><img src="https://580801350-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FyjqqGlG6vZEVZjseIV1U%2Fuploads%2FxtMzhzWyqteU5sr4utgl%2FScreenshot_1.png?alt=media&#x26;token=214e86ec-3c8c-4219-9f1a-5d569d9f3c9a" alt=""><figcaption></figcaption></figure>

## Claim Faucet <a href="#claim-faucet" id="claim-faucet"></a>

Claim the faucet using your address: https://faucet.qtestnet.org/

<figure><img src="https://580801350-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FyjqqGlG6vZEVZjseIV1U%2Fuploads%2FvQKStaT0SRuLqpZTXxCg%2FScreenshot_3.png?alt=media&#x26;token=10fa6577-5745-4358-a16f-d8051191ba0f" alt=""><figcaption></figcaption></figure>


## Edit .env <a href="#edit-.env" id="edit-.env"></a>

nano .env
>q-client:1.2.2
>
> Edit theADDRESS=Your address without 0x&#x20;
>
> IP=IP of your VPS
>
> EXT_PORT=30303
>

Example:

<a href="https://imgbb.com/"><img src="https://i.ibb.co/8jQ6ygh/Capture.jpg" alt="Capture" border="0" /></a>

Save

## Edit config.json <a href="#edit-config.json" id="edit-config.json"></a>

nano config.json

> Edit the "address" section: "your address without 0x", "password": "your password created in the first step", Example:

Save

<figure><img src="https://580801350-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FyjqqGlG6vZEVZjseIV1U%2Fuploads%2FRY5MOGgYwVS2POnor2sI%2FScreenshot_5.png?alt=media&#x26;token=6690d9df-b354-41ed-b91e-ad4fd7a888f9" alt=""><figcaption></figcaption></figure>

## Stake to Contract <a href="#stake-ke-contract" id="stake-ke-contract"></a>

```
docker run --rm -v $PWD:/data -v $PWD/config.json:/build/config.json qblockchain/js-interface:testnet validators.js
```

**Okay !**

<figure><img src="https://580801350-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FyjqqGlG6vZEVZjseIV1U%2Fuploads%2Fm1m9bQOIH0G3TCr77hOp%2FScreenshot_6.png?alt=media&#x26;token=8b26db7a-d16c-4300-bd39-a296152a8c35" alt=""><figcaption></figcaption></figure>

# Export your private key to Metamask
```
cd testnet-public-tools
chmod +x run-js-tools-in-docker.sh
./run-js-tools-in-docker.sh
npm install
```
```
chmod +x extract-geth-private-key.js
node extract-geth-private-key <WALLET_ADDRESS> ../testnet-validator/ $PASSWORD
```
Change `<WALLET_ADDRESS>` To your Wallet address

After saving your private key exit the container `exit`

# Registering Validator

In order to register your node you have to register in the Form : [Register Form](https://itn.qdev.li/)

Register your validator according to your validator info

After successfully register your validator you will receive your validator name

<img height="400" height="auto" src="https://user-images.githubusercontent.com/34649601/206744494-8418897e-226c-49be-a073-4ed939084384.png">

## Register Validator <a href="#mendaftar" id="mendaftar"></a>

In order to register your node you have to register in the Form : [Register Form](https://itn.qdev.li/)

Register your validator according to your validator info

After successfully register your validator you will receive your validator name 

<img height="400" height="auto" src="https://user-images.githubusercontent.com/34649601/206744494-8418897e-226c-49be-a073-4ed939084384.png">


**Edit the file **

```
nano docker-compose.yaml
```

> In the section after `"geth"` add
```
"--ethstats=ITN-YOUR_VALIDATOR_NAME-YOUR_CODE_NAME:qstats-testnet@stats.qtestnet.org",​
```
> Example

<img height="450" height="auto" src="https://user-images.githubusercontent.com/34649601/206747640-e29e7f73-a549-416a-b52f-6a138f402212.png">

## Run NODE <a href="#jalankan-node" id="jalankan-node"></a>

```
docker compose up -d
```

<figure><img src="https://580801350-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FyjqqGlG6vZEVZjseIV1U%2Fuploads%2FvW2zc0gkbpbKts26ddRx%2FScreenshot_12.png?alt=media&#x26;token=6f87d9d7-758a-4b6d-98db-439f8c65af96" alt=""><figcaption></figcaption></figure>

## LOGS Check <a href="#cek-logs" id="cek-logs"></a>

```
cd ~/testnet-public-tools/testnet-validator
docker compose logs -f
```

<figure><img src="https://580801350-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FyjqqGlG6vZEVZjseIV1U%2Fuploads%2F8cbem56BfMlHTa3qmTIx%2FScreenshot_13.png?alt=media&#x26;token=28d40140-e1bc-494b-85d1-a2369a67d1d6" alt=""><figcaption></figcaption></figure>

* To exit the logs session use `CTRL+C` or `CTRL+Z`.

## Check your Validator Name <a href="#cek-nama-validator-kalian" id="cek-nama-validator-kalian"></a>

[Q Network Status](https://stats.qtestnet.org/)

#### ​ <a href="#undefined" id="undefined"></a>
