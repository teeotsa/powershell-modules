function Get-ChromeInstaller
{
    [Alias('gcir')]
    param
    (
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Spcify the path where you'd like to save Chrome's installer."
        )]

        [ValidateScript({
            ((Test-Path $_) -eq $true) -and (([System.IO.File]::GetAttributes($_)) -match "Directory")
        })]

        [String]
        [Alias(
            'Folder', 
            'SavePath', 
            'd', 
            'fo'
        )]
        $Directory,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Do you want to launch installer after downloading it? Then use this parameter!'
        )]

        [Alias(
        'Launch', 
        'la', 
        'l',
        'install'
        )]

        [Switch]
        $Start
    )

    $ChromeLink = "http://dl.google.com/chrome/install/375.126/chrome_installer.exe";

    if (!(Test-Path (Join-Path -Path $Directory -ChildPath 'chromeSetup.exe')))
    {
        $WebClientDownloader = New-Object ([System.Net.WebClient])

        try
        {
            $WebClientDownloader.DownloadFile(
                $ChromeLink,
                (Join-Path -Path $Directory -ChildPath 'chromeSetup.exe')
            )
        }
        catch
        {
            Write-Host "Couldn't download chrome's installer!"
            Return
        }
    }

    if ($Start)
    {
        Start-Process -FilePath (Join-Path -Path $Directory -ChildPath 'chromeSetup.exe') -WindowStyle Hidden -Wait
    }
}

# gcir -fo $env:TEMP -l