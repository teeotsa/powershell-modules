function Get-WindowsVersion
{
    param(
        [Parameter(Mandatory = $false, HelpMessage = "Simplifies Windows Version")]
        [Switch] $Simple
    )

    [String] $FinalValue
    [String] $WindowsRegistry = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"

    if((Get-ItemPropertyValue -Path $WindowsRegistry -Name ProductName).Length -ge 5)
    {
        
        if($Simple)
        {
            try
            {
                [String] $Value = Get-ItemPropertyValue -Path $WindowsRegistry -Name ProductName
                @("Pro", "Enterprise", "Core", "Home", "Ultimate", "Home Premium", "Premium") | ForEach-Object{
                    if($Value -match $_)
                    {
                        $Value = $Value.Replace($_, "");
                    }
                }
                Return $Value
            }
            catch
            {
                Write-Host "Couldn't get Windows Version"
            }
        }
        Return (Get-ItemPropertyValue -Path $WindowsRegistry -Name ProductName)
    }
    else
    {
        Write-Host "Couldn't get Windows Version"
    }
}