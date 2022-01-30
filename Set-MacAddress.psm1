function Return-RandomMac
{
    $RandomNum = Get-Random -Minimum 10000000000000 -Maximum 99999999999999
    [String] $ReturnResult = "{0:X}" -f $RandomNum
    return $ReturnResult
}

function Set-MacAddress
{
    param
    (
        [Parameter(Mandatory = $false)]
        [String]
        $MacAddress,

        [Parameter(Mandatory = $false)]
        [Switch]
        $RestartAdapter
    )

    $RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}"

    if (!(Test-Path $RegistryPath))
    {
        Write-Output "Can't find Registry path necessary for this script to function!"
        Write-Output "Press any key to close this script!"
        $ConsoleReadKey = [System.Console]::ReadKey()
        if ($ConsoleReadKey)
        {
            Exit
        }
    }

    if ($MacAddress.Length -lt 12)
    {
        Write-Output "`"$MacAddress`" is not a valid mac address!"
        return
    }

    if ($null -eq $MacAddress)
    {
        Write-Output "`"$MacAddress`" is null?!?!?!?"
        return
    }

    $Count = (Get-ChildItem -Path $RegistryPath -ErrorAction SilentlyContinue).Count
    $Key = ""
    for($i = 0;$i -le $Count;$i++)
    {
        if($i -lt 10)
        {
            $RegPath = "$RegistryPath\000$($i)"
            if (Test-Path $RegPath)
            {
                if((Get-ItemPropertyValue -Path $RegPath -Name DriverDesc).Length -ge 5)
                {
                    if((Get-ItemPropertyValue -Path $RegPath -Name NetworkAddress).Length -ge 5)
                    {
                        $Key = $RegPath
                        break
                    }
                }
            }
        }
        if($i -ge 10)
        {
            $RegPath = "$RegistryPath\00$($i)"
            if (Test-Path $RegPath)
            {
                if((Get-ItemPropertyValue -Path $RegPath -Name DriverDesc).Length -ge 5)
                {
                    if((Get-ItemPropertyValue -Path $RegPath -Name NetworkAddress).Length -ge 5)
                    {
                        $Key = $RegPath
                        break
                    }
                }
            }
        }
    }
    
    try
    {
        if ($RandomMac -ne $null)
        {
            Set-ItemProperty -Path $Key -Name NetworkAddress -Value $MacAddress -Force -ErrorAction Stop
        }
    }
    catch
    {
        Write-Output "Script was unable to change your mac address! Maybe you're missing admin privileges?"
        return
    }

    if ($RestartAdapter)
    {
        Get-NetAdapter -Physical | Restart-NetAdapter
    }
}

function Set-RandomMacAddress
{
    param
    (
        [Parameter(Mandatory = $false)]
        [Switch]
        $RestartAdapter
    )


    $RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}"

    if (!(Test-Path $RegistryPath))
    {
        Write-Output "Can't find Registry path necessary for this script to function!"
        Write-Output "Press any key to close this script!"
        $ConsoleReadKey = [System.Console]::ReadKey()
        if ($ConsoleReadKey)
        {
            Exit
        }
    }

    $Count = (Get-ChildItem -Path $RegistryPath -ErrorAction SilentlyContinue).Count
    $Key = ""
    for($i = 0;$i -le $Count;$i++)
    {
        if($i -lt 10)
        {
            $RegPath = "$RegistryPath\000$($i)"
            if (Test-Path $RegPath)
            {
                if((Get-ItemPropertyValue -Path $RegPath -Name DriverDesc).Length -ge 5)
                {
                    if((Get-ItemPropertyValue -Path $RegPath -Name NetworkAddress).Length -ge 5)
                    {
                        $Key = $RegPath
                        break
                    }
                }
            }
        }
        if($i -ge 10)
        {
            $RegPath = "$RegistryPath\00$($i)"
            if (Test-Path $RegPath)
            {
                if((Get-ItemPropertyValue -Path $RegPath -Name DriverDesc).Length -ge 5)
                {
                    if((Get-ItemPropertyValue -Path $RegPath -Name NetworkAddress).Length -ge 5)
                    {
                        $Key = $RegPath
                        break
                    }
                }
            }
        }
    }
    $RandomMac = Return-RandomMac
    try
    {
        if ($RandomMac -ne $null)
        {
            Set-ItemProperty -Path $Key -Name NetworkAddress -Value $RandomMac -Force -ErrorAction Stop
        }
    }
    catch
    {
        Write-Output "Script was unable to change your mac address! Maybe you're missing admin privileges?"
        return
    }

    if ($RestartAdapter)
    {
        Get-NetAdapter -Physical | Restart-NetAdapter
    }
}
