function Backup-Registry
{
    Write-Host "Backing up registry keys... Wait"

    if (!(Test-Path $PSScriptRoot\RegistryBackups))
    {
        New-Item -Path $PSScriptRoot\RegistryBackups -ItemType Directory -Force | Out-Null
        Write-Host "Created backup folder for Registry Files!"
    }

    if (Test-Path $PSScriptRoot\RegistryBackups\CURRENTUSER.reg)
    {
        if ([System.Windows.Forms.MessageBox]::Show("Current User registry backup is found, do you want to remove it? This is necessary if you'd like to backup your registry keys!", [String]::Empty, [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Information) -match "Yes")
        {
            Remove-Item -Path $PSScriptRoot\RegistryBackups\CURRENTUSER.reg -Force
            Write-Host "Previous Current User backup was removed!"
        }
    }

    if (Test-Path $PSScriptRoot\RegistryBackups\LOCALMACHINE.reg)
    {
        if ([System.Windows.Forms.MessageBox]::Show("Local Machine registry backup is found, do you want to remove it? This is necessary if you'd like to backup your registry keys!", [String]::Empty, [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Information) -match "Yes")
        {
            Remove-Item -Path $PSScriptRoot\RegistryBackups\LOCALMACHINE.reg -Force
            Write-Host "Previous Local Machine backup was removed!"
        }
    }

    if (Test-Path $PSScriptRoot\RegistryBackups\CLASSESROOT.reg)
    {
        if ([System.Windows.Forms.MessageBox]::Show("Classes Root registry backup is found, do you want to remove it? This is necessary if you'd like to backup your registry keys!", [String]::Empty, [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Information) -match "Yes")
        {
            Remove-Item -Path $PSScriptRoot\RegistryBackups\CLASSESROOT.reg -Force
            Write-Host "Previous Classes Root backup was removed!"
        }
    }

    if (!(Test-Path $PSScriptRoot\RegistryBackups\CURRENTUSER.reg))
    {
        try
        {
            REG EXPORT ([Microsoft.Win32.Registry]::CurrentUser) $PSScriptRoot\RegistryBackups\CURRENTUSER.reg
        }
        catch
        {
            Write-Host "Failed to backup Current User's registry!"
        }
    }

    if (!(Test-Path $PSScriptRoot\RegistryBackups\LOCALMACHINE.reg))
    {
        try
        {
            REG EXPORT ([Microsoft.Win32.Registry]::LocalMachine) $PSScriptRoot\RegistryBackups\LOCALMACHINE.reg
        }
        catch
        {
            Write-Host "Failed to backup Local Machine's registry!"
        } 
    }

    if (!(Test-Path $PSScriptRoot\RegistryBackups\CLASSESROOT.reg))
    {
        try
        {
            REG EXPORT ([Microsoft.Win32.Registry]::ClassesRoot) $PSScriptRoot\RegistryBackups\CLASSESROOT.reg
        }
        catch
        {
            Write-Host "Failed to backup Classes Root registry!"
        }
    }
    Write-Host "Registry Backup is done!"
}

Backup-Registry