#alias
https://wiki.ubuntuusers.de/alias/
#### Definieren in der Datei .bashrc
Man öffnet die Datei __~/.bashrc__ mit einem Editor. Unter dem Absatz _Alias definitions_ können dann die gewünschten Kurznamen eingetragen werden.
  ```
  # Alias definitions.
  # You may want to put all your additions into a separate file like
  # ~/.bash_aliases, instead of adding them here directly.
  # See /usr/share/doc/bash-doc/examples in the bash-doc package.
  alias ll='ls -l'
  alias la='ls -la'
  ```
Anschließend speichert und schließt man die Datei.

#### Definieren in der Datei .bash_aliases
Die zweite Möglichkeit ist, Aliase zentral in der Datei __~/.bash_aliases__ zu definieren. Der Vorteil dieser Möglichkeit liegt in der Übersichtlichkeit. Die Datei wird einfach mit einem Editor erstellt und die Aliase werden zeilenweise eingetragen.
```
alias ll='ls -lahF'
```
Anschließend wird die Datei gespeichert und geschlossen.

Damit die __.bash_aliases__ auch eingelesen wird, muss die __.bashrc__ unter Umständen geändert werden. Die folgenden Zeilen müssen darin enthalten sein und dürfen nicht auskommentiert sein:
```
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi
```

#### Aktualisieren der Dateien .bashrc und .bash_aliases
Damit die geänderten Einstellungen wirksam werden, muss die Konfigurationsdatei neu eingelesen werden:

> source ~/.bashrc

> source ~/.bash_aliases



###examples
alias cp='cp -v'
alias mv='mv -vi'
alias rm='rm -vi'
alias grep='grep --color=always'
alias diff='diff --color=always'
alias mount='mount -v'
