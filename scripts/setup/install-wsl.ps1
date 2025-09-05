# Instalación de WSL y la distribución Ubuntu-24.04 si no están instalados

# Comprobar si WSL está instalado
$wslFeature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
if ($wslFeature.State -ne "Enabled") {
    Write-Host "Habilitando WSL..."
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
} else {
    Write-Host "WSL ya está habilitado."
}

# Comprobar si la característica de máquina virtual está habilitada
$vmFeature = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
if ($vmFeature.State -ne "Enabled") {
    Write-Host "Habilitando Virtual Machine Platform..."
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
} else {
    Write-Host "Virtual Machine Platform ya está habilitado."
}

# Instalar el paquete de actualización de kernel de WSL si es necesario
$kernelUpdateUrl = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$kernelInstaller = "$env:TEMP\wsl_update_x64.msi"
try {
    $wslStatus = wsl --status 2>$null
} catch {
    $wslStatus = $null
}
if (-not $wslStatus) {
    Write-Host "Descargando e instalando el kernel de WSL..."
    Invoke-WebRequest -Uri $kernelUpdateUrl -OutFile $kernelInstaller
    Start-Process msiexec.exe -Wait -ArgumentList "/i $kernelInstaller /quiet /norestart"
} else {
    Write-Host "El kernel de WSL ya está instalado."
}

# Establecer WSL 2 como predeterminado
Write-Host "Estableciendo WSL 2 como versión predeterminada..."
wsl --set-default-version 2

# Comprobar si Ubuntu-24.04 está disponible para instalar
$distros = wsl --list --online
if ($distros -match "Ubuntu-24.04") {
    # Comprobar si Ubuntu-24.04 ya está instalada
    $installedDistros = wsl --list --verbose
    if ($installedDistros -notmatch "Ubuntu-24.04") {
        Write-Host "Instalando Ubuntu-24.04..."
        wsl --install -d Ubuntu-24.04
        Write-Host "Ubuntu-24.04 instalada correctamente."
    } else {
        Write-Host "Ubuntu-24.04 ya está instalada."
    }
} else {
    Write-Host "Ubuntu-24.04 no está disponible para instalar desde la línea de comandos."
}

Write-Host "Proceso de instalación de WSL y Ubuntu-24.04 completado."
Write-Host "Es posible que necesites reiniciar tu computadora para que los cambios surtan efecto."
