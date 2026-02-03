# **powershell**

#####

##### **Get-Command** -->  `Listet verfügbare PowerShell-Befehle (Cmdlets, Funktionen, Aliase) auf und hilft beim Suchen nach passenden Commands`

##### **Copy-Item** --> `Kopiert Dateien oder Ordner an ein Ziel. Funktioniert lokal und über Netzlaufwerke`

##### **Add-LocalGroupMember** --> `Fügt einen Benutzer oder eine Gruppe zu einer lokalen Windows-Gruppe hinzu (z. B. "Administratoren")`

##### **Get-LocalGroup** --> `Zeigt alle lokalen Gruppen auf dem Computer an`

##### **Get-LocalGroupMember** --> `Listet die Mitglieder einer lokalen Gruppe auf (z. B. wer in "Administratoren" ist)`

##### **Select-String** --> `Durchsucht Text oder Dateien nach Mustern (ähnlich wie grep) und gibt Treffer aus`

##### **Read-Host** --> `Fragt eine Eingabe im Terminal ab (z. B. Name, Pfad oder Auswahl)`

##### **Write-Host** --> `Gibt Text direkt in der Konsole aus (auch mit Farben); gut für Statusmeldungen`

##### **Format-Table** --> `Formatiert die Ausgabe als Tabelle für bessere Lesbarkeit`

##### **Format-List** --> `Formatiert die Ausgabe als Liste; gut für viele Eigenschaften eines Objekts`

##### **Get-Help** --> `Zeigt Hilfe zu Cmdlets, Parametern und Beispielen an (z. B. -Examples, -Full, -Online)`

##### **Set-ExecutionPolicy** --> `Legt fest, welche Skripte ausgeführt werden dürfen (z. B. RemoteSigned)`

##### **$PROFILE** --> `Pfad zu deinem PowerShell-Profilskript; wird beim Start geladen und kann eigene Einstellungen enthalten`

##### **Get-CimInstance** --> `Liest Systeminformationen über CIM/WMI aus (z. B. Hardware, RAM, BIOS, Netzwerk)`

##### **Get-CimInstance Win32_PhysicalMemory | Select-Object Manufacturer, Capacity, Speed** --> `Liest Systeminformationen über CIM/WMI aus (z. B. Hardware, RAM, BIOS, Netzwerk)`

##### **Test-Connection** --> `Prüft per ICMP die Erreichbarkeit eines Hosts und misst Antwortzeiten (PowerShell-Ping)`

##### **Test-NetConnection** --> `Prüft Netzwerkverbindung inkl. Porttest und optionaler TraceRoute (sehr gut fürs Troubleshooting)`

##### **$env:USERDOMAIN** --> `Gibt die Domäne (oder den PC-Namen) des aktuellen Benutzerkontexts aus`

##### **$env:USERNAME** --> `Gibt den aktuellen Benutzernamen aus`

##### **$env:COMPUTERNAME** --> `Gibt den Computernamen aus`

##### **-match** --> `Prüft per Regex, ob ein String zu einem Muster passt (True/False)`

##### **-like** --> `Prüft Muster mit Wildcards (* und ?) statt Regex (True/False)`

##### **-eq** --> `Vergleicht auf Gleichheit`
`-ne --> Vergleicht auf Ungleichheit`
`-gt --> Prüft, ob größer als`
`-lt --> Prüft, ob kleiner als`

##### **ssh -V** --> `SSH-Client aktivieren`
##### **Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0** --> `SSH-Client installieren (falls fehlt)`
##### **Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Client*'** --> `Prüfen:`
##### **Start-Service sshd**
##### **Set-Service -Name sshd -StartupType Automatic** --> `SSH-Client aktivieren`
##### **Get-Service sshd** --> `Prüfen:`
##### **Get-NetFirewallRule -Name *OpenSSH-Server* -ErrorAction SilentlyContinue** --> `Firewall-Regel aktivieren (Port 22)`
##### **New-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -DisplayName "OpenSSH Server (sshd)" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22** --> `Wenn nichts kommt, dann Regel setzen:`
##### **Get-NetTCPConnection -LocalPort 22 -State Listen** --> `Test: Lauscht der Server auf Port 22?`
##### `oder`
##### **netstat -ano | findstr ":22"** 
##### **ipconfig** --> `IP auf deinem Windows-PC anzeigen:`
##### **Restart-Service sshd** --> `Nach Änderungen Dienst neu starten:`

##### **Typische Stolpersteine** --> 
`PC in Domäne / Firmen-Netz: Firewall/Policies können Port 22 blocken.`
`NAT/Router: Von „Internet“ geht’s nur mit Port-Forwarding (zu Hause).`
`Nur im LAN testen: Erst lokal, dann extern.`







