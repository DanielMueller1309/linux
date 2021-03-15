# Einbinden einer festplatte mit LVM

####Festplatte finden
Mit ```lsblk``` kann man sich zwar Blockdevices anzeigen lassen, sowie ihre größe, haben wir nun aber mehrere gleichgroße neue Blockdevices

> ll /dev/disk/by-<[id, label, by-partuuid, path, uuid]> | grep <dev-kennung oder name der Platte (modelname o.Ä.)>

Haben wir unsere Festplatte gefunden kann sie mit ```fdisk``` partitioniert werden.
#### Festplatte partitionieren

 > fdisk /dev/sdX

1. Mit ___m___ hilfe anzeigen lassen
    > m

1. Eine neue Partition hinzufügen
    > n

1. Primär auswählen
    > p

1. Partitionsnummer eingeben oder default belassen
    > 1

1. Sektorenbereiche auswählen(Größe wählen)

1. Mit ___p___ Partitionstabelle prüfen und mit ___v___ verifizieren

1. Tabelle auf Festplatte schreiben
    > w

#### Festplatte mit ext3 formatieren
> mkfs.ext4 /dev/\<vgname>/\<lvname>

> mkdir /mnt/\<mout-point>


Manuelles mounten mit:
> mount /dev/\<lvname>/\<lvname> \<mout-point>

Automatisches mounten mit __/etc/fstab__
> sudo echo "/dev/\<vgname>/\<lvname> /mnt/\<mount-point> ext4 defaults 0 1" >> /etc/fstab

#### Festplatte im Web-Interface konfigurieren

- Am Web-Interface anmelden.
- „Datacenter“ auswählen.
- Zur Registerkarte „Storage“ wechseln.
- Auf „Add – Directory“ klicken.
- Unter „ID“ einen Namen vergeben.
- Bei „Directory“ „/mnt/sdb1“ eintragen.
- Unter „Content“ auswählen, was auf der zweiten HDD gespeichert wird. Eine Mehrfachauswahl, z.B. Images und ISO, ist möglich.

#### Siehe auch
* https://www.andysblog.de/proxmox-ve-2-x-zweite-festplatte-einbinden
