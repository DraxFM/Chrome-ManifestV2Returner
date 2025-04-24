# this script has to be run as administrator
# Chrome Manifest V2 Returner
# made by draxfm
# github.com/DraxFM

$chromeKeyPath = "HKLM:\SOFTWARE\Policies\Google\Chrome"
$valueName = "ExtensionManifestV2Availability"
$desiredValue = 2

if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Google")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies" -Name "Google" -Force | Out-Null
}

if (-not (Test-Path $chromeKeyPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Google" -Name "Chrome" -Force | Out-Null
}

$currentValue = Get-ItemProperty -Path $chromeKeyPath -Name $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue) {
    New-ItemProperty -Path $chromeKeyPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force
    Write-Output "key created"
}
elseif ($currentValue.$valueName -ne $desiredValue) {
    Set-ItemProperty -Path $chromeKeyPath -Name $valueName -Value $desiredValue
    Write-Output "key updated"
}
else {
    Write-Output "key already correct"
}
