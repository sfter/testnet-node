# Gitopia Testnet guide

![gitopia](https://user-images.githubusercontent.com/44331529/200920964-90530a1f-8225-4021-923c-43712c00bb21.png)

[Gitopia Website](https://gitopia.com/home)
=
[EXPLORER 1](https://explorer.stavr.tech/gitopia-testnet/staking) \
[EXPLORER 2](https://explorer.gitopia.com/)
=
Thanks to :
> [STAVR](https://github.com/obajay)

- **Minimum hardware requirements**:

| Node Type |CPU | RAM  | Storage  | 
|-----------|----|------|----------|
| Testnet   |   4|  8GB | 150GB    |


# Auto_install script
```bash
wget -O gitop https://raw.githubusercontent.com/mggnet/testnet/main/Gitopia/gitop && chmod +x gitop && ./gitop
```
### Type 1
Please wait until it Fully Synced ‼‼ <br>
u can check with this command 👇
```
gitopiad status 2>&1 | jq .SyncInfo
```
Make sure "cactching_up": false

# Create wallet
```
wget -O gitop https://raw.githubusercontent.com/mggnet/testnet/main/Gitopia/gitop && chmod +x gitop && ./gitop
```
### Type 2
DON'T FORGET TO SAVE YOUR WALLET ⚠ <br>
i Recommend u to use "wallet" as a wallet name , so it will easily to configure <br>
keyring pharse is your password for your Gitopia node

# Create validator
DON'T DO THIS IF NODE NOT FULLY SYNCED YET ‼‼‼‼
```bash
gitopiad tx staking create-validator \
  --amount 1000000ujkl \
  --from <walletName> \
  --commission-max-change-rate "0.1" \
  --commission-max-rate "0.2" \
  --commission-rate "0.1" \
  --min-self-delegation "1" \
  --pubkey  $(gitopiad tendermint show-validator) \
  --moniker STAVRguide \
  --chain-id gitopia-janus-testnet-2 \
  --identity="" \
  --details="" \
  --website="" -y
```

## Delete node
DON'T DO THIS IF TESTNET NOT END YET ‼‼‼‼
```bash
sudo systemctl stop gitopiad && \
sudo systemctl disable gitopiad && \
rm /etc/systemd/system/gitopiad.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf gitopia && \
rm -rf .gitopia && \
rm -rf $(which gitopiad)
```
#
### Sync Info
```bash
gitopiad status 2>&1 | jq .SyncInfo
```
### NodeINfo
```bash
gitopiad status 2>&1 | jq .NodeInfo
```
### Check node logs
```bash
sudo journalctl -u gitopiad -f -o cat
```
### Check Balance
```bash
gitopiad query bank balances gitopia...address1yjgn7z09ua9vms259j
```
