$CPURegistry = "HKLM:\HARDWARE\DESCRIPTION\System\CentralProcessor"
$GPURegistry = "HKLM:\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000"

function Get-ProcessorCores
{
    if(Test-Path "$CPURegistry\0")
    {
        $Count = Get-ChildItem -LiteralPath $CPURegistry | Measure-Object
        Return $Count.Count
    }
}

function Get-ProcessorName
{
    if(Test-Path "$CPURegistry\0")
    {
        if((Get-ItemPropertyValue -Path "$CPURegistry\0" -Name ProcessorNameString).Length -ge 1)
        {
            Return (Get-ItemPropertyValue -Path "$CPURegistry\0" -Name ProcessorNameString)
        }
    }
}

function Get-Graphics
{
    if(Test-Path $GPURegistry)
    {
        if(Test-Path $GPURegistry)
        {
            try
            {
                Return (Get-ItemPropertyValue -Path $GPURegistry -Name "Device Description" -ErrorAction Stop)
            }
            catch
            {
                Return "Not Found"
            }
            Return "Not Found"
        }
    }
    else
    {
        if(Test-Path "HKLM:\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001")
        {
            $GPURegistry = "HKLM:\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001"
            try
            {
                Return (Get-ItemPropertyValue -Path $GPURegistry -Name "Device Description" -ErrorAction Stop)
            }
            catch
            {
                Return "Not Found"
            }
            Return "Not Found"
        }
    }
}