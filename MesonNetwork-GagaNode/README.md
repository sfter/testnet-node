<p align="center">
  <img height="300" height="auto" src="https://i.ibb.co/r7g8wn6/photo-2021-05-18-09-00-47.jpg">
</p>

# Meson Network node setup for Testnet
>- Register : https://dashboard.gaganode.com/register?referral_code=bkdleeokqy

## 1️⃣ Go To Shell Console
Link : https://shell.cloud.google.com/ <br>
Login with Your Email <br><br>
<img height="200" height="auto" src="https://i.ibb.co/TwCt1Fy/1.jpg" alt="1" border="0" /></a>
```python
curl -o app-linux-amd64.tar.gz https://assets.coreservice.io/public/package/22/app/1.0.3/app-1_0_3.tar.gz && tar -zxf app-linux-amd64.tar.gz && rm -f app-linux-amd64.tar.gz && cd ./app-linux-amd64 && sudo ./app service install
```
## 2️⃣ Start APP
<img height="200" height="auto" src="https://i.ibb.co/MMkdrSq/2.jpg" alt="1" border="0" /></a>
```python
./app
```
```python
start
```
### ⚠ PLEASE WAIT 30 SEC ⚠
After that u can <i>CRTL + C</i>

## 3️⃣ Set Up your Token
<img height="200" height="auto" src="https://i.ibb.co/qWrpbv9/3.jpg" alt="1" border="0" /></a>
```python
./apps/gaganode/gaganode config set --token=YOUR_TOKEN
```
*Fill Node Token to <b><i>YOUR_TOKEN</i></b> <br>
U can find it here : https://dashboard.gaganode.com/install_run

## 4️⃣ Restart APP
<img height="200" height="auto" src="https://i.ibb.co/k2vyQtS/4.jpg" alt="1" border="0" /></a>
```python
./app
```
```python
restart
```

## Check Your Node Status
Go to : https://dashboard.gaganode.com/user_node <br>
Make Sure Your Node is Online <br><br>
<img height="500" height="auto" src="https://i.ibb.co/JzDGXkM/Capture.jpg" alt="1" border="0" /></a>







