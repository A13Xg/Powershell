<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

## ABOUT
# This code prevents a system from going to sleep due to a forced Group Policy or other machine settings.
# This is accomplished by toggling the 'Scroll Lock' key on and off every 45 seconds.
# >NOTE< This application is NOT intended to circumvent security measures. When running this application ensure the system is physically supervised and protected.


    #// Function to get current directory and specify path to Assets
$Assets = [PSCustomObject]@{
        ImgFull     = Join-Path -Path (Get-Location) -ChildPath "\Assets\coffee-full.png"
        ImgEmpty    = Join-Path -Path (Get-Location) -ChildPath "\Assets\coffee-empty.png"
        Icon        = Join-Path -Path (Get-Location) -ChildPath "\Assets\coffee.ico"
}

function StatusBang {
        $image.imageLocation = $Assets.ImgFull
    }
    
function StatusUnBang {
        $image.imageLocation = $Assets.ImgEmpty
    }
    
function StayAwake {
        StatusBang
        Start-Job -Name Wakey {
        Write-Host functionRan
            $WShell = New-Object -Com Wscript.Shell
            while (1) {$WShell.SendKeys("{SCROLLLOCK}{SCROLLLOCK}"); sleep 45}
            Write-Host functionRan2
        }
    }
    
function KillAwake {
        Try {
            Stop-Job -Name Wakey
            Remove-Job -Name Wakey
            StatusUnBang
            }
        Catch {
            Write-Host No Job is currently running.
        }
        Finally {
        }
    }
    
    
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(161,207)
$Form.text                       = "Form"
$Form.TopMost                    = $false
$Form.Icon                       = $Assets.Icon

$image                           = New-Object system.Windows.Forms.PictureBox
$image.width                     = 147
$image.height                    = 121
$image.location                  = New-Object System.Drawing.Point(5,5)
$image.imageLocation             = ""
$image.SizeMode                  = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$buttonBang                      = New-Object system.Windows.Forms.Button
$buttonBang.text                 = "Coffee!"
$buttonBang.width                = 144
$buttonBang.height               = 30
$buttonBang.location             = New-Object System.Drawing.Point(8,128)
$buttonBang.Font                 = New-Object System.Drawing.Font('Consolas',17,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$buttonBang.BackColor            = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")

$buttonUnbang                    = New-Object system.Windows.Forms.Button
$buttonUnbang.text               = "UN-Coffee!"
$buttonUnbang.width              = 144
$buttonUnbang.height             = 30
$buttonUnbang.location           = New-Object System.Drawing.Point(8,166)
$buttonUnbang.Font               = New-Object System.Drawing.Font('Consolas',17,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$buttonUnbang.BackColor          = [System.Drawing.ColorTranslator]::FromHtml("#d0021b")

$Form.controls.AddRange(@($image,$buttonBang,$buttonUnbang))

$buttonBang.Add_Click({ StayAwake })
$buttonUnbang.Add_Click({ KillAwake })




#Write your logic code here

[void]$Form.ShowDialog()
    