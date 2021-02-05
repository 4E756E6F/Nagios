echo "[INFO] Modifying user nagiosadmin password"
echo "YOUR INPUT IS REQUIRED"
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
sudo a2enconf nagios
sudo a2enmod cgi rewrite
sudo service apache2 restart
echo "[INFO] Installing Nagios Plugins"
cd /opt
sudo wget http://www.nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
sudo tar -xvf nagios-plugins-2.2.1.tar.gz
cd nagios-plugins-2.2.1
sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
sudo make
sudo make install
echo "[INFO] Verifing Settings"
sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
sudo systemctl start nagios
sudo systemctl enable nagios
echo 'ALL DONE!!!'
echo 'To access nagios just go to your browser and enter the dashboard via: http://localhost/nagios'