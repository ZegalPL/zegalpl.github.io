# Usage: .\run.ps1 [-Engine docker|podman]
param(
    [ValidateSet('docker','podman')]
    [string]$Engine = 'docker'
)

& $Engine rm -f website
& $Engine rmi website 2>$null
& $Engine build -t website .
& $Engine run -d -p 80:80 --name website website
Start-Process http://localhost:80
