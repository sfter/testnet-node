<p align="center">
  <img height="350" height="auto" src="https://cdn.publish0x.com/prod/fs/images/21f6c476e6fccb01abf557a109243f936e510a98d9ede212958a377d95b7ed0f.png">
</p>

Thanks to :
> [Agus1224](https://github.com/Agus1224) & 
> [Jambul merah](https://github.com/jambulmerah)

Explorer :
> https://explorer.inery.io/

## Hardware Devices
|  Component  | Minimum Requirements |
| ------------ | ------------ |
| CPU  | Intel Core i7-8700 Hexa-Core  |
| RAM | DDR4 64 GB  |
| Storage  | 2x1 TB NVMe SSD |
| Connection | Port 1 Gbit/dtk |

## Software Devices
|Component | Minimum Requirements  |
| ------------ | ------------ |
| OS |  Ubuntu 18.04 - 20.04 (Don't use 22.04 !!) | 

## Register Inery
Register Inery Testnet Dashboard on https://testnet.inery.io/

Simply click Sign-Up and fill out the forms.

### I am using Azure VPS
I suggest opening all azure ports to make it easier.

![Screenshot_1](https://i.ibb.co/XYPFPZP/photo-6167900902430716670-x.jpg)


IP Address + Servername use your server IP.
Account Name use any name you want (max 12 char).
Password use a secure password and don't lose it :)
After registering you'll see secret phrase backup, make sure you're back up your phrase!

![Screenshot_2](https://cdn.publish0x.com/prod/fs/cachedimages/1791573717-ae84a5bd0ff341b80bd05ea96a14d41a43676aff48838213813cfe8419be996f.webp)

If you're deploying Master Nodes, make sure to claim 50.000 INR Test Token From Faucet. For Lite Nodes it's no need to claim the token.

![Screenshot_3](https://cdn.publish0x.com/prod/fs/cachedimages/1462263756-3cd6a8283feff9f1126d61ab4def521dbf9531c6346258a9fe85070b93ce779a.webp)

also save all data from left side, Account Name, Server Name, Server IP, Public Key, Private Key.

![Screenshot_4](https://cdn.publish0x.com/prod/fs/cachedimages/2054345917-f23c0c5261aa399d4b4c43b7521c4b23734a5dc3a66aa79c26f37480cf9cbd72.webp)

## Auto installation 
```
wget -O inery.sh https://raw.githubusercontent.com/mggnet/testnet/main/INERY/inery.sh && bash inery.sh
```

### Post installation
```
source $HOME/.bash_profile
```
### Check your logs
```
tail -f $inerylog | ccze -A
```
- First your master node will start fully synchronizing blocks. you will see like this

![img](https://github.com/jambulmerah/guide-testnet/raw/main/inery/img/sync_true.jpg)

- If the block is fully synced you will see something like this

![img](https://github.com/jambulmerah/guide-testnet/raw/main/inery/img/sync_false.jpg)

## Reg master node as producer block
After the block is fully synced, continue to register as a block producer
- Start master node
command:
```
start.sh
```
>NOTE don't do this before the block is fully synced

- Unlock wallet
command:
```
cline wallet unlock -n $IneryAccname --password $(cat $IneryAccname.txt)
```
- Reg producer
```
cline system regproducer $IneryAccname $IneryPubkey 0.0.0.0:9010
```
- Approve as producer
```
cline system makeprod approve $IneryAccname $IneryAccname
```
After the reg producer transaction is successful, now your node starts to get a share of producing blocks
- Check logs again
```
tail -f $inerylog | ccze -A | grep $IneryAcc
```
