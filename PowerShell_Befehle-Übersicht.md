# PowerShell-Befehle – Übersicht

Eine praxisorientierte Sammlung wichtiger **PowerShell-Befehle für IT-Support, Systemintegration, Windows-Administration und Fehlerdiagnose**. Die Gliederung folgt einer klassischen CMD-Befehlsübersicht: **Befehl · Bereich · Kurzbeschreibung**.

> **Dokumentationsstand:** 08.10.2026  
> **Legende:** 🟢 **Projektbezug** = in bisherigen Arbeitsnotizen/Gesprächen als ausgeführter oder konkret verwendeter Befehl dokumentiert; 🔵 **Ergänzung** = hilfreicher Referenzbefehl, nicht als persönlich ausgeführt bestätigt.  
> **Datenschutz:** Beispiele sind, wo möglich, verallgemeinert. Keine Passwörter, Tokens oder Kundengeheimnisse im öffentlichen Repository ablegen.

## Schnellnavigation

- [Benutzer, Identität und Domäne](#benutzer-identität-und-domäne)
- [Computer, Betriebssystem und Hardware](#computer-betriebssystem-und-hardware)
- [Netzwerk – IP, DNS und Erreichbarkeit](#netzwerk--ip-dns-und-erreichbarkeit)
- [Netzwerk – Ports, Verbindungen und Routing](#netzwerk--ports-verbindungen-und-routing)
- [Dateien, Ordner und Textsuche](#dateien-ordner-und-textsuche)
- [Konfigurationsanalyse und Fachanwendungen](#konfigurationsanalyse-und-fachanwendungen)
- [Dienste, Prozesse und Ereignisprotokolle](#dienste-prozesse-und-ereignisprotokolle)
- [Windows-Reparatur und Systemintegrität](#windows-reparatur-und-systemintegrität)
- [Datenträger und Speicher](#datenträger-und-speicher)
- [SMB-Freigaben und Berechtigungen](#smb-freigaben-und-berechtigungen)
- [Firewall und Sicherheit](#firewall-und-sicherheit)
- [Registry und Software](#registry-und-software)
- [Active Directory und Gruppenrichtlinien](#active-directory-und-gruppenrichtlinien)
- [PowerShell-Pipeline und Objekte](#powershell-pipeline-und-objekte)
- [Praxisbeispiele aus Projekten](#praxisbeispiele-aus-projekten)
- [Sicherheitshinweise](#sicherheitshinweise)

---

## Benutzer, Identität und Domäne

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `whoami` | Anmeldung · 🟢 | Zeigt den angemeldeten Benutzer im Format `DOMÄNE\Benutzer`. Externes Windows-Kommando, auch in PowerShell verwendbar. |
| `whoami /groups` | Anmeldung · 🔵 | Zeigt die Sicherheitsgruppen des aktuellen Benutzers. |
| `$env:USERNAME` | Benutzer · 🔵 | Gibt den Benutzernamen aus einer Umgebungsvariablen zurück. |
| `$env:USERDOMAIN` | Domäne · 🔵 | Gibt den Anmeldedomänen- bzw. Computernamen zurück. |
| `[System.Security.Principal.WindowsIdentity]::GetCurrent().Name` | Identität · 🔵 | Zeigt die aktuelle Windows-Identität. |
| `Get-LocalUser` | Benutzer · 🔵 | Listet lokale Benutzerkonten auf. |
| `Get-LocalGroup` | Gruppen · 🔵 | Listet lokale Gruppen auf. |
| `Get-LocalGroupMember -Group 'Administratoren'` | Gruppen · 🔵 | Zeigt Mitglieder der lokalen Administratorengruppe auf einem deutschsprachigen System. |
| `Get-ComputerInfo -Property CsDomain,CsPartOfDomain` | Domäne · 🔵 | Zeigt Domänenname und Domänenmitgliedschaft, soweit verfügbar. |

---

## Computer, Betriebssystem und Hardware

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `$env:COMPUTERNAME` | System · 🔵 | Zeigt den lokalen Computernamen. |
| `Get-ComputerInfo` | System · 🔵 | Gibt umfangreiche Informationen zu Windows, BIOS und Hardware aus. |
| `Get-CimInstance Win32_OperatingSystem` | Betriebssystem · 🔵 | Liefert Betriebssystemversion, Build und weitere Systemdaten. |
| `Get-CimInstance Win32_ComputerSystem` | Hardware · 🔵 | Zeigt Hersteller, Modell, RAM und Domänenzugehörigkeit. |
| `Get-CimInstance Win32_BIOS` | BIOS · 🔵 | Zeigt BIOS-Version und Seriennummer, sofern vom Hersteller bereitgestellt. |
| `Get-CimInstance Win32_Processor` | CPU · 🔵 | Liefert Informationen zum Prozessor. |
| `Get-CimInstance Win32_PhysicalMemory` | RAM · 🔵 | Listet erkannte RAM-Module samt Kapazität und Takt auf. |
| `Get-PnpDevice` | Geräte · 🔵 | Zeigt Plug-and-Play-Geräte und deren Status. |
| `Get-PnpDevice -PresentOnly` | Geräte · 🔵 | Zeigt aktuell vorhandene Plug-and-Play-Geräte. |

---

## Netzwerk – IP, DNS und Erreichbarkeit

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `Get-NetIPConfiguration` | IP-Konfiguration · 🔵 | Zeigt IP-Adresse, Gateway und DNS pro Adapter. |
| `Get-NetIPAddress -AddressFamily IPv4` | IPv4 · 🔵 | Listet konfigurierte IPv4-Adressen auf. |
| `Get-NetAdapter` | Netzwerkadapter · 🔵 | Zeigt Adapter, Verbindungsstatus und Link-Geschwindigkeit. |
| `Get-DnsClientServerAddress` | DNS · 🔵 | Zeigt die konfigurierten DNS-Server je Adapter. |
| `Resolve-DnsName 'example.com'` | DNS · 🟢 | Prüft die DNS-Namensauflösung. Im Projektkontext für Hostnamenabfragen verwendet. |
| `Test-Connection '192.0.2.10' -Count 4` | Erreichbarkeit · 🔵 | Sendet ICMP-Echoanforderungen an ein Ziel. |
| `Test-NetConnection 'server.example.local'` | Erreichbarkeit · 🟢 | Prüft die Erreichbarkeit eines Hostsystems und liefert Diagnosedaten. |
| `Get-NetNeighbor -AddressFamily IPv4` | ARP/Nachbarn · 🟢 | Zeigt IPv4-Nachbareinträge samt IP-Adresse, MAC-Adresse und Status. |
| `Get-NetRoute -AddressFamily IPv4` | Routing · 🔵 | Listet die IPv4-Routen des Systems auf. |
| `Get-NetIPInterface` | Schnittstellen · 🔵 | Zeigt IP-Schnittstellen und deren Eigenschaften. |
| `Get-NetAdapterStatistics` | Netzwerkkarte · 🔵 | Liefert Sende- und Empfangszähler der Adapter. |

---

## Netzwerk – Ports, Verbindungen und Routing

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `Test-NetConnection '192.0.2.10' -Port 445` | TCP/SMB · 🟢 | Prüft, ob ein SMB-Ziel über TCP 445 erreichbar ist. |
| `Test-NetConnection '192.0.2.10' -Port 49510` | TCP/Fachanwendung · 🟢 | Prüft einen anwendungsspezifischen TCP-Port; in der mediDOK-Diagnose verwendet. |
| `Test-NetConnection 'server.example.local' -Port 80` | TCP/HTTP · 🟢 | Testet den TCP-Port 80 auf einem Anwendungsserver. |
| `Get-NetTCPConnection` | TCP · 🔵 | Zeigt lokale TCP-Verbindungen und deren Status. |
| `Get-NetTCPConnection -State Listen` | Listening-Ports · 🔵 | Zeigt TCP-Ports, auf denen lokale Prozesse lauschen. |
| `Get-Process -Id 1234` | Prozesszuordnung · 🔵 | Zeigt einen Prozess anhand seiner PID. `1234` ist eine Beispiel-PID. |
| `Get-NetUDPEndpoint` | UDP · 🔵 | Listet lokal gebundene UDP-Endpunkte auf. |
| `Test-NetConnection 'example.com' -TraceRoute` | Routing · 🔵 | Führt eine Traceroute zum Ziel aus. |
| `1..10 \| ForEach-Object { Test-NetConnection '192.0.2.10' -Port (5000 + $_) -InformationLevel Quiet }` | Porttests · 🔵 | Prüft mehrere aufeinanderfolgende TCP-Ports und liefert Wahr/Falsch-Ergebnisse. |

---

## Dateien, Ordner und Textsuche

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `Get-ChildItem 'C:\Windows'` | Dateisystem · 🟢 | Listet Dateien und Ordner eines Verzeichnisses auf. |
| `Get-ChildItem 'C:\DConcept\DeApps' -Recurse -File` | Dateisuche · 🟢 | Durchsucht eine Anwendungsstruktur rekursiv nach Dateien. |
| `Get-Content 'C:\Windows\Logs\CBS\CBS.log' -Tail 50` | Logdateien · 🟢 | Zeigt die letzten 50 Zeilen des Windows-CBS-Protokolls; bei der Windows-Reparatur verwendet. |
| `Get-Content 'C:\Windows\Logs\CBS\CBS.log' -Wait -Tail 20` | Log-Monitoring · 🔵 | Verfolgt neue Logzeilen fortlaufend. Mit `Strg+C` beenden. |
| `Select-String -Path 'C:\Windows\Logs\CBS\CBS.log' -Pattern 'Error'` | Textsuche · 🟢 | Sucht in einer Datei nach Textmustern. |
| `Get-ChildItem 'C:\Logs' -Recurse -File \| Select-String -Pattern 'DICOM'` | Rekursive Textsuche · 🟢 | Durchsucht Dateien nach Schlüsselwörtern; entspricht der Methode aus der DICOM-Konfigurationsanalyse. |
| `Get-Item 'C:\Windows\explorer.exe'` | Dateiinformationen · 🔵 | Zeigt Metadaten zu einer Datei. |
| `Get-FileHash 'C:\Windows\explorer.exe' -Algorithm SHA256` | Integrität · 🔵 | Berechnet einen SHA-256-Hash einer Datei. |
| `Test-Path 'C:\Windows\Logs\CBS\CBS.log'` | Existenzprüfung · 🔵 | Prüft, ob eine Datei oder ein Verzeichnis existiert. |
| `Get-Acl 'C:\Windows'` | NTFS-Rechte · 🔵 | Zeigt die Zugriffssteuerungsliste des angegebenen Pfades. |

---

## Konfigurationsanalyse und Fachanwendungen

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `Get-ChildItem 'C:\DConcept\DeApps' -Recurse -File -ErrorAction SilentlyContinue` | mediDOK · 🟢 | Sucht rekursiv nach Dateien in einem Installationsverzeichnis. |
| `Where-Object { $_.Extension -in '.ini','.cfg','.xml','.config','.json' }` | Filter · 🟢 | Filtert in einer Pipeline typische Konfigurationsdateien heraus. |
| `Select-String -Pattern '(?i)\bDICOM\b|\bMWL\b|\bWorklist\b'` | DICOM · 🟢 | Sucht per regulärem Ausdruck nach DICOM- und Worklist-Begriffen. |
| `Get-Content 'C:\Config\medidok.cfg'` | Konfiguration · 🟢 | Liest eine Konfigurationsdatei; im Projekt mit konkretem Laufwerkspfad verwendet. |
| `Get-Content 'C:\Config\mdDCMCalling.cfg'` | DICOM · 🟢 | Liest beispielhaft eine DICOM-Konfigurationsdatei. |
| `Select-String -Path 'C:\Config\*.cfg' -Pattern 'DICOM','AET','Port','Worklist'` | DICOM-Parameter · 🟢 | Sucht nach AE-Title-, Port- und Worklist-Hinweisen. |
| `Get-ChildItem 'C:\Config' -Recurse -File -Include *.ini,*.cfg,*.xml,*.txt` | Konfigurationsdateien · 🟢 | Findet relevante Dateitypen innerhalb eines Projektverzeichnisses. |
| `New-Object -ComObject WScript.Shell` | Verknüpfungen · 🟢 | Erzeugt ein COM-Objekt zum Auslesen von Windows-Verknüpfungen. |
| `[xml]$x = Get-Content "$env:APPDATA\PleasantKeePass\PasswordServerClientConfiguration.xml"` | XML-Analyse · 🟢 | Liest die Clientkonfiguration als XML ein; im Authenticator-Kontext verwendet. |
| `$x.SelectNodes('//*')` | XML/XPath · 🟢 | Durchläuft sämtliche XML-Knoten des eingelesenen Dokuments. |
| `[System.IO.File]::ReadAllBytes('C:\Temp\Datei.bin')` | Binäranalyse · 🟢 | Liest eine Datei als Byte-Array; im Projekt zur Untersuchung unbekannter Metadaten verwendet. |

---

## Dienste, Prozesse und Ereignisprotokolle

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `Get-Service` | Dienste · 🟢 | Listet Windows-Dienste und ihren Status auf. |
| `Get-Service -Name 'Spooler'` | Druckdienst · 🔵 | Prüft den Status des Druckwarteschlangendienstes. |
| `Get-Process` | Prozesse · 🔵 | Listet laufende Prozesse auf. |
| `Get-Process java,javaw -ErrorAction SilentlyContinue \| Select-Object Id,ProcessName,Path` | Java-Diagnose · 🟢 | Zeigt laufende Java-Prozesse mit PID und Programmpfad. |
| `Get-CimInstance Win32_Service \| Where-Object Name -like '*sql*'` | Dienste/SQL · 🔵 | Findet Windows-Dienste mit `sql` im Namen. |
| `Get-WinEvent -LogName System -MaxEvents 30` | Ereignisprotokoll · 🔵 | Zeigt die letzten 30 Systemereignisse an. |
| `Get-WinEvent -FilterHashtable @{LogName='System';Level=2} -MaxEvents 20` | Ereignisprotokoll · 🔵 | Zeigt aktuelle Fehlerereignisse aus dem Systemprotokoll. |
| `Restart-Service -Name 'Spooler'` | Dienste · 🔵 | Startet den Druckwarteschlangendienst neu. **Ändert den Systemzustand.** |
| `Stop-Process -Id 1234 -WhatIf` | Prozesse · 🔵 | Simuliert das Beenden eines Prozesses mit der Beispiel-PID 1234. |

---

## Windows-Reparatur und Systemintegrität

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `Get-Content "$env:windir\Logs\CBS\CBS.log" -Tail 50` | CBS-Log · 🟢 | Liest die letzten Zeilen des Windows-Komponentenwartungsprotokolls. |
| `sfc /scannow` | Systemreparatur · 🔵 | Prüft und repariert geschützte Windows-Systemdateien. Externes Windows-Werkzeug. |
| `DISM /Online /Cleanup-Image /ScanHealth` | Komponentenstore · 🔵 | Prüft den Komponentenstore auf Beschädigungen. Externes Windows-Werkzeug. |
| `DISM /Online /Cleanup-Image /RestoreHealth` | Komponentenstore · 🔵 | Versucht, Beschädigungen im Komponentenstore zu reparieren. **Ändert den Systemzustand.** |
| `Get-HotFix` | Updates · 🔵 | Listet installierte Hotfixes auf, soweit über die Schnittstelle verfügbar. |
| `Get-WindowsOptionalFeature -Online` | Windows-Features · 🔵 | Zeigt optionale Windows-Features an. |

---

## Datenträger und Speicher

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `Get-Disk` | Datenträger · 🔵 | Listet physische Datenträger und deren Status auf. |
| `Get-Partition` | Partitionen · 🔵 | Zeigt Partitionen der verfügbaren Datenträger. |
| `Get-Volume` | Volumes · 🔵 | Zeigt Laufwerksbuchstaben, Dateisysteme und freien Speicherplatz. |
| `Get-PhysicalDisk` | Speicherhardware · 🔵 | Zeigt durch Storage Spaces beziehungsweise Storage Management erkannte physische Datenträger. |
| `Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3'` | Laufwerke · 🔵 | Zeigt lokale logische Datenträger mit Größe und freiem Speicherplatz. |
| `Get-PSDrive -PSProvider FileSystem` | Laufwerke · 🔵 | Listet Dateisystemlaufwerke in der aktuellen PowerShell-Sitzung auf. |
| `Get-PartitionSupportedSize -DriveLetter C` | Partitionen · 🔵 | Ermittelt unterstützte Minimal- und Maximalgrößen zum Ändern der Partition C:. |

---

## SMB-Freigaben und Berechtigungen

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `Get-SmbShare` | SMB · 🔵 | Listet lokale SMB-Freigaben auf. |
| `Get-SmbShareAccess -Name 'Scan'` | Freigaberechte · 🔵 | Zeigt Freigabeberechtigungen der SMB-Freigabe `Scan`, falls vorhanden. |
| `Get-SmbConnection` | SMB-Client · 🔵 | Zeigt bestehende SMB-Verbindungen und Dialektversionen an. |
| `Get-SmbServerConfiguration` | SMB-Server · 🔵 | Zeigt aktuelle SMB-Servereinstellungen. |
| `Get-SmbClientConfiguration` | SMB-Client · 🔵 | Zeigt aktuelle SMB-Clienteinstellungen. |
| `Get-SmbMapping` | Netzlaufwerke · 🔵 | Listet SMB-Laufwerkszuordnungen auf. |
| `Test-Path '\\server.example.local\Freigabe'` | SMB-Zugriff · 🔵 | Prüft, ob der UNC-Pfad in der aktuellen Sitzung erreichbar ist. |
| `Get-Acl 'C:\Scan' \| Format-List` | NTFS · 🔵 | Zeigt detailliert die NTFS-Berechtigungen eines Scan-Ordners. |

---

## Firewall und Sicherheit

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `Get-NetFirewallProfile` | Firewall · 🔵 | Zeigt Status und Einstellungen der Firewall-Profile. |
| `Get-NetFirewallRule -Enabled True` | Firewallregeln · 🔵 | Zeigt aktivierte Windows-Firewallregeln. |
| `Get-NetFirewallPortFilter` | Portfilter · 🔵 | Zeigt Portfilter von Firewallregeln. |
| `Get-MpComputerStatus` | Defender · 🔵 | Zeigt Statusinformationen von Microsoft Defender Antivirus, sofern verfügbar. |
| `Get-MpPreference` | Defender · 🔵 | Liest konfigurierte Defender-Einstellungen, soweit zugänglich. |
| `Get-ExecutionPolicy -List` | PowerShell-Sicherheit · 🔵 | Zeigt die wirksamen Execution-Policy-Ebenen an. |

---

## Registry und Software

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'` | Windows-Version · 🔵 | Liest Windows-Versionsinformationen aus der Registry. |
| `Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'` | Software · 🔵 | Listet Uninstall-Registryeinträge des 64-Bit-Zweigs auf. |
| `Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'` | Software · 🔵 | Liest Anzeigenamen und weitere Uninstall-Eigenschaften aus. |
| `Get-Command 'pwsh' -ErrorAction SilentlyContinue` | PowerShell · 🔵 | Prüft, ob PowerShell 7 über `pwsh` verfügbar ist. |
| `$PSVersionTable` | PowerShell-Version · 🔵 | Zeigt PowerShell-Version, Edition und Plattformdaten. |

---

## Active Directory und Gruppenrichtlinien

> Für `Get-AD*`-Befehle werden das **ActiveDirectory-Modul** (RSAT) und passende Berechtigungen benötigt.

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `Get-Module -ListAvailable ActiveDirectory` | AD-Modul · 🔵 | Prüft, ob das Active-Directory-Modul verfügbar ist. |
| `Get-ADDomain` | Domäne · 🔵 | Zeigt Informationen zur aktuellen Active-Directory-Domäne. |
| `Get-ADUser -Identity 'testuser' -Properties Enabled` | AD-Benutzer · 🔵 | Ruft ein AD-Benutzerkonto samt Aktivierungsstatus ab, sofern vorhanden. |
| `Get-ADGroup -Filter *` | AD-Gruppen · 🔵 | Listet AD-Gruppen auf. Je nach Umgebung kann die Ausgabe sehr umfangreich sein. |
| `Get-ADComputer -Filter *` | AD-Computer · 🔵 | Listet Computerobjekte in Active Directory auf. |
| `Get-GPResultantSetOfPolicy -ReportType Html -Path "$env:TEMP\rsop.html"` | Gruppenrichtlinien · 🔵 | Erstellt einen HTML-Bericht der angewendeten Gruppenrichtlinien. Erfordert das GroupPolicy-Modul. |

---

## PowerShell-Pipeline und Objekte

| Befehl | Bereich | Kurzbeschreibung |
|---|---|---|
| `Get-Help Get-ChildItem -Full` | Hilfe · 🔵 | Zeigt ausführliche Dokumentation zu einem Cmdlet. |
| `Get-Command '*Net*'` | Befehlsuche · 🔵 | Sucht verfügbare Befehle mit `Net` im Namen. |
| `Get-Member` | Objekte · 🔵 | Zeigt Eigenschaften und Methoden eingehender Pipeline-Objekte an. |
| `Where-Object { $_.Extension -in '.ini','.cfg' }` | Filtern · 🟢 | Filtert Pipelineobjekte anhand ihrer Dateiendung. |
| `Select-Object ComputerName,RemotePort,TcpTestSucceeded` | Spaltenauswahl · 🟢 | Zeigt ausgewählte Eigenschaften eines Porttestergebnisses an. |
| `Sort-Object IPAddress` | Sortieren · 🟢 | Sortiert Objekte nach ihrer IPAddress-Eigenschaft. |
| `Format-Table IPAddress,LinkLayerAddress,State` | Formatieren · 🟢 | Stellt IPv4-Nachbareinträge als Tabelle dar. |
| `ForEach-Object { $_.Value }` | Verarbeitung · 🟢 | Verarbeitet jedes Pipelineobjekt; im Binäranalysekontext verwendet. |
| `-ErrorAction SilentlyContinue` | Fehlerbehandlung · 🟢 | Unterdrückt nicht terminierende Fehlermeldungen für den jeweiligen Befehl. |
| `-WarningAction SilentlyContinue` | Warnungen · 🟢 | Unterdrückt Warnmeldungen, beispielsweise bei TCP-Porttests. |

---

## Praxisbeispiele aus Projekten

Die folgenden Beispiele dokumentieren **nachvollziehbare Diagnosemuster aus bisherigen Projekten**. Pfade und IP-Adressen können zu Demonstrationszwecken anonymisiert sein; einzelne Aufrufe wurden für die Lesbarkeit zusammengefasst.

### 1. Windows-Systemreparatur – CBS-Protokoll prüfen

```powershell
Get-Content "$env:windir\Logs\CBS\CBS.log" -Tail 50
```

**Zweck:** Den aktuellen Abschnitt des CBS-Logs nach einer Windows-Reparatur oder einem Updateversuch lesen.

### 2. Ultraschall / mediDOK – gezielte TCP-Portprüfung

```powershell
Test-NetConnection 192.0.2.10 -Port 49510
```

**Zweck:** Prüfen, ob eine Fachanwendung auf dem erwarteten TCP-Port erreichbar ist. Die Beispieladresse `192.0.2.10` steht stellvertretend für die Projekt-IP.

### 3. Mehrere Ports eines Dienstes testen

```powershell
49500,49510,49511 | ForEach-Object {
    Test-NetConnection 192.0.2.10 -Port $_ -WarningAction SilentlyContinue |
        Select-Object ComputerName,RemotePort,TcpTestSucceeded
}
```

**Zweck:** TCP-Erreichbarkeit mehrerer Ports vergleichen. **Wichtig:** Ein TCP-Test auf einem ausschließlich für UDP genutzten Port kann keinen UDP-Dienst bestätigen.

### 4. DICOM / Worklist – Konfigurationsdateien durchsuchen

```powershell
Get-ChildItem 'C:\DConcept\DeApps' -Recurse -File -ErrorAction SilentlyContinue |
    Where-Object {
        $_.Extension -in '.ini','.cfg','.xml','.config','.json'
    } |
    Select-String -Pattern '(?i)\bDICOM\b|\bMWL\b|\bWorklist\b'
```

**Zweck:** Hinweise auf DICOM Storage oder Modality Worklist in Konfigurationsdateien suchen. **Kein Treffer** ist kein Nachweis, dass die Software die Funktion nicht unterstützt.

### 5. IPv4-Nachbarn eines Subnetzes anzeigen

```powershell
Get-NetNeighbor -AddressFamily IPv4 |
    Where-Object { $_.IPAddress -like '192.168.100.*' } |
    Sort-Object IPAddress |
    Format-Table IPAddress,LinkLayerAddress,State
```

**Zweck:** Erkannte Nachbarn im LAN anzeigen. Die Ausgabe ist **kein vollständiger IP-Adressscan** und beweist nicht, dass nicht aufgeführte Adressen frei sind.

### 6. XML-Konfigurationsdatei nach Authenticator-Einstellungen prüfen

```powershell
[xml]$x = Get-Content "$env:APPDATA\PleasantKeePass\PasswordServerClientConfiguration.xml"
$x.SelectNodes('//*') |
    Where-Object { $_.Name -match 'Remember|TwoFactor|2FA|Browser|Token' } |
    Select-Object -ExpandProperty Name -Unique
```

**Zweck:** XML-Knotennamen mit möglichen Authentifizierungsbezügen anzeigen. Nur aus Knotennamen lässt sich nicht sicher auf eine aktive oder deaktivierte MFA-Konfiguration schließen.

### 7. Verknüpfungen auf das Installationsziel prüfen

```powershell
$ws = New-Object -ComObject WScript.Shell
Get-ChildItem 'C:\Users\Public\Desktop' -Filter '*.lnk' -ErrorAction SilentlyContinue |
    ForEach-Object {
        $shortcut = $ws.CreateShortcut($_.FullName)
        [PSCustomObject]@{
            Shortcut = $_.Name
            Target   = $shortcut.TargetPath
            StartIn  = $shortcut.WorkingDirectory
        }
    }
```

**Zweck:** Installationspfade und Arbeitsverzeichnisse von Desktop-Verknüpfungen untersuchen; basiert auf der Analyse von Fachanwendungs-Verknüpfungen.

### 8. Binärdateien – lesbare Zeichenfolgen extrahieren

```powershell
$file = 'C:\Temp\Datei.bin'
$bytes = [System.IO.File]::ReadAllBytes($file)
$text = [System.Text.Encoding]::ASCII.GetString($bytes)
[regex]::Matches($text, '[ -~]{4,}') |
    ForEach-Object { $_.Value }
```

**Zweck:** Mögliche lesbare ASCII-Textabschnitte in Binärdateien identifizieren. Dies ersetzt keine Format- oder Binäranalyse.

---

## Sicherheitshinweise

- **Lesende Befehle zuerst:** Prüfen, bevor Konfigurationen oder Dienste geändert werden.
- **Administratorrechte:** Manche Befehle benötigen eine erhöhte PowerShell-Sitzung.
- **PowerShell-Version:** Cmdlets können unter Windows PowerShell 5.1 und PowerShell 7 unterschiedlich verfügbar sein.
- **Echte Kundendaten schützen:** IPs, Benutzernamen, interne Hostnamen und Pfade vor der Veröffentlichung prüfen.
- **SMB:** SMBv1 nicht aktivieren, nur um ältere Geräte kurzfristig funktionsfähig zu machen, ohne Sicherheitsfreigabe und Risikoprüfung.
- **DICOM/Medizintechnik:** TCP-Verfügbarkeit beweist keine korrekte DICOM-Verbindung, keinen AE-Title-Abgleich und keine erfolgreiche Datenübertragung.
- **Keine blinden Änderungen:** `Restart-Service`, `Stop-Process`, `DISM /RestoreHealth` und vergleichbare Befehle erst nach Prüfung von Auswirkungen und Berechtigungen ausführen.
- **Kennzeichnung:** 🟢 bedeutet dokumentierter Projektbezug, **nicht** automatisch eine vollständige Audit-Spur oder einen nachgewiesenen erfolgreichen Ausgang.

---

## Hinweise zur Nutzung auf GitHub

1. Die Datei als **`README.md`** im Hauptverzeichnis des PowerShell-Repositories hochladen.
2. GitHub stellt die Überschriften, Links, Tabellen und PowerShell-Codeblöcke automatisch formatiert dar.
3. Für ein dunkles Erscheinungsbild in GitHub **Settings → Appearance → Theme → Dark** wählen. Das GitHub-Theme bestimmt Farben und Tabellenränder; Markdown allein kann die Darstellung deiner Screenshots nicht pixelgenau erzwingen.
4. Weitere echte Projektbefehle mit passendem Kontext ergänzen und den Marker 🟢 nur verwenden, wenn der Projektbezug nachvollziehbar ist.

**PowerShell ist nicht CMD:** Einige aufgeführte Befehle (z. B. `whoami`, `sfc` und `DISM`) sind externe Windows-Programme, die auch in einer PowerShell-Konsole aufgerufen werden können.
