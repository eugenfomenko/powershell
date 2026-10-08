
# Systemdiagnose mit PowerShell
# Zeigt Informationen zu Betriebssystem, CPU und RAM.

Write-Host "`n=== Betriebssystem ===" -ForegroundColor Cyan

Get-CimInstance Win32_OperatingSystem |
    Select-Object Caption, Version, OSArchitecture

Write-Host "`n=== Prozessor ===" -ForegroundColor Cyan

Get-CimInstance Win32_Processor |
    Select-Object Name, NumberOfCores, NumberOfLogicalProcessors

Write-Host "`n=== Arbeitsspeicher ===" -ForegroundColor Cyan

Get-CimInstance Win32_PhysicalMemory |
    Select-Object Manufacturer, Capacity, Speed
