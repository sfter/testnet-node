![image](https://incentive.minima.global/static/media/minima_logo.f132ac6f.svg)
### hardware

| Minimal | spec |
|---------|------|
|CPU|2 Cores|
|RAM|4 GB RAM|

### software/OS

| Minimal | spec |
|---------|------|
|OS|Ubuntu 20.04|

## Register Account
Register your Account First : 
* https://incentive.minima.global/account/register?inviteCode=4KDHBCUF

## Start your node
Log on as a non root user with sudo (admin) rights and add a new minima user, set a password and leave the remaining fields as default :
```bash
sudo adduser minima
```
### Please make a note of the password you set for the minima user, you may have to login as this user later.
![image](https://docs.minima.global/assets/images/docker_vps_8adduser-4de3c7729087632336110c04bef54616.png#width50) <br>
Confirm the new user with y <br>
Give sudo (admin) permissions to the minima user: <br>
```bash
sudo usermod -aG sudo minima
```
<a href="https://imgbb.com/"><img src="https://i.ibb.co/yBZfgQz/download-1.png" alt="download-1" border="0" /></a> <br>
Switch to minima user:
```bash
su - minima
```
<a href="https://imgbb.com/"><img src="https://i.ibb.co/7bKsFjP/download-2.png" alt="download-2" border="0" /></a> <br>
Download the docker install script:
```bash
sudo curl -fsSL https://get.docker.com/ -o get-docker.sh
```
<a href="https://ibb.co/yY6whCM"><img src="https://i.ibb.co/jWycVYx/download-3.png" alt="download-3" border="0" /></a><br>
Give the script permissions and run the installer for docker - this will take a few minutes to finish:
```bash
sudo
![image](https://docs.minima.global/assets/images/docker_vps_12installdocker-545446c5dd59f7b47198f47e009507f2.png) <br>
Add the minima user to the Docker group:
```bash
sudo usermod -aG docker $USER
```
Exit back to original user:
```bash
exit
```
Switch to minima user to refresh the groups:
```bash
su - minima
```
<a href="https://imgbb.com/"><img src="https://i.ibb.co/kQmrGcG/download-4.png" alt="download-4" border="0" /></a> <br>
## Start your node:
### SET YOUR PASSWORD
⚠ Make sure to change the password below from 123 to a secure password using lowercase letters and numbers only of your choice. This will be the password to access your Minidapp Hub.
```bash
docker run -d -e minima_mdspassword=123 -e minima_server=true -v ~/minimadocker9001:/home/minima/data -p 9001-9004:9001-9004 --restart unless-stopped --name minima9001 minimaglobal/minima:latest
```
>- -d: daemon mode, Minima will run in the background <br>
>- -e minima_mdspassword=123 : sets the password for your MiniDapp system to 123. YOU MUST USE A LONG SECURE PASSWORD USING LOWERCASE LETTERS AND NUMBERS ONLY<br>
>- -e minima_server = true : sets your node type as a server node that receives incoming connections<br>
>- -v ~/minimadocker9001:/home/minima/data : creates a local folder called minimadocker9001 in your home directory and maps it to the /home/minima/data directory in Docker. The minimadocker9001 folder is where the Minima database and is also where your backups will be stored.<br>
>- -p 9001-9004:9001-9004 : the port number mapping from your server to the Docker container<br>
>- --restart unless-stopped : ensures your container automatically restarts unless you stop it<br>
>- --name minima9001 : sets the name of your Minima container to minima9001<br>
>- minimaglobal/minima:latest : specifies where to pull the Minima code from<br>
![image](https://docs.minima.global/assets/images/docker_vps_15startminima-7a5d3c7ce14a45c71f1cc226d43430c5.png) <br>
Ensure Docker starts up automatically when the server starts
```bash
sudo systemctl enable docker.service
```
```bash
sudo systemctl enable containerd.service
```
Congratulations! Your Node is up and running. Continue to install the Watchtower to automatically update Minima.
## Automate updates with Watchtower
Start a Watchtower container to automatically update Minima when a new version is available. <br>
```bash
docker run -d --restart unless-stopped --name watchtower -e WATCHTOWER_CLEANUP=true -e WATCHTOWER_TIMEOUT=60s -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
```
Every 24 hours, the Watchtower will check whether there is a new version of Minima and will update if so. <br>
![image](https://docs.minima.global/assets/images/docker_vps_16startwatchtower-fa06f0dfc24ef0dd4e91c20c5f23b288.png) <br>
Check Minima and the Watchtower containers are running 
```bash
docker ps
```
Continue to access your MiniDapp hub and setup your Incentive Program account to start earning Rewards.
## Access your MiniDapp hub
The first time accessing your MiniDapp hub, you may need to pass through the security warning - see below - as the MiniDapp system currently uses self-signed certificates. <br>
>- Go to https://YourServerIP:9003/ in your web browser <br>
Click on Advanced, then Proceed. Or in Google Chrome, you may have to click anywhere on the page and type thisisunsafe to proceed.<br>
You will see your MiniDapp System (MDS) login page. <br>
<a href="https://imgbb.com/"><img src="https://i.ibb.co/LNMfJkj/download-5.png" alt="download-5" border="0" /></a> <br>
Enter your password to login <br>
You will see your MiniDapp hub!
## Set up your Incentive Program account
If you have registered for the Incentive Program you must connect your Incentive ID to your node to start receiving daily Rewards.<br>
>- Open the Incentive Program minidapp<br>
<a href="https://ibb.co/zQGdLZy"><img src="https://i.ibb.co/xXJZc6p/download-6.png" alt="download-6" border="0" /></a> <br>
>- Follow the instructions to login to the Incentive Program website and copy your Incentive ID<br>
>- Paste your Incentive ID into the field provided and click Update<br>
![image](https://docs.minima.global/assets/images/IP_updateid-64f838ca07172be2645b2ec2cf28bbf4.png#width50) <br>
>- Check the Rewards page to check your balance!<br>
![image](https://docs.minima.global/assets/images/IP_checkrewards-6fad04bec2e272d68c2298b0dd68427c.png#width50) <br>








