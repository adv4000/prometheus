#--------------------------------------------------------------------
# PowerShell Script to Install Prometheus Windows_Exporter on Windows
# Tested on Windows Server 2019, 2022
# Developed by Denis Astahov in 2024
#--------------------------------------------------------------------
# https://github.com/prometheus-community/windows_exporter/releases
$WINDOWS_EXPORTER_VERSION="0.25.1"
$URL="https://github.com/prometheus-community/windows_exporter/releases/download/v$WINDOWS_EXPORTER_VERSION/windows_exporter-$WINDOWS_EXPORTER_VERSION-amd64.msi"


Invoke-WebRequest $URL -OutFile window_exporter.msi
Start-Process "msiexec.exe" -ArgumentList "/i window_exporter.msi /qn" -Wait
Remove-Item window_exporter.msi
Get-Service windows_exporter
