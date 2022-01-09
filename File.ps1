function File-Hide{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({
            ((Test-Path $_) -eq $true)
        })]
        [String] $Path
    )
    $FileFound = $false
    try{
        if((Get-Item -Path $Path -ErrorAction SilentlyContinue).Name.Length -ge 2){
            $FileFound = $true
        }
    }
    catch{
        $FileFound = $false
        break;
    }
    if($FileFound){
        (Get-Item -Path $Path).Attributes += [System.IO.FileAttributes]::Hidden
    }
}

function File-UnHide{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({
            ((Test-Path $_) -eq $true)
        })]
        [String] $Path
    )
    try{ 
        $Attributes = (Get-Item -Path $Path -Force).Attributes
        if($Attributes -match "Hidden"){
            (Get-Item -Path $Path -Force).Attributes = (Get-Item -Path $Path -Force).Attributes -bxor [System.IO.FileAttributes]::Hidden
        }
    }
    catch{
        throw [System.IO.IOException]
    }
}