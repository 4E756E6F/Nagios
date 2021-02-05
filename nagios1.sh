echo """The propose of this script is to install Nagios Core for you on a Ubuntu machine."""
echo "So lets get started"
echo "[INFO] Installing Prerequisites"
sleep 1
sudo apt-get update
sudo apt-get install -y wget build-essential unzip openssl libssl-dev apache2 php libapache2-mod-php php-gd libgd-dev
sudo apt-get autoremove -y
echo "[INFO] Creating Nagios user"
sudo adduser nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo usermod -a -G nagcmd www-data
echo "[INFO]  Installing Nagios Core Service"
cd /opt/
sudo wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
sudo tar -xvf nagios-4.4.6.tar.gz
cd nagios-4.4.6
sudo ./configure --with-command-group=nagcmd
sudo make all
sudo make install
sudo make install-init
sudo make install-daemoninit
sudo make install-config
sudo make install-commandmode
sudo make install-exfoliation
sudo cp -R contrib/eventhandlers/ /usr/local/nagios/libexec/
sudo chown -R nagios:nagios /usr/local/nagios/libexec/eventhandlers

