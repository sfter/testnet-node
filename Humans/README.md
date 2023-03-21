<p align="center">
  <img height="100" height="auto" src="https://humans.ai/images/logo-white.png">
</p>

# Humans AI node setup for Testnet

Explorer:
>-  https://explorer.stavr.tech/humans-testnet/staking
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
You can setup your Humans AI fullnode in few minutes by using automated script below. It will prompt you to input your validator node name!
```
wget -O humans.sh https://raw.githubusercontent.com/mggnet/testnet/main/Humans/humans.sh && chmod +x humans.sh && ./humans.sh
```
## Set up Moniker

```python
humansd config chain-id testnet-1
humansd init <YOUR_MONIKER_NAME> --chain-id testnet-1
```    

## Create/recover wallet
```python
humansd keys add <walletname>
          or 
humansd keys add <walletname> --recover
```

## Download Genesis
```python
wget https://snapshots.polkachu.com/testnet-genesis/humans/genesis.json -O $HOME/.humans/config/genesis.json

```
`sha256sum $HOME/.humans/config/genesis.json`
+ f5fef1b574a07965c005b3d7ad013b27db197f57146a12c018338d7e58a4b5cd

## Set up the minimum gas price and Peers/Seeds/Filter peers/MaxPeers
```python
SEEDS=""
PEERS="1df6735ac39c8f07ae5db31923a0d38ec6d1372b@45.136.40.6:26656,9726b7ba17ee87006055a9b7a45293bfd7b7f0fc@45.136.40.16:26656,6e84cde074d4af8a9df59d125db3bf8d6722a787@45.136.40.18:26656,eda3e2255f3c88f97673d61d6f37b243de34e9d9@45.136.40.13:26656,4de8c8acccecc8e0bed4a218c2ef235ab68b5cf2@45.136.40.12:26656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.humans/config/config.toml
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0uheart\"/;" ~/.humans/config/app.toml
sed -i -e "s/^filter_peers *=.*/filter_peers = \"true\"/" $HOME/.humans/config/config.toml
external_address=$(wget -qO- eth0.me) 
sed -i.bak -e "s/^external_address *=.*/external_address = \"$external_address:26656\"/" $HOME/.humans/config/config.toml
sed -i.bak -e "s/^seeds =.*/seeds = \"$seeds\"/" $HOME/.humans/config/config.toml
sed -i 's/max_num_inbound_peers =.*/max_num_inbound_peers = 100/g' $HOME/.humans/config/config.toml
sed -i 's/max_num_outbound_peers =.*/max_num_outbound_peers = 100/g' $HOME/.humans/config/config.toml
```

## Download addrbook
```python
wget -O $HOME/.humans/config/addrbook.json "https://raw.githubusercontent.com/mggnet/testnet/main/Humans/addrbook.json"
```

## Create a service file
```python
sudo tee /etc/systemd/system/humansd.service > /dev/null <<EOF
[Unit]
Description=humans
After=network-online.target

[Service]
User=$USER
ExecStart=$(which humansd) start
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

## Start Node
```python
sudo systemctl daemon-reload && sudo systemctl enable humansd
sudo systemctl restart humansd && sudo journalctl -u humansd -f -o cat
```

## Create Validator
### ⚠ DON'T RUN THIS IF YOUR NODE NOT YET FULLY SYNCED !! U NEED TO WAIT COUPLE HOURS - DAYS ⚠
U Can Check it with this Command <br>
```python
humansd status 2>&1 | jq .SyncInfo
```
it Must Appear catching_up False <br>
Like This ! <br><br>
![img](https://3176955217-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2Fc5Bpsj8mdmhMsKppwhBG%2Fuploads%2Fv6Q9sCVE3HbDanNoqm7r%2Fimage.png?alt=media&token=f0617e6e-5766-48e6-a408-290548bec16e)
<br>

If Your Node Fully Synced u can Continue to Create Validator <br>

```python
humansd tx staking create-validator \
--amount=1000000uheart \
--pubkey=$(humansd tendermint show-validator) \
--moniker="YOUR_MONIKER_NAME" \
--chain-id=testnet-1 \
--commission-rate="0.1" \
--commission-max-rate="0.10" \
--commission-max-change-rate="0.01" \
--min-self-delegation="1000000" \
--fees=10000uheart \
--from=wallet \
-y
```
#
### Sync Info
```python
humansd status 2>&1 | jq .SyncInfo
```
### NodeINfo
```python
humansd status 2>&1 | jq .NodeInfo
```
### Check node logs
```python
sudo journalctl -u humansd -f -o cat
```
### Check Balance
```python
humansd query bank balances humans...address1yjgn7z09ua9vms259j
```

****
## Delete node
```bash
sudo systemctl stop humansd && \
sudo systemctl disable humansd && \
rm /etc/systemd/system/humansd.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf humans && \
rm -rf .humans && \
rm -rf $(which humansd)
```
