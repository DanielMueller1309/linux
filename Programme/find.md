#find





###Beispiele:
- `find -exec file {} \; | grep ELF`
  `-exec`
  führt neben `find` `file` aus und

  `{}`
  übernimmt die variablen welche von find gefunden wurden (Ordner und Files) sodas file nach allen möglichen Datei headern guckt und diese interpretiert. hierbei wird der ELF header genutzt.  

  `\;`
  Das `;` beendet den von `-exec` aufgerufenen Befehl und muss ein `\` vorrangestellt haben um `find` zu signalisieren es soll den nachfolgenden ausdruck `;` an file weitergeben

- `find -name "*.pdf"`
  sucht nach PDF-Dateien. -name (berücksichtigt die Groß-/Kleinschreibung, findet hier also keine Datei(en) mit Endung *.PDF).


Link:
[Bedeutung `{} \;__`](https://askubuntu.com/questions/339015/what-does-mean-in-the-find-command)
[manpage](https://linux.die.net/man/1/find)
https://wiki.ubuntuusers.de/find/
