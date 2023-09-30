#!/bin/bash
# Default variables
function="install"
repo=v0.6.10-alpha
# Options
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
        case "$1" in
        -in|--install)
            function="install"
            shift
            ;;
        -un|--uninstall)
            function="uninstall"
            shift
            ;;
	    -up|--update)
            function="update"
            shift
            ;;
        *|--)
		break
		;;
	esac
done
install() {
cd $HOME
sudo apt-get install wget jq ocl-icd-opencl-dev libopencl-clang-dev libgomp1 ocl-icd-libopencl1 -y
sleep 2
#download cli
wget -O pulsar https://github.com/subspace/pulsar/releases/download/${repo}/pulsar-ubuntu-x86_64-skylake-${repo} 
chmod +x pulsar 
mv pulsar /usr/local/bin/
pulsar init
sleep 2

#service
cd $HOME
echo "[Unit]
Description=Subspace Node
After=network.target
[Service]
Type=simple
User=$USER
ExecStart=/usr/local/bin/pulsar farm  --verbose
Restart=on-failure
LimitNOFILE=1024000
[Install]
WantedBy=multi-user.target
" > $HOME/subspace.service
sudo mv $HOME/subspace.service /etc/systemd/system
sudo systemctl restart systemd-journald 
sudo systemctl daemon-reload
echo -e '\n\e[42mRunning a service\e[0m\n' && sleep 1 
sudo systemctl enable subspace
sudo systemctl restart subspace
echo -e '\n\e[42mCheck node status\e[0m\n' && sleep 1
if [[ `service subspace status | grep active` =~ "running" ]]; then
  echo -e "Your subspace node \e[32minstalled and works\e[39m!"
  echo -e "You can check node status by the command \e[7mservice subspace status\e[0m"
  echo -e "Use \e[7mjournalctl -fu subspace\e[0m for logs"
else
 echo -e "Your subspace node \e[31mwas not installed correctly\e[39m, please reinstall."
 fi
}
uninstall() {
sudo systemctl disable subspace &> /dev/null
sudo systemctl stop subspace  &> /dev/null  
sudo rm -rf $HOME/subspace &> /dev/null
sudo rm -rf $HOME/.config/pulsar* &> /dev/null
sudo rm -rf $HOME/.local/share/pulsar/ &> /dev/null
sudo rm -rf $HOME/.local/share/subspace-cli/ &> /dev/null
sudo rm /usr/local/bin/pulsar
echo "Done"
cd $HOME
}
update() {
cd $HOME
#download cli
wget -O pulsar https://github.com/subspace/pulsar/releases/download/${repo}/pulsar-ubuntu-x86_64-skylake-${repo} 
chmod +x pulsar 
mv pulsar /usr/local/bin/
sudo systemctl daemon-reload
echo -e '\n\e[42mRunning a service\e[0m\n' && sleep 1 
sudo systemctl enable subspace
sudo systemctl restart subspace
echo -e "Your subspace node \e[32mUpdate\e[39m!"
cd $HOME
journalctl -fu subspace
}
# Actions
sudo apt install wget -y &>/dev/null
cd
$function