Open the `/etc/ssh/sshd_config` file with administrative privileges and change the following line:


FROM:
`#PermitRootLogin prohibit-password`
TO:
`PermitRootLogin yes`


The quick way to do this job could be just to simply use the sed command as shown below:

> sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config


Restart SSH service:
> sudo systemctl restart ssh

By default the root's password is not set on Ubuntu 20.04 and the error message ___Permission denied, please try again___ will appear when attempting to SSH login as a root user. From this reason we need to set root's password. When prompted enter your current user password followed by new root password:

> sudo passwd




ssh-copy-id root@<ip/domain>
