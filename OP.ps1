Write-Host "===================================================="
Write-Host " Скрипт оптимизации Windows создан Zerio Command "
Write-Host "===================================================="
Write-Host ""

try
{
    
}
catch
{
    Write-Host "Не удалось установить кодировку. Продолжаем выполнение..."
}

function Set-ServiceState
{
    param(
        [string]$Name,
        [string]$StartupType = "Disabled",
        [bool]$Running = $false
    )
    try
    {
        $service = Get-Service -Name $Name -ErrorAction SilentlyContinue
        if ($service)
        {
            if ($service.StartType -ne $StartupType)
            {
                try
                {
                    Set-Service -Name $Name -StartupType $StartupType -ErrorAction Stop
                    Write-Host "Тип запуска службы ${Name} установлен на $StartupType"
                }
                catch
                {
                    Write-Host "Не удалось изменить тип запуска службы ${Name}: $_"
                }
            }
            if ($Running -and $service.Status -ne "Running")
            {
                try
                {
                    Start-Service -Name $Name -ErrorAction Stop
                    Write-Host "Служба ${Name} запущена"
                }
                catch
                {
                    Write-Host "Не удалось запустить службу ${Name}: $_"
                }
            }
            elseif (!$Running -and $service.Status -eq "Running")
            {
                try
                {
                    Stop-Service -Name $Name -Force -ErrorAction Stop
                    Write-Host "Служба ${Name} остановлена"
                }
                catch
                {
                    Write-Host "Не удалось остановить службу ${Name}: $_"
                }
            }
        }
        else
        {
            Write-Host "Служба ${Name} не найдена"
        }
    }
    catch
    {
        Write-Host "Ошибка при работе со службой ${Name}: $_"
    }
}

function Clear-EventLogs
{
    Write-Host "Очистка журналов событий..."
    try
    {
        Get-EventLog -LogName * | ForEach-Object { 
            Clear-EventLog -LogName $_.Log -ErrorAction SilentlyContinue 
        }
        Write-Host "Журналы событий очищены"
    }
    catch
    {
        Write-Host "Не удалось очистить журналы событий: $_"
    }
}

function Optimize-Registry
{
    Write-Host "Оптимизация работы реестра..."
    try
    {
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "LargeSystemCache" -Value 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "IoPageLockLimit" -Value 512000
        Write-Host "Реестр оптимизирован"
    }
    catch
    {
        Write-Host "Ошибка оптимизации реестра: $_"
    }
}

