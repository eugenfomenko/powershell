# PowerShell – Skriptentwicklung und Git-Workflow

Dieses Dokument sammelt längere PowerShell-Ausdrücke, Funktionen und Skriptideen für die praktische IT-Systemadministration. Die ausführbaren Skripte werden nach Möglichkeit als eigenständige `.ps1`-Dateien im Ordner `scripts/` abgelegt.

---

## Inhaltsverzeichnis

- [Entwicklungsablauf](#entwicklungsablauf)
- [Branches und Merges](#branches-und-merges)
- [Skriptübersicht](#skriptübersicht)
- [Praxisbeispiel 1 – Netzwerkdiagnose](#praxisbeispiel-1--netzwerkdiagnose)
- [Praxisbeispiel 2 – Hardwareinformationen](#praxisbeispiel-2--hardwareinformationen)
- [Dokumentationsvorlage für neue Skripte](#dokumentationsvorlage-für-neue-skripte)
- [Sicherheitsregeln](#sicherheitsregeln)

---

## Entwicklungsablauf

1. **Aufgabe definieren:** Welches Problem soll das Skript lösen?
2. **Branch erstellen:** Änderungen getrennt vom stabilen Stand entwickeln.
3. **Code schreiben:** Aussagekräftige Namen, Kommentare und Fehlerbehandlung verwenden.
4. **Lokal testen:** Zuerst auf einem Testsystem ohne produktive Auswirkungen.
5. **Änderungen dokumentieren:** Verhalten, Voraussetzungen und Testergebnisse festhalten.
6. **Pull Request öffnen:** Code überprüfen und erst dann in `main` mergen.

## Branches und Merges

| Git-Begriff | Bedeutung |
|---|---|
| `main` | Stabiler Hauptstand des Repositories |
| `feature/netzwerkdiagnose` | Beispielbranch für die Entwicklung eines Netzwerk-Skripts |
| `fix/fehlerbehandlung` | Beispielbranch zur Korrektur eines Fehlers |
| Commit | Speichert einen nachvollziehbaren Änderungsstand |
| Pull Request | Stellt Änderungen zur Überprüfung und Zusammenführung bereit |
| Merge | Führt freigegebene Änderungen in einen Zielbranch zusammen |

**Beispiel mit Git im Terminal:**

```bash
git switch main
git pull origin main
git switch -c feature/netzwerkdiagnose
# Dateien bearbeiten und testen
git add .
git commit -m "Add network diagnostics script"
git push -u origin feature/netzwerkdiagnose
```

Danach auf GitHub einen **Pull Request** von `feature/netzwerkdiagnose` nach `main` öffnen und nach Prüfung **Merge pull request** wählen. `git add .` übernimmt alle geänderten Dateien im aktuellen Verzeichnis und darunter. Vorher mit `git status` prüfen, dass keine vertraulichen Dateien erfasst werden.

---

## Skriptübersicht

| Projekt | Zweck | Status | Datei |
|---|---|---|---|
| Netzwerkdiagnose | IP- und Adapterinformationen auslesen | Beispiel / noch lokal zu testen | Dokumentation unten |
| Hardwareinventar | CPU und Arbeitsspeicher erfassen | Beispiel / noch lokal zu testen | Dokumentation unten |

---

## Praxisbeispiel 1 – Netzwerkdiagnose

**Ziel:** Aktive Netzwerkadapter und IPv4-Konfiguration anzeigen. **Voraussetzung:** Windows mit `NetTCPIP`-Modul.

```powershell
# Aktive physische und virtuelle Netzwerkadapter anzeigen
Get-NetAdapter |
    Where-Object { $_.Status -eq 'Up' } |
    Select-Object Name, InterfaceDescription, LinkSpeed, MacAddress

# IPv4-Adressen mit den zugehörigen Interfaces anzeigen
Get-NetIPAddress -AddressFamily IPv4 |
    Where-Object { $_.IPAddress -notlike '169.254.*' } |
    Select-Object InterfaceAlias, IPAddress, PrefixLength

# Optional: lokalen TCP-Port auf Erreichbarkeit prüfen
Test-NetConnection -ComputerName 127.0.0.1 -Port 445
```

**Erklärung:** `Where-Object` filtert Objekte, `Select-Object` wählt Eigenschaften aus und `Test-NetConnection` prüft einen TCP-Port. Ein erfolgreicher Test des lokalen Ports beweist keine externe SMB-Erreichbarkeit.

**Entwicklungsstand:** Referenzbeispiel, noch kein bestätigter Testlauf.

---

## Praxisbeispiel 2 – Hardwareinformationen

**Ziel:** Prozessor und installierte RAM-Module auslesen. **Voraussetzung:** Windows mit CIM-Unterstützung.

```powershell
Write-Host '--- CPU ---' -ForegroundColor Cyan
Get-CimInstance -ClassName Win32_Processor |
    Select-Object Name, NumberOfCores, MaxClockSpeed

Write-Host '--- RAM-Module ---' -ForegroundColor Cyan
Get-CimInstance -ClassName Win32_PhysicalMemory |
    Select-Object Manufacturer, BankLabel, Speed, SMBIOSMemoryType,
        @{Name='CapacityGB';Expression={[math]::Round($_.Capacity / 1GB, 2)}}

Write-Host '--- RAM gesamt ---' -ForegroundColor Cyan
Get-CimInstance -ClassName Win32_PhysicalMemory |
    Measure-Object -Property Capacity -Sum |
    Select-Object @{Name='TotalGB';Expression={[math]::Round($_.Sum / 1GB, 2)}}
```

**Erklärung:** `Get-CimInstance` liest Hardwareinformationen. `Measure-Object -Sum` addiert die Modulgrößen und `[math]::Round()` rundet das Ergebnis.

**Entwicklungsstand:** Als Ausgangspunkt für weitere Tests dokumentiert.

---

## Dokumentationsvorlage für neue Skripte

Für jedes neue Skript diesen Abschnitt kopieren und passend ausfüllen:

| Feld | Inhalt |
|---|---|
| Skriptname | Aussagekräftiger Name mit `.ps1` |
| Problem | Beschreibung der Aufgabe |
| Voraussetzungen | PowerShell-Version, Module und Berechtigungen |
| Eingaben | Parameter und erwartete Werte |
| Ausgabe | Ergebnis oder erzeugte Datei |
| Fehlerbehandlung | Erwartbare Fehler und Reaktion |
| Tests | Testumgebung, Datum, Ergebnisse |
| Branch / Pull Request | Zugehörige Git-Änderung |
| Entwicklungsstand | Idee, in Arbeit, getestet oder produktiv |

---

## Sicherheitsregeln

- Keine Passwörter, Tokens, Kundendaten, internen IP-Adressen oder vertraulichen Pfade veröffentlichen.
- Änderungen an produktiven Systemen vorab testen und freigeben lassen.
- Skripte mit Lösch- oder Änderungsfunktionen zunächst mit `-WhatIf` testen, sofern unterstützt.
- Administratorrechte nur verwenden, wenn sie erforderlich sind.
- Vor jedem Commit `git status` und `git diff` prüfen.

---

**Zusammenfassung:** Die Markdown-Datei ist das Entwicklungsjournal. Git-Branches enthalten Arbeitsstände; Pull Requests und Merges führen geprüfte Änderungen zusammen. Ausführbare Skripte gehören in separate `.ps1`-Dateien.

**Кратко по-русски:** Markdown-файл служит журналом разработки. Ветки Git позволяют работать отдельно, а Pull Request и Merge объединяют проверенные изменения. Сами скрипты лучше хранить в отдельных файлах `.ps1`.
