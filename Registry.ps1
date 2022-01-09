function Registry-Import{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({
            ((Test-Path $_) -eq $true) -and (((Get-Item -Path $_).Extension) -match "reg")
        })]
        [String] $Path
    )

    try{      
        Start-Process -FilePath CMD -ArgumentList "REG IMPORT $Path" -Verb RunAs -WindowStyle Hidden -ErrorAction Stop
        Write-Host "Registry File was imported."
    }
    catch{
        Write-Host "Failed to import registry file."
    }
}