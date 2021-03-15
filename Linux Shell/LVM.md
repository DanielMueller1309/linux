# LVM
1.  Anlegen der Partitionen mit ___fdisk___

1. Erstellung von PVs

    Anschließend werden die Partitionen als PV initialisiert.

    > pvcreate /dev/disk/by-id/\<ID>

    Die Befehle "pvs" und "pvdisplay" bieten dabei zahlreiche Möglichkeiten sich den aktuellen Status der PVs anzeigen zu lassen.

1. Erstellen von VGs

    > vgcreate \<vgname> \<pvname>

    Der Befehl "pvdisplay" zeigt nun auch, dass eine VG mit den PVs angelegt wurde:

1. Anlegen von LVs
    Um die Größe des anzulegenden LVs zu spezifizieren gibt es verschiedene Möglichkeiten, alle benötigen aber den Parameter "-l" oder "-L".

    Größenangabe in z.B. Gigabyte:
      > lvcreate -n \<lvname> -L1G \<vgname>

    Angabe in Prozent des verfügbaren Speichers in der VG:
      > lvcreate -n \<lvname> -l100%VG \<vgname>

    Angabe in Prozent des freien Speichers in der VG:
      > lvcreate -n \<lvname> -l100%FREE \<vgname>

1. Anlegen eines Dateisystems
    Nun können die LVs mit einem Dateisystem formatiert und anschließend gemountet werden:

    > mkfs.ext4 /dev/\<vgname>/\<lvname>

    > mkdir /mnt/\<mout-point>


    Manuelles mounten mit:
    > mount /dev/\<lvname>/\<lvname> \<mout-point>

    Automatisches mounten mit __/etc/fstab__
    > sudo echo "/dev/\<vgname>/\<lvname> /mnt/\<mount-point> ext4 defaults 0 1" >> /etc/fstab


#### Entfernen eines LVs
Soll ein LV wieder entfernt werden, so wird dies über das lvremove Kommando durchgeführt:

> lvremove /dev/\<vgname>/\<lvname>

Das LV data_snap scheint nun nicht mehr als LV auf. Als PV befindet es sich die darunterliegende Partition aber immer noch

Soll die Partition komplett freigegeben werden, so muss das PV zuerst aus der VG genommen werden:

> vgreduce \<vgname> \<pvname>   


Nun kann auch das PV komplett gelöscht werden, um z.B. die Festplatte neu zu formatieren:

> pvremove \<pvname>
