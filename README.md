# Background Creator for teams-for-linux

This repo refers to [Teams for Linux](https://github.com/IsmaelMartinez/teams-for-linux) 
which provides an non-official Electron wrapped Microsoft Teams client for use on Linux.

With this script you can automatically create background images that shall be served by 
a local webserver (e.g. Apache2) and can then be used for video-conferences background
effects.

## Preconditions

Install a webserver of your choice and enable it to serve images.

**Example on Ubuntu 22.04**
```bash
sudo -i
apt install apache2
a2enmod headers
cat << EOF | sed -i "$(( $(grep -n 'DocumentRoot /var/www/html' /etc/apache2/sites-enabled/000-default.conf | cut -d: -f1) + 1 ))r /dev/stdin" /etc/apache2/sites-enabled/000-default.conf
        <Directory /var/www/html/>
          Header set Access-Control-Allow-Origin "*"
          Options Indexes FollowSymLinks
          AllowOverride None
          Require all granted
        </Directory>
EOF
systemctl restart apache2.service
```

## Create Images

Make sure all the images are of JPEG format and named \*.jpg.

Save all images to: `/var/www/html/source/`

run the script 
```bash
./create_backgrounds.sh
```


