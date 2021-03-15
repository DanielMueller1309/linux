# Nextcloud

## Nur einzeln

### [Adding a new trusted domain](https://www.techrepublic.com/article/how-to-add-a-new-trusted-domain-to-nextcloud/)
Log into (or Secure Shell into) your server hosting Nextcloud. Open the necessary configuration file with the command:

sudo nano /var/www/html/nextcloud/config/config.php
In that file, you should see the line:


Muster: ```\<number> => '[ip_address or domain]', ```


![trusted_domains](./Bilder/trusted_domains.png)


___NOTE___: If you installed Nextcloud via snap packages, the configuration file will be found in the /var/snap/nextcloud/current/nextcloud/config directory.

Ready to log in
After you save and close the config.php file, you should now be able to go back to your Nextcloud instance without the Trusted Domain issue preventing logins. There's no need to restart Nextcloud or the hosting server. That's all there is to resolving this particular issue. Just remember, if you change the IP address of your server again, you'll need to add the new address to the config.php file.


## anders
occ config:system:set trusted_domains 1 --value=*

in ```/var/www/NextCloud```
./occ config:system:set trusted_domains 1 --value=*

setzt alle domains als erlaubte ein
