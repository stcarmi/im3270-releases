# IM3270 Installation Script for Windows
# Run in PowerShell as Administrator:
# irm https://raw.githubusercontent.com/stcarmi/im3270-releases/main/scripts/install-windows.ps1 | iex

Write-Host "=== IM3270 Installation for Windows ===" -ForegroundColor Green
Write-Host ""
Write-Host "LICENSE AGREEMENT" -ForegroundColor Yellow
Write-Host "By installing this software, you agree to the End User License Agreement." -ForegroundColor Yellow
Write-Host "View full license: https://im3270.infomanta.com/about/license" -ForegroundColor Yellow
Write-Host "Privacy Policy: https://im3270.infomanta.com/about/privacy" -ForegroundColor Yellow
Write-Host ""

# Check for administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as Administrator" -ForegroundColor Red
    exit 1
}

# Check if wc3270 is installed
$ws3270Path = $null
$ws3270Paths = @(
    "C:\Program Files\wc3270\ws3270.exe",
    "C:\Program Files (x86)\wc3270\ws3270.exe",
    "C:\wc3270\ws3270.exe"
)
foreach ($p in $ws3270Paths) {
    if (Test-Path $p) { $ws3270Path = $p; break }
}

if (-not $ws3270Path) {
    # Also check PATH
    $ws3270InPath = Get-Command ws3270 -ErrorAction SilentlyContinue
    if ($ws3270InPath) { $ws3270Path = $ws3270InPath.Source }
}

if (-not $ws3270Path) {
    Write-Host "wc3270 4.x not found. Please install it first:" -ForegroundColor Red
    Write-Host ""
    Write-Host "1. Download wc3270 4.x from: https://x3270.miraheze.org/wiki/Downloads" -ForegroundColor Cyan
    Write-Host "2. Run the installer"
    Write-Host "3. Ensure wc3270 is added to PATH"
    Write-Host "4. Re-run this script after installation"
    Write-Host ""

    $response = Read-Host "Open download page now? (y/n)"
    if ($response -eq 'y') {
        Start-Process "https://x3270.miraheze.org/wiki/Downloads"
    }
    exit 1
}

# Check version
$versionOutput = & $ws3270Path -version 2>&1 | Out-String
Write-Host "Found ws3270 at: $ws3270Path" -ForegroundColor Green
Write-Host "Version: $versionOutput" -ForegroundColor Gray
if ($versionOutput -match 'v(\d+)\.') {
    $major = [int]$Matches[1]
    if ($major -lt 4) {
        Write-Host "WARNING: ws3270 version is too old (need 4.x+)" -ForegroundColor Red
        Write-Host "Download 4.x from: https://x3270.miraheze.org/wiki/Downloads" -ForegroundColor Yellow
        exit 1
    }
}

# Add wc3270 to PATH if not already there
$wc3270Dir = Split-Path $ws3270Path
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
if ($currentPath -notlike "*$wc3270Dir*") {
    Write-Host "Adding wc3270 to system PATH..." -ForegroundColor Cyan
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$wc3270Dir", "Machine")
    $env:Path = "$env:Path;$wc3270Dir"
    Write-Host "  Added: $wc3270Dir" -ForegroundColor Green
}

# Download IM3270 installer
Write-Host "Downloading IM3270 installer..." -ForegroundColor Cyan
$installerUrl = "https://github.com/stcarmi/im3270-releases/releases/latest/download/IM3270.Setup.0.43.14.exe"
$installerPath = "$env:TEMP\IM3270-Setup.exe"

Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
Write-Host "Download complete." -ForegroundColor Green

# Run installer
Write-Host "Launching installer..." -ForegroundColor Cyan
Start-Process -FilePath $installerPath -Wait

Write-Host ""
Write-Host "=== Installation Complete ===" -ForegroundColor Green
Write-Host "Launch IM3270 from the Start Menu or Desktop shortcut." -ForegroundColor White
