function Hidden-Execute{
    param(
        [Parameter(Mandatory = $false, ParameterSetName = "Command")]
        [Switch] $Command,

        [Parameter(Mandatory = $false)]
        [ValidateScript({
            (($_.Length -ge 1) -eq $true)
        })]
        [String] $CommandToExecute,

        [Parameter(Mandatory = $false, ParameterSetName = "File")]
        [Switch] $File,

        [Parameter(Mandatory = $false)]
        [ValidateScript({
            ((Test-Path $_) -eq $true)
        })]
        [String] $FilePath
    )

    Switch($PSCmdlet.ParameterSetName){
        "Command"{
            Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -Command `"$CommandToExecute`"" -Verb RunAs -WindowStyle Hidden -ErrorAction SilentlyContinue | Out-Null
        }

        "File"{
            Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$FilePath`"" -Verb RunAs -WindowStyle Hidden -ErrorAction SilentlyContinue | Out-Null
        }
    }
}