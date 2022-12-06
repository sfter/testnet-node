<p align="center">
  <img height="100" height="auto" src="https://user-images.githubusercontent.com/107190154/190568136-14f5a7d8-5b15-46fb-8132-4d38a0779171.gif">
</p>

# Nulink node setup for Testnet

Thanks to:
>- [NodeX](https://github.com/nodexcapital)


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
You can setup your nulink fullnode in few minutes by using automated script below. It will prompt you to input your validator node name!
```
wget -O nulink.sh https://raw.githubusercontent.com/mggnet/testnet/main/Nulink/nulink.sh && chmod +x nulink.sh && ./nulink.sh
```

### Post-Installation
When installation is finished please load variables into system
```
source $HOME/.bash_profile
```

After running auto Installation you will need to put `Password` Twice.
You will get Information about your key dont forget to SAVE IT ! Its only show once.

## Setup
After running auto install command you will see output that your keystore file is saved in `/root/geth-linux-amd64-1.10.24-972007a5/keystore/UTC-XXXXX`

Change keystore name `UTC-XXXX` into `key` with command `mv` for exampe `mv UTC--2022-09-17T05-27-00.315775527Z--b045627fd6c57577bba32192d8XXXXXXXX key`

Copy the keystore file to nulink directory that we just created 
```
cp <keystore path> /root/nulink
```
Example :
```
cp /root/geth-linux-amd64-1.10.24-972007a5/keystore/key /root/nulink
```
NOTE : IF ERROR TRY TO MAKE NULINK DIRECTORY WITH THE FOLLOWING COMMAND , `cd /root`then `mkdir nulink` , after that try to copy the file again.

### Permission
Give root access, otherwise you will have an error!
```
chmod -R 777 /root/nulink
```
### Set variables
load variables into system
```
export NULINK_KEYSTORE_PASSWORD=<YOUR PASSWORD>

export NULINK_OPERATOR_ETH_PASSWORD=<YOUR PASSWORD>
```
Replace `<YOUR PASSWORD>` with password you entered earlier just so you can remember it.

### Configuration
Set the docker configuration
```
docker run -it --rm \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
nulink/nulink nulink ursula init \
--signer keystore:///code/<Path of the secret key file> \
--eth-provider https://data-seed-prebsc-2-s2.binance.org:8545  \
--network horus \
--payment-provider https://data-seed-prebsc-2-s2.binance.org:8545 \
--payment-network bsc_testnet \
--operator-address <YOUR PUBLIC ADDRESS> \
--max-gas-price 100
```
Change `<Path of the secret key file>` With the path of your keystore.
Change `<YOUR PUBLIC ADDRESS>` With your public address generated after you use auto install script

Example :
```
docker run -it --rm \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
nulink/nulink nulink ursula init \
--signer keystore:///code/key \
--eth-provider https://data-seed-prebsc-2-s2.binance.org:8545  \
--network horus \
--payment-provider https://data-seed-prebsc-2-s2.binance.org:8545 \
--payment-network bsc_testnet \
--operator-address 0xB045627Fd6c57577Bba32192d8EXXXXXXXXXXXXXXX \
--max-gas-price 100
```
### Important!
- After that you will get an output of your seed phrase `DONT FORGET TO COPY AND SAVE IT !!!`
- And you will be asked to Confirm your seed phrase , Copy/Paste your saved seed phrase.
- After that you will get confirmation , Just type `y` and enter

This is the output after you complete Configure

You can share your Public address with anyone
![image](https://user-images.githubusercontent.com/34649601/190843241-cb932b47-8ee5-40a3-9362-680b93b1d52f.png)

## Lets start the node
Then we start the node with the following command (One Command)
```
docker run --restart on-failure -d \
--name ursula \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
-e NULINK_OPERATOR_ETH_PASSWORD \
nulink/nulink nulink ursula run --no-block-until-ready
```

## Security
To protect you keys please make sure you follow basic security rules

### Set up ssh keys for authentication
Good tutorial on how to set up ssh keys for authentication to your server can be found [here](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04)

### Basic Firewall security
Start by checking the status of ufw.
```
sudo ufw status
```

Sets the default to allow outgoing connections, deny all incoming except ssh and 26656. Limit SSH login attempts
```
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw allow ${GRAVITY_PORT}656,${GRAVITY_PORT}660/tcp
sudo ufw enable
```

### Check logs 
To check logs we can use screen to constantly look at the log
```
apt install screen
```
``` 
screen -S log
```
```
docker logs -f ursula
```
Output : 
![image](https://user-images.githubusercontent.com/34649601/190843374-510026ec-7996-483f-a7a1-a42ed800cd82.png)

After that your job to run node is complete now lets go to the next step.

# Staking 
- Go to Staking page [https://test-staking.nulink.org/faucet](https://test-staking.nulink.org/faucet)
- Connect your Metamask , You can use any Metamask account
- Get BSC Testnet token in [BNB Faucet](https://testnet.binance.org/faucet-smart) 
- When you get your test BSC now ask for faucet in Nulink Faucet
- Go to [Staking](https://test-staking.nulink.org/) Page and Stake your Nulink and Press Confirm and approve transaction in your Metamask
![image](https://user-images.githubusercontent.com/34649601/190844037-d1d9c0a6-f186-4597-a18d-8a776c598291.png)

 ### Bond Worker
 Scroll down and click `Bond Worker`
![image](https://user-images.githubusercontent.com/34649601/190844089-ab76c8e4-d0f5-4269-958d-7c368347ecea.png)
 Fill the form 
- `Worker Adress` Should be your public address
- `Node Url` Should be your `https://IP:9151/` for Example `https://123.45.67.890:9151/` ( Make sure to Copy everything ! dont miss any `/` Or else you will get an error)
- Click Bond and Approve Transaction in your Metamask

# Final Words
After that your node will appear `Online`, if it still appear to be `Offline` Do not worry it will be `Online` Soon.
## FEEDBACK FORM (MUST!!)
https://docs.google.com/forms/d/e/1FAIpQLSep0rgPRcMd2kUhz53GYmBoktu-u-8npU2DakmzGpmpCmYZPw/viewform <br>
Submit feedback regarding to bugs or improvements for nulink services !

If you did not submit form you won't be eligible!

Only good submission on feedback form will get rewards

Thats it! You are done and make sure your node is not shutdown!!






