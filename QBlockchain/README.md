<p align="center">
  <img height="300" height="auto" src="https://pbs.twimg.com/media/FjiAgtxXEAEaPF_?format=jpg&name=large">
</p>

# Q-Blockchain node setup for Testnet

Thanks to:
>- [Megumiiiiii](https://github.com/Megumiiiiii)
>- [BeritaCryptoo](https://t.me/BeritaCryptoo)

Explorer:
>-  https://stats.qtestnet.org/

## Hardware Requirements

### Minimum Hardware Requirements
 - 4x CPUs; the faster clock speed the better
 - 8GB RAM
 - 200GB of storage (SSD or NVME)
 - Permanent Internet connection (traffic will be minimal during testnet; 10Mbps will be plenty - for production at least 100Mbps is expected)

## Set up your Node 👇
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

> Edit theADDRESS=Your address without 0x&#x20;
>
> IP=IP of your VPS
>
> Example:

<figure><img src="https://580801350-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FyjqqGlG6vZEVZjseIV1U%2Fuploads%2FkVPTziNWXkIbSME9kOuK%2FScreenshot_4.png?alt=media&#x26;token=25fd2f6b-a0dd-47e2-9075-7e27326bb5fa" alt=""><figcaption></figcaption></figure>

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

## Sign up <a href="#mendaftar" id="mendaftar"></a>

**Edit the file first**

```
nano docker-compose.yaml
```

> In the section after `"geth"` add

&#x20;"--ethstats=NAME\_VALIDATOR:qstats-testnet@stats.qtestnet.org",​

> Example

<figure><img src="https://580801350-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FyjqqGlG6vZEVZjseIV1U%2Fuploads%2Fjy0ohmTYoDmNmwSwiE5o%2FScreenshot_9.png?alt=media&#x26;token=de977f52-300c-41ef-a4a1-d0860c79c239" alt=""><figcaption></figcaption></figure>

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
