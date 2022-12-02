Ausführen der JavaScripte
------------------------------
Das benötigte Addon ist für MsEgde, Chrome, Opera (und Firefox) verfügbar.
ACHTUNG: Ebesucher erkennt das Addon nur im Firefox als AddBlocker und ist daher nicht zu gebrauchen.

1. Installiere das AddOn "TemperMonkey" vom jeweiligen Store auf dem Browser
2. Öffne nach der Installation die Übersicht von Tempermonkey
3. Nun kann über das kleine Plus oben rechts ein auszuführendes Script angelegt werden
4. Im Tempermonkey verzeichnis findest du die Scripte die angelegt bzw. kopiert werden können
5. In den jeweiligen Scripten muss der eigene Surflink eingetragen werden

Hinweis: 
Falls irgendwelche Webseiten nicht mehr weiter navigieren, unerwünscht oder sonstige Fehler erzeugen,
besteht die Möglichkeit einen Filter drauf zu setzen.
Dazu öffnest du die "SkipEBesucher.js" in TemperMonkey und gehst auf den Reiter "Einstellungen".
Dort findest du im Bereich "Includes/Excludes" die Benutzer-Matches, welche dafür sorgen,
dass das Script auf diesen Webseiten/Matches ebenfalls ausgeführt werden und somit der mechanismus 
des redirects ausgeführt wird.
Bsp: "https://www.google.de/*"  => Über das wildcard * wird jeder Pfad der Webseite berücksichtigt


Ausführen der Batch-Files
------------------------------
Die Batch-Files sorgen dafür, dass jede halbe Stunde der Browser neugestartet wird,
da diese Erfahrungsgemäß nach einer Weile nicht mehr stabil laufen. (Aufgehangen, Speicher voll, ...)

Man kann die entweder in den Autostart legen, sodass diese nach jedem Systemstart ausgeführt werden
oder man führt sie Manuell aus, das ist euch überlassen.