function Apply-AdditionalRegistrySettings
{
    Write-Host "Дополнительные настройки реестра..."
    try
    {
        if (-not (Test-Path "HKCU:\Control Panel\Accessibility"))
        {
            New-Item -Path "HKCU:\Control Panel\Accessibility" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility" -Name "StickyKeys" -Value "506" -Type String -Force
        
        if (-not (Test-Path "HKCU:\Control Panel\Accessibility\ToggleKeys"))
        {
            New-Item -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Value "58" -Type String -Force
        
        if (-not (Test-Path "HKCU:\Control Panel\Accessibility\Keyboard Response"))
        {
            New-Item -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "DelayBeforeAcceptance" -Value "0" -Type String -Force
        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "AutoRepeatRate" -Value "0" -Type String -Force
        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "AutoRepeatDelay" -Value "0" -Type String -Force
        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -Value "122" -Type String -Force
        
        if (-not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"))
        {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0 -Type DWord -Force
        
        if (-not (Test-Path "HKCU:\Control Panel\International\User Profile"))
        {
            New-Item -Path "HKCU:\Control Panel\International\User Profile" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Value 1 -Type DWord -Force
        
        if (-not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"))
        {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value 0 -Type DWord -Force
        
        if (-not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"))
        {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Value 0 -Type DWord -Force
        
        if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"))
        {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Value 1 -Type DWord -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -Force
        
        if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"))
        {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableInventory" -Value 1 -Type DWord -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR" -Value 1 -Type DWord -Force
        
        if (-not (Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"))
        {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Value 1 -Type DWord -Force
        
        if (-not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy"))
        {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Value 0 -Type DWord -Force
        
        if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey"))
        {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey" -Name "EnableEventTranscript" -Value 0 -Type DWord -Force
        
        if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors"))
        {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -Value 1 -Type DWord -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocationScripting" -Value 1 -Type DWord -Force
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableWindowsLocationProvider" -Value 1 -Type DWord -Force
        
        if (-not (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"))
        {
            New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "FeatureSettings" -Value 1 -Type DWord -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "FeatureSettingsOverride" -Value 3 -Type DWord -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "FeatureSettingsOverrideMask" -Value 3 -Type DWord -Force
        
        if (-not (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel"))
        {
            New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" -Name "DisableTsx" -Value 1 -Type DWord -Force
        
        if (-not (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters"))
        {
            New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" -Name "MouseDataQueueSize" -Value 54 -Type DWord -Force
        
        if (-not (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters"))
        {
            New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" -Name "KeyboardDataQueueSize" -Value 50 -Type DWord -Force
        
        Write-Host "Дополнительные настройки реестра применены"
    }
    catch
    {
        Write-Host "Ошибка при применении дополнительных настроек реестра: $_"
    }
}

function Optimize-Telemetry
{
    Write-Host "Отключаем службы телеметрии..."
    @("DiagTrack", "DPS", "dmwappushservice") | ForEach-Object {
        Set-ServiceState -Name $_
    }
    
    try
    {
        if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"))
        {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -Force
        Write-Host "Дополнительные параметры телеметрии отключены"
    }
    catch
    {
        Write-Host "Не удалось отключить дополнительные параметры телеметрии: $_"
    }
}

function Clean-TempFiles
{
    Write-Host "Очищаем временные файлы Windows..."
    try
    {
        $cleanmgr = Start-Process -FilePath "Cleanmgr.exe" -ArgumentList "/sagerun:1" -PassThru -WindowStyle Hidden
        $cleanmgr.WaitForExit()
        Write-Host "Очищены временные файлы Windows"
    }
    catch
    {
        Write-Host "Не удалось очистить временные файлы Windows: $_"
    }
}

function Configure-Security {
    Write-Host "Отключаем SMBv1 (устаревший протокол)..."
    try {
        if ((Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol).State -eq "Enabled") {
            Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart -ErrorAction Stop
            Write-Host "SMBv1 отключен"
        }
        else {
            Write-Host "SMBv1 уже отключен"
        }
    }
    catch {
        Write-Host "Не удалось отключить SMBv1: $_"
    }

    Write-Host "Отключаем удаленный рабочий стол..."
    try {
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 1 -ErrorAction Stop
        Write-Host "Удаленный рабочий стол отключен"
    }
    catch {
        Write-Host "Не удалось отключить удаленный рабочий стол: $_"
    }
}

function Configure-NetworkSettings
{
    Write-Host "Отключаем IPv6..."
    try
    {
        Get-NetAdapterBinding -ComponentID ms_tcpip6 | ForEach-Object {
            Disable-NetAdapterBinding -Name $_.Name -ComponentID ms_tcpip6 -ErrorAction Stop
        }
        Write-Host "IPv6 отключен"
    }
    catch
    {
        Write-Host "Не удалось отключить IPv6: $_"
    }
    
    Write-Host "Очищаем ARP-кэш..."
    try
    {
        arp -d * | Out-Null
        Write-Host "ARP-кэш очищен"
    }
    catch
    {
        Write-Host "Не удалось очистить ARP-кэш: $_"
    }
}

function Cleanup-PowerShellTemp
{
    Write-Host "Удаляем временные файлы PowerShell..."
    try
    {
        Remove-Item -Path "$env:TEMP\*.tmp" -Force -Recurse -ErrorAction SilentlyContinue
        Write-Host "Временные файлы PowerShell удалены"
    }
    catch
    {
        Write-Host "Не удалось удалить временные файлы PowerShell: $_"
    }
}

function Delete-SystemRestorePoints
{
    Write-Host "Удаляем старые точки восстановления системы..."
    try
    {
        vssadmin delete shadows /all /quiet | Out-Null
        Write-Host "Старые точки восстановления удалены"
    }
    catch
    {
        Write-Host "Не удалось удалить старые точки восстановления: $_"
    }
}

function Disable-UnnecessaryServices
{
    Write-Host "Отключаем ненужные сетевые службы..."
    @("ClipSVC", "NetTcpPortSharing", "WMPNetworkSvc") | ForEach-Object {
        Set-ServiceState -Name $_
    }
}

function Disable-OneDrive
{
    Write-Host "Отключаем OneDrive..."
    try
    {
        $oneDriveProcess = Get-Process -Name OneDrive -ErrorAction SilentlyContinue
        if ($oneDriveProcess)
        {
            taskkill /F /IM OneDrive.exe | Out-Null
            Write-Host "OneDrive был завершен."
        }
        else
        {
            Write-Host "OneDrive не запущен."
        }
        if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive"))
        {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value 1 -Type DWord -Force | Out-Null
        Write-Host "OneDrive отключен"
    }
    catch
    {
        Write-Host "Не удалось отключить OneDrive: $_"
    }
}

function Flush-DNSCache
{
    Write-Host "Очищаем кэш DNS..."
    try
    {
        ipconfig /flushdns | Out-Null
        Write-Host "Кэш DNS очищен"
    }
    catch
    {
        Write-Host "Не удалось очистить кэш DNS: $_"
    }
}

function Disable-BackgroundTasks
{
    Write-Host "Отключаем фоновые задачи..."
    @("BITS", "SysMain", "Schedule") | ForEach-Object {
        Set-ServiceState -Name $_
    }
}

function Disable-XboxServices
{
    Write-Host "Отключаем службы Xbox..."
    @("XblAuthManager", "XblGameSave", "XboxGipSvc", "XboxNetApiSvc") | ForEach-Object {
        Set-ServiceState -Name $_
    }
}

function Cleanup-TempDirectories
{
    Write-Host "Очищаем временные файлы..."
    $tempPaths = @("$env:TEMP", "$env:SystemRoot\Temp", "$env:USERPROFILE\AppData\Local\Temp")
    foreach ($path in $tempPaths)
    {
        try
        {
            if (Test-Path $path)
            {
                $files = Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue
                if ($files.Count -gt 0)
                {
                    Remove-Item -Path "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
                    Write-Host "Очищены временные файлы из ${path}"
                }
                else
                {
                    Write-Host "Временные файлы в ${path} уже отсутствуют."
                }
            }
            else
            {
                Write-Host "Путь ${path} не существует."
            }
        }
        catch
        {
            Write-Host "Не удалось очистить ${path}: $_"
        }
    }
}

function Optimize-TCPSettings
{
    Write-Host "Оптимизируем параметры TCP/IP..."
    try
    {
        netsh int tcp set global autotuninglevel=normal | Out-Null
        netsh int tcp set supplemental template=internet congestionprovider=ctcp | Out-Null
        Write-Host "Настроены параметры TCP/IP"
    }
    catch
    {
        Write-Host "Не удалось настроить параметры TCP/IP: $_"
    }
}

function Disable-Hibernation
{
    Write-Host "Отключаем гибернацию..."
    try
    {
        powercfg /h off 2>&1 | Out-Null
        
        if (-not (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power"))
        {
            New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "HibernateEnabled" -Value 0 -Type DWord -Force
        
        if (-not (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"))
        {
            New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Type DWord -Force
        
        Write-Host "Гибернация отключена"
    }
    catch
    {
        Write-Host "Не удалось отключить гибернацию: $_"
    }
}

function Configure-PowerSettings
{
    Write-Host "Активируем схему максимальной производительности..."
    try
    {
        powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>&1 | Out-Null
        Write-Host "Схема максимальной производительности активирована"
    }
    catch
    {
        Write-Host "Не удалось активировать схему максимальной производительности: $_"
    }
}

function Cleanup-OldUpdates
{
    Write-Host "Очищаем систему от старых обновлений Windows..."
    try
    {
        DISM /Online /Cleanup-Image /StartComponentCleanup /Quiet | Out-Null
        Write-Host "Старые обновления удалены"
    }
    catch
    {
        Write-Host "Не удалось очистить систему от старых обновлений: $_"
    }
}

function Disable-ScheduledTasks
{
    Write-Host "Отключаем триггеры планировщика задач..."
    try
    {
        Get-ScheduledTask | Where-Object { $_.State -eq "Ready" } | ForEach-Object {
            Disable-ScheduledTask -TaskName $_.TaskName -ErrorAction SilentlyContinue | Out-Null
            Write-Host "Триггер отключен: $($_.TaskName)"
        }
        Write-Host "Триггеры планировщика задач отключены"
    }
    catch
    {
        Write-Host "Не удалось отключить триггеры планировщика задач: $_"
    }
}

function Enable-TRIM
{
    Write-Host "Включаем TRIM..."
    try
    {
        fsutil behavior set disabledeletenotify 0 | Out-Null
        Write-Host "TRIM включен"
    }
    catch
    {
        Write-Host "Не удалось включить TRIM: $_"
    }
}

function Optimize-NetworkIO
{
    Write-Host "Выполняем оптимизацию ввода-вывода..."
    try
    {
        Get-NetTCPConnection | ForEach-Object {
            $registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$($_.InterfaceAlias)"
            if (-not (Test-Path $registryPath))
            {
                New-Item -Path $registryPath -Force | Out-Null
            }
            Set-ItemProperty -Path $registryPath -Name "TcpAckFrequency" -Value 1 -Type DWord -Force | Out-Null
            Set-ItemProperty -Path $registryPath -Name "TCPNoDelay" -Value 1 -Type DWord -Force | Out-Null
        }
        Write-Host "Оптимизирован сетевой ввод-вывод"
    }
    catch
    {
        Write-Host "Не удалось оптимизировать сетевой ввод-вывод: $_"
    }
}

function Optimize-DirectX
{
    Write-Host "Выполняем оптимизацию DirectX..."
    try
    {
        if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Direct3D"))
        {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Direct3D" -Force | Out-Null
        }
        if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\DirectDraw"))
        {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\DirectDraw" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Direct3D" -Name "LoadDebugRuntime" -Value 0 -Type DWord -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\DirectDraw" -Name "EmulationOnly" -Value 0 -Type DWord -Force | Out-Null
        Write-Host "Оптимизированы настройки DirectX"
    }
    catch
    {
        Write-Host "Не удалось оптимизировать настройки DirectX: $_"
    }
}

function Optimize-NetworkAdapters {
    Write-Host "Оптимизация параметров сетевых адаптеров..."

    $energySavingProperties = @(
        "Energy-Efficient Ethernet", "Энергосберегающий Ethernet",
        "Ultra Low Power Mode", "Ultra Low Power Mode",
        "Green Ethernet", "Зеленый Ethernet",
        "Gigabit Lite", "Gigabit Lite",
        "Power Saving Mode", "Power Saving Mode",
        "Auto Disable Gigabit", "Автоотключение гигабитной скорости",
        "Advanced EEE", "Advanced EEE",
        "Packet Coalescing", "Объединение пакетов"
    )

    foreach ($property in $energySavingProperties) {
        try {
            Set-NetAdapterAdvancedProperty -Name "*" -DisplayName $property -DisplayValue "Disabled" -ErrorAction SilentlyContinue
            Set-NetAdapterAdvancedProperty -Name "*" -DisplayName $property -DisplayValue "Выкл" -ErrorAction SilentlyContinue
            Write-Host "Отключен параметр: $property"
        }
        catch {
            Write-Host "Не удалось отключить параметр: $property ($_)"
        }
    }

    try {
        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "MIMO power save mode" -DisplayValue "No SMPS" -ErrorAction SilentlyContinue
        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Режим энергосбережения MIMO" -DisplayValue "Нет SMPS" -ErrorAction SilentlyContinue
        Write-Host "Настроен режим энергосбережения MIMO"
    }
    catch {
        Write-Host "Не удалось настроить режим энергосбережения MIMO ($_)"
    }

    try {
        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Flow Control" -DisplayValue "Disabled" -ErrorAction SilentlyContinue
        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Управление потоком" -DisplayValue "Выкл" -ErrorAction SilentlyContinue
        Write-Host "Отключен Flow Control"

        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Interrupt Moderation" -DisplayValue "Enabled" -ErrorAction SilentlyContinue
        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Модерация прерывания" -DisplayValue "Вкл" -ErrorAction SilentlyContinue
        Write-Host "Включена модерация прерывания"
    }
    catch {
        Write-Host "Не удалось настроить Flow Control или Interrupt Moderation ($_)"
    }

    try {
        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Receive Side Scaling" -DisplayValue "Enabled" -ErrorAction SilentlyContinue
        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Получение бокового масштабирования" -DisplayValue "Вкл" -ErrorAction SilentlyContinue
        Write-Host "Включено получение бокового масштабирования (RSS)"

        $coreCount = (Get-CimInstance -ClassName Win32_Processor | Measure-Object -Property NumberOfCores -Sum).Sum
        $rssQueues = if ($coreCount -eq 8) { "4 Queues" } else { "2 Queues" }
        $rssQueuesRu = if ($coreCount -eq 8) { "4 Очереди" } else { "2 Очереди" }

        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Maximum Number of RSS Queues" -DisplayValue $rssQueues -ErrorAction SilentlyContinue
        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Максимальное число очередей RSS" -DisplayValue $rssQueuesRu -ErrorAction SilentlyContinue
        Write-Host "Настроено максимальное число очередей RSS: $rssQueues"
    }
    catch {
        Write-Host "Не удалось настроить RSS ($_)"
    }

    try {
        @("Large Send Offload v2 (IPv4)", "Large Send Offload v2 (IPv6)",
          "Разгрузка при большой отправке (IPv4)", "Разгрузка при большой отправке (IPv6)",
          "Разгрузка при большой отправке v2 (IPv4)", "Разгрузка при большой отправке v2 (IPv6)") | ForEach-Object {
            Set-NetAdapterAdvancedProperty -Name "*" -DisplayName $_ -DisplayValue "Disabled" -ErrorAction SilentlyContinue
            Set-NetAdapterAdvancedProperty -Name "*" -DisplayName $_ -DisplayValue "Выкл" -ErrorAction SilentlyContinue
        }
        Write-Host "Отключена разгрузка при большой отправке (LSO)"
    }
    catch {
        Write-Host "Не удалось отключить LSO ($_)"
    }

    try {
        @("ARP Offload", "Выгрузка протокола ARP", "NS Offload", "Выгрузка протокола NS") | ForEach-Object {
            Set-NetAdapterAdvancedProperty -Name "*" -DisplayName $_ -DisplayValue "Enabled" -ErrorAction SilentlyContinue
            Set-NetAdapterAdvancedProperty -Name "*" -DisplayName $_ -DisplayValue "Вкл" -ErrorAction SilentlyContinue
        }
        Write-Host "Включена выгрузка ARP и NS"
    }
    catch {
        Write-Host "Не удалось настроить ARP/NS Offload ($_)"
    }

    try {
        @("TCP Checksum Offload (IPv4)", "TCP Checksum Offload (IPv6)",
          "Контрольная сумма разгрузки TCP (IPv4)", "Контрольная сумма разгрузки TCP (IPv6)",
          "UDP Checksum Offload (IPv4)", "UDP Checksum Offload (IPv6)",
          "Контрольная сумма разгрузки UDP (IPv4)", "Контрольная сумма разгрузки UDP (IPv6)") | ForEach-Object {
            Set-NetAdapterAdvancedProperty -Name "*" -DisplayName $_ -DisplayValue "Rx & Tx Enabled" -ErrorAction SilentlyContinue
            Set-NetAdapterAdvancedProperty -Name "*" -DisplayName $_ -DisplayValue "Rx & Tx вкл" -ErrorAction SilentlyContinue
        }
        Write-Host "Настроена контрольная сумма разгрузки TCP/UDP"
    }
    catch {
        Write-Host "Не удалось настроить контрольную сумму разгрузки ($_)"
    }

    try {
        @("Wake on Magic Packet", "Включить при срабатывании функции Magic Packet",
          "Wake on pattern match", "Включить при совпадении шаблона",
          "Включить при получении магического пакета") | ForEach-Object {
            Set-NetAdapterAdvancedProperty -Name "*" -DisplayName $_ -DisplayValue "Disabled" -ErrorAction SilentlyContinue
            Set-NetAdapterAdvancedProperty -Name "*" -DisplayName $_ -DisplayValue "Выкл" -ErrorAction SilentlyContinue
        }
        Write-Host "Отключены Wake on Magic Packet и Wake on Pattern Match"
    }
    catch {
        Write-Host "Не удалось отключить Wake on Magic Packet/Pattern Match ($_)"
    }

    try {
        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Enable PME" -DisplayValue "Off" -ErrorAction SilentlyContinue
        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Large Send Offload" -DisplayValue "Off" -ErrorAction SilentlyContinue
        Set-NetAdapterAdvancedProperty -Name "*" -DisplayName "Selective suspend" -DisplayValue "Off" -ErrorAction SilentlyContinue
        Write-Host "Дополнительные параметры настроены"
    }
    catch {
        Write-Host "Не удалось настроить дополнительные параметры ($_)"
    }

    Write-Host "Оптимизация сетевых адаптеров завершена."
}

function Optimize-KernelMemorySettings {
    Write-Host "Оптимизация параметров ядра и управления памятью..."

    try {
        $kernelPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel"
        if (-not (Test-Path $kernelPath)) {
            New-Item -Path $kernelPath -Force | Out-Null
        }
        Set-ItemProperty -Path $kernelPath -Name "DisableTsx" -Value 1 -Type DWord -Force
        Write-Host "Параметр DisableTsx установлен."
    }
    catch {
        Write-Host "Не удалось установить параметр DisableTsx: $_"
    }

    try {
        $memoryManagementPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
        if (-not (Test-Path $memoryManagementPath)) {
            New-Item -Path $memoryManagementPath -Force | Out-Null
        }
        Set-ItemProperty -Path $memoryManagementPath -Name "FeatureSettings" -Value 1 -Type DWord -Force
        Set-ItemProperty -Path $memoryManagementPath -Name "FeatureSettingsOverride" -Value 3 -Type DWord -Force
        Set-ItemProperty -Path $memoryManagementPath -Name "FeatureSettingsOverrideMask" -Value 3 -Type DWord -Force
        Write-Host "Параметры FeatureSettings, FeatureSettingsOverride и FeatureSettingsOverrideMask установлены."
    }
    catch {
        Write-Host "Не удалось установить параметры FeatureSettings: $_"
    }

    Write-Host "Оптимизация параметров ядра и управления памятью завершена."
}

function Remove-PowerSchemes {
    Write-Host "Хотите удалить стандартные схемы управления питанием? (Да/Нет)"
    $removePowerSchemes = Read-Host "Введите Да для удаления или Нет для пропуска"
    if ($removePowerSchemes -eq "Да") {
        try {
            powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>&1 | Out-Null
            Write-Host "Схема 'Высокая производительность' удалена."

            powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a 2>&1 | Out-Null
            Write-Host "Схема 'Экономия энергии' удалена."
        }
        catch {
            Write-Host "Не удалось удалить схемы управления питанием: $_"
        }
    }
    else {
        Write-Host "Удаление схем управления питанием пропущено."
    }
}

function Disable-NvidiaTelemetry {
    Write-Host "Отключение телеметрии NVIDIA..."

    try {
        Stop-Service -Name "NvTelemetryContainer" -Force -ErrorAction SilentlyContinue
        Set-Service -Name "NvTelemetryContainer" -StartupType Disabled -ErrorAction SilentlyContinue
        Write-Host "Служба NvTelemetryContainer остановлена и отключена."
    }
    catch {
        Write-Host "Не удалось остановить или отключить службу NvTelemetryContainer: $_"
    }

    $nvidiaTasks = @("NvTmMon", "NvTmRep", "NvTmRepOnLogon", "NvProfileUpdaterDaily", "NvProfileUpdaterOnLogon")
    foreach ($task in $nvidiaTasks) {
        try {
            Disable-ScheduledTask -TaskName $task -ErrorAction SilentlyContinue | Out-Null
            Write-Host "Задача планировщика '$task' отключена."
        }
        catch {
            Write-Host "Не удалось отключить задачу планировщика '$task': $_"
        }
    }

    try {
        $registryPath = "HKCU:\SOFTWARE\NVIDIA Corporation\NVControlPanel2\Client"
        if (-not (Test-Path $registryPath)) {
            New-Item -Path $registryPath -Force | Out-Null
        }
        Set-ItemProperty -Path $registryPath -Name "OptInOrOutPreference" -Value 0 -Type DWord -Force
        Write-Host "Телеметрия NVIDIA отключена через реестр."
    }
    catch {
        Write-Host "Не удалось изменить параметры реестра для телеметрии NVIDIA: $_"
    }

    Write-Host "Телеметрия NVIDIA успешно отключена."
}

function Apply-PrivacyAndTelemetrySettings {
    Write-Host "Применение настроек конфиденциальности и отключения телеметрии..."

    try {
        $accessibilityPath = "HKCU:\Control Panel\Accessibility"
        if (-not (Test-Path $accessibilityPath)) {
            New-Item -Path $accessibilityPath -Force | Out-Null
        }
        Set-ItemProperty -Path $accessibilityPath -Name "StickyKeys" -Value "506" -Type String -Force

        $toggleKeysPath = "$accessibilityPath\ToggleKeys"
        if (-not (Test-Path $toggleKeysPath)) {
            New-Item -Path $toggleKeysPath -Force | Out-Null
        }
        Set-ItemProperty -Path $toggleKeysPath -Name "Flags" -Value "58" -Type String -Force

        $keyboardResponsePath = "$accessibilityPath\Keyboard Response"
        if (-not (Test-Path $keyboardResponsePath)) {
            New-Item -Path $keyboardResponsePath -Force | Out-Null
        }
        Set-ItemProperty -Path $keyboardResponsePath -Name "DelayBeforeAcceptance" -Value "0" -Type String -Force
        Set-ItemProperty -Path $keyboardResponsePath -Name "AutoRepeatRate" -Value "0" -Type String -Force
        Set-ItemProperty -Path $keyboardResponsePath -Name "AutoRepeatDelay" -Value "0" -Type String -Force
        Set-ItemProperty -Path $keyboardResponsePath -Name "Flags" -Value "122" -Type String -Force
        Write-Host "Настройки Accessibility применены."
    }
    catch {
        Write-Host "Ошибка при настройке Accessibility: $_"
    }

    # Отключение рекламы и сбора данных
    try {
        $advertisingInfoPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
        if (-not (Test-Path $advertisingInfoPath)) {
            New-Item -Path $advertisingInfoPath -Force | Out-Null
        }
        Set-ItemProperty -Path $advertisingInfoPath -Name "Enabled" -Value 0 -Type DWord -Force

        $userProfilePath = "HKCU:\Control Panel\International\User Profile"
        if (-not (Test-Path $userProfilePath)) {
            New-Item -Path $userProfilePath -Force | Out-Null
        }
        Set-ItemProperty -Path $userProfilePath -Name "HttpAcceptLanguageOptOut" -Value 1 -Type DWord -Force

        $explorerAdvancedPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        if (-not (Test-Path $explorerAdvancedPath)) {
            New-Item -Path $explorerAdvancedPath -Force | Out-Null
        }
        Set-ItemProperty -Path $explorerAdvancedPath -Name "Start_TrackProgs" -Value 0 -Type DWord -Force

        $contentDeliveryManagerPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
        if (-not (Test-Path $contentDeliveryManagerPath)) {
            New-Item -Path $contentDeliveryManagerPath -Force | Out-Null
        }
        Set-ItemProperty -Path $contentDeliveryManagerPath -Name "SubscribedContent-338393Enabled" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $contentDeliveryManagerPath -Name "SubscribedContent-353694Enabled" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $contentDeliveryManagerPath -Name "SubscribedContent-353696Enabled" -Value 0 -Type DWord -Force

        $trainedDataStorePath = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"
        if (-not (Test-Path $trainedDataStorePath)) {
            New-Item -Path $trainedDataStorePath -Force | Out-Null
        }
        Set-ItemProperty -Path $trainedDataStorePath -Name "HarvestContacts" -Value 0 -Type DWord -Force

        Write-Host "Настройки рекламы и сбора данных применены."
    }
    catch {
        Write-Host "Ошибка при настройке рекламы и сбора данных: $_"
    }

    try {
        $dataCollectionPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
        if (-not (Test-Path $dataCollectionPath)) {
            New-Item -Path $dataCollectionPath -Force | Out-Null
        }
        Set-ItemProperty -Path $dataCollectionPath -Name "DoNotShowFeedbackNotifications" -Value 1 -Type DWord -Force
        Set-ItemProperty -Path $dataCollectionPath -Name "AllowTelemetry" -Value 0 -Type DWord -Force

        $appCompatPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
        if (-not (Test-Path $appCompatPath)) {
            New-Item -Path $appCompatPath -Force | Out-Null
        }
        Set-ItemProperty -Path $appCompatPath -Name "AITEnable" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $appCompatPath -Name "DisableInventory" -Value 1 -Type DWord -Force
        Set-ItemProperty -Path $appCompatPath -Name "DisableUAR" -Value 1 -Type DWord -Force

        Write-Host "Телеметрия отключена."
    }
    catch {
        Write-Host "Ошибка при отключении телеметрии: $_"
    }

    try {
        $attachmentsPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"
        if (-not (Test-Path $attachmentsPath)) {
            New-Item -Path $attachmentsPath -Force | Out-Null
        }
        Set-ItemProperty -Path $attachmentsPath -Name "SaveZoneInformation" -Value 1 -Type DWord -Force

        $privacyPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy"
        if (-not (Test-Path $privacyPath)) {
            New-Item -Path $privacyPath -Force | Out-Null
        }
        Set-ItemProperty -Path $privacyPath -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Value 0 -Type DWord -Force

        $eventTranscriptPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey"
        if (-not (Test-Path $eventTranscriptPath)) {
            New-Item -Path $eventTranscriptPath -Force | Out-Null
        }
        Set-ItemProperty -Path $eventTranscriptPath -Name "EnableEventTranscript" -Value 0 -Type DWord -Force

        $siufRulesPath = "HKCU:\SOFTWARE\Microsoft\Siuf\Rules"
        if (-not (Test-Path $siufRulesPath)) {
            New-Item -Path $siufRulesPath -Force | Out-Null
        }
        Set-ItemProperty -Path $siufRulesPath -Name "NumberOfSIUFInPeriod" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $siufRulesPath -Name "PeriodInNanoSeconds" -Value 0 -Type DWord -Force

        Write-Host "Дополнительные настройки конфиденциальности применены."
    }
    catch {
        Write-Host "Ошибка при применении дополнительных настроек: $_"
    }

    Write-Host "Настройки конфиденциальности и телеметрии успешно применены."
}

function Enable-WindowsPhotoViewer {
    Write-Host "Хотите включить старый смотрельщик фоток Windows Photo Viewer? (Да/Нет)"
    $enablePhotoViewer = Read-Host "Введите Да для включения или Нет для пропуска"
    if ($enablePhotoViewer -eq "Да") {
        try {
            $registryPath = "HKLM:\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations"
            if (-not (Test-Path $registryPath)) {
                New-Item -Path $registryPath -Force | Out-Null
            }

            $fileAssociations = @{
                ".tif"  = "PhotoViewer.FileAssoc.Tiff"
                ".tiff" = "PhotoViewer.FileAssoc.Tiff"
                ".bmp"  = "PhotoViewer.FileAssoc.Tiff"
                ".dib"  = "PhotoViewer.FileAssoc.Tiff"
                ".gif"  = "PhotoViewer.FileAssoc.Tiff"
                ".jfif" = "PhotoViewer.FileAssoc.Tiff"
                ".jpe"  = "PhotoViewer.FileAssoc.Tiff"
                ".jpeg" = "PhotoViewer.FileAssoc.Tiff"
                ".jpg"  = "PhotoViewer.FileAssoc.Tiff"
                ".jxr"  = "PhotoViewer.FileAssoc.Tiff"
                ".png"  = "PhotoViewer.FileAssoc.Tiff"
            }

            foreach ($extension in $fileAssociations.Keys) {
                Set-ItemProperty -Path $registryPath -Name $extension -Value $fileAssociations[$extension] -Type String -Force
            }

            Write-Host "Старый смотрельщик фоток Windows Photo Viewer успешно включен."
        }
        catch {
            Write-Host "Не удалось включить старый смотрельщик фоток Windows Photo Viewer: $_"
        }
    }
    else {
        Write-Host "Старый смотрельщик фоток для Windows Photo Viewer не изменены."
    }
}

function Apply-PerformanceTweaks {
    Write-Host "Применение твиков производительности..."

    try {
        $multimediaPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
        if (-not (Test-Path $multimediaPath)) {
            New-Item -Path $multimediaPath -Force | Out-Null
        }
        Set-ItemProperty -Path $multimediaPath -Name "SystemResponsiveness" -Value 10 -Type DWord -Force
        Set-ItemProperty -Path $multimediaPath -Name "NetworkThrottlingIndex" -Value 10 -Type DWord -Force
        Write-Host "Мультимедийные параметры оптимизированы."
    }
    catch {
        Write-Host "Ошибка при настройке мультимедийных параметров: $_"
    }

    try {
        $desktopPath = "HKCU:\Control Panel\Desktop"
        if (-not (Test-Path $desktopPath)) {
            New-Item -Path $desktopPath -Force | Out-Null
        }
        Set-ItemProperty -Path $desktopPath -Name "AutoEndTasks" -Value "1" -Type String -Force
        Set-ItemProperty -Path $desktopPath -Name "HungAppTimeout" -Value "1000" -Type String -Force
        Set-ItemProperty -Path $desktopPath -Name "WaitToKillAppTimeout" -Value "2000" -Type String -Force
        Set-ItemProperty -Path $desktopPath -Name "LowLevelHooksTimeout" -Value "1000" -Type String -Force
        Set-ItemProperty -Path $desktopPath -Name "MenuShowDelay" -Value "0" -Type String -Force
        Set-ItemProperty -Path $desktopPath -Name "JPEGImportQuality" -Value 128 -Type DWord -Force
        Write-Host "Параметры рабочего стола оптимизированы."
    }
    catch {
        Write-Host "Ошибка при настройке параметров рабочего стола: $_"
    }

    try {
        $controlPath = "HKLM:\SYSTEM\CurrentControlSet\Control"
        if (-not (Test-Path $controlPath)) {
            New-Item -Path $controlPath -Force | Out-Null
        }
        Set-ItemProperty -Path $controlPath -Name "WaitToKillServiceTimeout" -Value "12000" -Type String -Force
        Write-Host "Время ожидания служб оптимизировано."
    }
    catch {
        Write-Host "Ошибка при настройке времени ожидания служб: $_"
    }

    try {
        $memoryManagementPath = "HKLM:\SYSTEM\ControlSet001\Control\Session Manager\Memory Management"
        if (-not (Test-Path $memoryManagementPath)) {
            New-Item -Path $memoryManagementPath -Force | Out-Null
        }
        Set-ItemProperty -Path $memoryManagementPath -Name "LargeSystemCache" -Value 1 -Type DWord -Force
        Write-Host "Кэш памяти оптимизирован."
    }
    catch {
        Write-Host "Ошибка при настройке кэша памяти: $_"
    }

    Write-Host "Твики производительности успешно применены."
}

function Optimize-FileSystemSettings {
    Write-Host "Настройка параметров файловой системы через fsutil..."

    $fsutilCommands = @(
        "allowextchar 0",
        "Bugcheckoncorrupt 0",
        "repair set C: 0",
        "disable8dot3 1",
        "disablecompression 1",
        "disableencryption 1",
        "disablelastaccess 1",
        "disablespotcorruptionhandling 1",
        "encryptpagingfile 0",
        "quotanotify 86400",
        "symlinkevaluation L2L:1",
        "disabledeletenotify 0"
    )

    foreach ($command in $fsutilCommands) {
        try {
            Invoke-Expression "fsutil behavior set $command" | Out-Null
            Write-Host "Установлен параметр: fsutil behavior set $command"
        }
        catch {
            Write-Host "Не удалось установить параметр fsutil: $_"
        }
    }

    Write-Host "Параметры файловой системы успешно настроены."
}

function Disable-ScheduledTasksFromBatch {
    Write-Host "Отключение задач планировщика из списка..."

    $tasks = @(
        "Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319",
        "Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64",
        "Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64 Critical",
        "Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 Critical",
        "Microsoft\Windows\ApplicationData\appuriverifierdaily",
        "Microsoft\Windows\ApplicationData\appuriverifierinstall",
        "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
        "Microsoft\Windows\Application Experience\ProgramDataUpdater",
        "Microsoft\Windows\Application Experience\StartupAppTask",
        "Microsoft\Windows\Device Information\Device",
        "Microsoft\Windows\Diagnosis\Scheduled",
        "Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner",
        "Microsoft\Windows\DiskFootprint\Diagnostics",
        "Microsoft\Windows\DiskFootprint\StorageSense",
        "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload",
        "Microsoft\Windows\Feedback\Siuf\DmClient",
        "Microsoft\Windows\International\Synchronize Language Settings",
        "Microsoft\Windows\LanguageComponentsInstaller\Installation",
        "Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources",
        "Microsoft\Windows\Maps\MapsUpdateTask",
        "Microsoft\Windows\Maps\MapsToastTask",
        "Microsoft\Windows\PushToInstall\Registration",
        "Microsoft\Windows\Setup\SetupCleanupTask",
        "Microsoft\Windows\Speech\SpeechModelDownloadTask",
        "Microsoft\Windows\Windows Error Reporting\QueueReporting",
        "Microsoft\Windows\WindowsColorSystem\Calibration Loader",
        "Microsoft\Windows\Work Folders\Work Folders Logon Synchronization"
    )

    foreach ($task in $tasks) {
        try {
            Disable-ScheduledTask -TaskName $task -ErrorAction SilentlyContinue | Out-Null
            Write-Host "Задача '$task' отключена."
        }
        catch {
            Write-Host "Не удалось отключить задачу '$task': $_"
        }
    }

    Write-Host "Задачи планировщика успешно отключены."
}

function Disable-UnnecessaryServicesFromBatch {
    Write-Host "Отключение дополнительных служб..."

    $services = @(
        "PimIndexMaintenanceSvc",
        "UnistoreSvc",
        "UserDataSvc",
        "CDPUserSvc"
    )

    foreach ($service in $services) {
        try {
            if (Get-Service -Name $service -ErrorAction SilentlyContinue) {
                $registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\$service"
                if (Test-Path $registryPath) {
                    Set-ItemProperty -Path $registryPath -Name "Start" -Value 4 -Type DWord -Force
                    Write-Host "Служба $service отключена."
                }
                else {
                    Write-Host "Служба $service не найдена в реестре."
                }
            }
            else {
                Write-Host "Служба $service не найдена."
            }
        }
        catch {
            Write-Host "Не удалось отключить службу ${service}: $_"
        }
    }

    try {
        Stop-Service -Name "diagsvc" -Force -ErrorAction SilentlyContinue
        sc.exe delete "diagsvc" | Out-Null
        Write-Host "Служба diagsvc остановлена и удалена."
    }
    catch {
        Write-Host "Не удалось остановить или удалить службу diagsvc: $_"
    }

    Write-Host "Дополнительные службы успешно отключены."
}

function Optimize-NUMA {
    Write-Host "Оптимизация NUMA..."
    try {
        # Настройка NUMA параметров
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "NumaProximityNode" -Value 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "NumaSpanFileBuffer" -Value 1
        
        # Включение NUMA группировки
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "GroupSize" -Value 2
        
        Write-Host "NUMA оптимизирован"
    }
    catch {
        Write-Host "Ошибка при оптимизации NUMA: $_"
    }
}

function Optimize-Search {
    Write-Host "Оптимизация поиска..."
    try {
        # Ограничение использования CPU
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Search" -Name "MaxCPUUsagePercent" -Value 50
        
        # Ограничение использования RAM
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Search" -Name "MaxMemUsagePercent" -Value 50
        
        # Отключение индексации файлов реестра
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Search" -Name "PreventIndexingRegistry" -Value 1 -PropertyType DWORD -Force
        
        Write-Host "Поиск оптимизирован"
    }
    catch {
        Write-Host "Ошибка при оптимизации поиска: $_"
    }
}

function Configure-BatteryFlyout {
    Write-Host "Старое меню питание как в windows 7 хотите использовать (Да/Нет)?"
    $useClassicBatteryFlyout = Read-Host "Введите Да для включения или Нет для пропуска"
    if ($useClassicBatteryFlyout -eq "Да") {
        try {
            $registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell"
            $registryKey = "UseWin32BatteryFlyout"
            $registryValue = 1

            if (-not (Test-Path $registryPath)) {
                New-Item -Path $registryPath -Force | Out-Null
            }

            Set-ItemProperty -Path $registryPath -Name $registryKey -Value $registryValue -Type DWord -Force
            Write-Host "Классическое окно батареи включено."
        }
        catch {
            Write-Host "Не удалось включить классическое окно батареи: $_"
        }
    }
    else {
        Write-Host "Изменение классического окна батареи пропущено."
    }
}

function Optimize-GameMode
{
    Write-Host "Выполняем настройку Game Mode..."
    try
    {
        if (-not (Test-Path "HKCU:\Software\Microsoft\GameBar"))
        {
            New-Item -Path "HKCU:\Software\Microsoft\GameBar" -Force | Out-Null
        }
        New-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1 -PropertyType DWORD -Force | Out-Null
        New-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Value 1 -PropertyType DWORD -Force | Out-Null
        Write-Host "Настроен Game Mode"
    }
    catch
    {
        Write-Host "Не удалось настроить Game Mode: $_"
    }
}

function Main
{
    if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    {
        Write-Host "Скрипт должен быть запущен с правами администратора."
        pause
        exit
    }
    
    Write-Host -ForegroundColor Red "ВНИМАНИЕ: Перед выполнением рекомендуется создать точку восстановления системы вручную!"
    Write-Host -ForegroundColor Red "Я не отвечаю за вашу систему, вы делаете все на свой страх и риск!"
    
    $confirm = Read-Host "Продолжить? (Да/Нет)"
    if ($confirm -ne "Да")
    {
        Write-Host "Операция отменена пользователем."
        pause
        exit
    }
    
    Write-Host ""
    Write-Host "=== Начало оптимизации ==="
    Write-Host ""
    
    Optimize-Telemetry
    Clean-TempFiles
    Configure-Security
    Configure-NetworkSettings
    Cleanup-PowerShellTemp
    Delete-SystemRestorePoints
    Disable-UnnecessaryServices
    Remove-PowerSchemes
    Configure-BatteryFlyout
    Optimize-NUMA
    Optimize-Search
    Disable-OneDrive
    Disable-NvidiaTelemetry
    Disable-UnnecessaryServicesFromBatch
    Flush-DNSCache
    Disable-BackgroundTasks
    Disable-XboxServices
    Cleanup-TempDirectories
    Optimize-TCPSettings
    Optimize-NetworkAdapters
    Disable-Hibernation
    Disable-ScheduledTasksFromBatch
    Optimize-FileSystemSettings
    Configure-PowerSettings
    Cleanup-OldUpdates
    Disable-ScheduledTasks
    Enable-TRIM
    Optimize-NetworkIO
    Optimize-DirectX
    Optimize-GameMode
    Optimize-Registry
    Apply-PerformanceTweaks
    Optimize-KernelMemorySettings
    Enable-WindowsPhotoViewer
    Apply-AdditionalRegistrySettings
    Clear-EventLogs
    
    Write-Host ""
    Write-Host "=== Оптимизация завершена ==="
    Write-Host ""
    Write-Host "Для применения перезагрузите компьютер."
    pause
}

Main
Stop-Transcript
Read-Host "Нажмите Enter для выхода"