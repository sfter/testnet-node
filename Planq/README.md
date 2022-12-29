<p align="center">
  <img height="300" height="auto" src="https://user-images.githubusercontent.com/34649601/209750989-677f97ae-6b49-4e19-8594-5846871a9aef.png">
</p>

# PlanQ node setup for Testnet

Thanks to:
>- [Indonode](https://github.com/elangrr)

Explorer:
>-  https://explorer.planq.network/planq_7070-2/staking
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
```
wget -O plan.sh https://raw.githubusercontent.com/mggnet/testnet/main/Planq/plan.sh && chmod +x plan.sh && ./plan.sh
```

After install node run 
```
source $HOME/.bash_profile
```

### Create Wallet 
To create wallet you can create in the CLI or manual by running these commands

To create new wallet use 
```
planqd keys add wallet
```

To recover existing keys use 
```
planqd keys add wallet --recover
```

To see current keys 
```
planqd keys list
```

### Ask for faucet in Discord

### Create validator
After your node is synced, create validator

To check if your node is synced simply run
`curl http://localhost:14657/status sync_info "catching_up": false`

```
planqd tx staking create-validator \
  --amount 10000000000000000000aplanq \
  --from wallet \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.07" \
  --min-self-delegation "1000000" \
  --pubkey $(planqd tendermint show-validator) \
  --moniker $MONIKER \
  --chain-id planq_7070-2 \
  --identity=  \
  --website="" \
  --details=" " \
  --gas="1000000" \
  --gas-prices="30000000000aplanq" \
  --gas-adjustment="1.15" \
  -y
```

## Usefull commands
### Service management
Check logs
```
journalctl -fu planqd -o cat
```

Start service
```
sudo systemctl start planqd
```

Stop service
```
sudo systemctl stop planqd
```

Restart service
```
sudo systemctl restart planqd
```

### Node info
Synchronization info
```
planqd status 2>&1 | jq .SyncInfo
```

Validator info
```
planqd status 2>&1 | jq .ValidatorInfo
```

Node info
```
planqd status 2>&1 | jq .NodeInfo
```

Show node id
```
planqd tendermint show-node-id
```

### Wallet operations
List of wallets
```
planqd keys list
```

Recover wallet
```
planqd keys add wallet --recover
```

Delete wallet
```
planqd keys delete wallet
```

Get wallet balance
```
planqd query bank balances <address>
```

Transfer funds
```
planqd tx bank send <FROM ADDRESS> <TO_defund_WALLET_ADDRESS> 10000000aplanq
```

### Voting
```
planqd tx gov vote 1 yes --from wallet --chain-id=planq_7070-2
```

### Staking, Delegation and Rewards
Delegate stake
```
planqd tx staking delegate <defund valoper> 10000000aplanq --from=wallet --chain-id=planq_7070-2 --gas=auto
```

Redelegate stake from validator to another validator
```
planqd tx staking redelegate <srcValidatorAddress> <destValidatorAddress> 10000000aplanq --from=wallet --chain-id=planq_7070-2 --gas=auto
```

Withdraw all rewards
```
planqd tx distribution withdraw-all-rewards --from=wallet --chain-id=planq_7070-2 --gas=auto
```

Withdraw rewards with commision
```
planqd tx distribution withdraw-rewards <defund valoper> --from=wallet --commission --chain-id=planq_7070-2
```

### Validator management
Edit validator
```
planqd tx staking edit-validator \
  --moniker=$MONIKER \
  --identity=<your_keybase_id> \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --chain-id=planq_7070-2 \
  --from=wallet
```

Unjail validator
```
planqd tx slashing unjail \
  --broadcast-mode=block \
  --from=wallet \
  --chain-id=planq_7070-2 \
  --gas=auto
```

### Delete node
```
sudo systemctl stop planqd && \
sudo systemctl disable planqd && \
rm /etc/systemd/system/planqd.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .planqd && \
rm -rf $(which planqd)
```
