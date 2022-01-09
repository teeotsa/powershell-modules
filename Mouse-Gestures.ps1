Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$Height = [System.Windows.Forms.SystemInformation]::VirtualScreen.Height
$Width  = [System.Windows.Forms.SystemInformation]::VirtualScreen.Width

function Set-MousePosition{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({
            (($_ -gt $Width) -ne $true) -and` 
            (($_ -lt 0) -ne $true)
        })]
        [Int] $PositionX,

        [Parameter(Mandatory = $true)]
        [ValidateScript({
            (($_ -gt $Height) -ne $true) -and` 
            (($_ -lt 0) -ne $true)
        })]
        [Int] $PositionY
    )

    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($PositionX, $PositionY)
}