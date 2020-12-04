<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

## ABOUT
#This utility's purpose is to provide a user friendly Graphic User Interface (GUI) for the built-in Powershell cmdlet 'CertUtil.exe' 

#region GUI
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(748,221)
$Form.text                       = "HASHER:  File Hashing Utility"
$Form.TopMost                    = $false
$Form.icon                       = "\\rkmf-fs-rjtchp\Shared\NACTS\AGoodman\Utils\Hasher\hasher.ico"

$rbutSingleFile                  = New-Object system.Windows.Forms.RadioButton
$rbutSingleFile.text             = "Single File"
$rbutSingleFile.AutoSize         = $true
$rbutSingleFile.width            = 104
$rbutSingleFile.height           = 20
$rbutSingleFile.location         = New-Object System.Drawing.Point(20,18)
$rbutSingleFile.Font             = New-Object System.Drawing.Font('Courier New',10)
$rbutSingleFile.Checked          = $true

$rbutCompare                     = New-Object system.Windows.Forms.RadioButton
$rbutCompare.text                = "Compare Files"
$rbutCompare.AutoSize            = $true
$rbutCompare.width               = 104
$rbutCompare.height              = 20
$rbutCompare.location            = New-Object System.Drawing.Point(140,18)
$rbutCompare.Font                = New-Object System.Drawing.Font('Courier New',10)

$butExport                       = New-Object system.Windows.Forms.Button
$butExport.text                  = "Export"
$butExport.width                 = 60
$butExport.height                = 30
$butExport.location              = New-Object System.Drawing.Point(420,8)
$butExport.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$cbHashType                      = New-Object system.Windows.Forms.ComboBox
$cbHashType.text                 = "Hash Type"
$cbHashType.width                = 100
$cbHashType.height               = 20
@('MD2','MD4','MD5','SHA1','SHA256','SHA384','SHA512') | ForEach-Object {[void] $cbHashType.Items.Add($_)}
$cbHashType.location             = New-Object System.Drawing.Point(285,13)
$cbHashType.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$tbConsole                       = New-Object system.Windows.Forms.RichTextBox
$tbConsole.multiline             = $true
$tbConsole.width                 = 213
$tbConsole.height                = 196
$tbConsole.enabled               = $true
$tbConsole.location              = New-Object System.Drawing.Point(522,13)
$tbConsole.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$tbConsole.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#ababab")

$tbFile1                         = New-Object system.Windows.Forms.TextBox
$tbFile1.multiline               = $false
$tbFile1.width                   = 350
$tbFile1.height                  = 20
$tbFile1.location                = New-Object System.Drawing.Point(99,56)
$tbFile1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$tbFile1.AllowDrop               = $true
$tbFile1.add_DragEnter({DragProcess1($_)})

$tbFile2                         = New-Object system.Windows.Forms.TextBox
$tbFile2.multiline               = $false
$tbFile2.width                   = 350
$tbFile2.height                  = 20
$tbFile2.location                = New-Object System.Drawing.Point(99,84)
$tbFile2.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$tbFile2.AllowDrop               = $true
$tbFile2.add_DragEnter({DragProcess2($_)})

$lbFile1                         = New-Object system.Windows.Forms.Label
$lbFile1.text                    = "File(1) Path:"
$lbFile1.AutoSize                = $true
$lbFile1.width                   = 25
$lbFile1.height                  = 10
$lbFile1.location                = New-Object System.Drawing.Point(16,60)
$lbFile1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$lbFile2                         = New-Object system.Windows.Forms.Label
$lbFile2.text                    = "File(2) Path:"
$lbFile2.AutoSize                = $true
$lbFile2.width                   = 25
$lbFile2.height                  = 10
$lbFile2.location                = New-Object System.Drawing.Point(16,88)
$lbFile2.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$butFile1                        = New-Object system.Windows.Forms.Button
$butFile1.text                   = "Browse"
$butFile1.width                  = 63
$butFile1.height                 = 25
$butFile1.location               = New-Object System.Drawing.Point(453,55)
$butFile1.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$butFile2                        = New-Object system.Windows.Forms.Button
$butFile2.text                   = "Browse"
$butFile2.width                  = 63
$butFile2.height                 = 25
$butFile2.location               = New-Object System.Drawing.Point(453,83)
$butFile2.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$lbFile1Hash                     = New-Object system.Windows.Forms.Label
$lbFile1Hash.text                = "File(1) Hash:"
$lbFile1Hash.AutoSize            = $true
$lbFile1Hash.width               = 25
$lbFile1Hash.height              = 10
$lbFile1Hash.location            = New-Object System.Drawing.Point(126,126)
$lbFile1Hash.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $false
$TextBox1.width                  = 270
$TextBox1.height                 = 20
$TextBox1.location               = New-Object System.Drawing.Point(210,122)
$TextBox1.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$TextBox1.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#ababab")

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $false
$TextBox2.width                  = 270
$TextBox2.height                 = 20
$TextBox2.location               = New-Object System.Drawing.Point(210,150)
$TextBox2.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$TextBox2.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#ababab")

$lbFile2Hash                     = New-Object system.Windows.Forms.Label
$lbFile2Hash.text                = "File(2) Hash:"
$lbFile2Hash.AutoSize            = $true
$lbFile2Hash.width               = 25
$lbFile2Hash.height              = 10
$lbFile2Hash.location            = New-Object System.Drawing.Point(127,154)
$lbFile2Hash.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$panelColor                      = New-Object system.Windows.Forms.Panel
$panelColor.height               = 63
$panelColor.width                = 20
$panelColor.location             = New-Object System.Drawing.Point(487,114)
$panelColor.BackColor            = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$ProgressBar1                    = New-Object system.Windows.Forms.ProgressBar
$ProgressBar1.width              = 504
$ProgressBar1.height             = 30
$ProgressBar1.location           = New-Object System.Drawing.Point(9,180)

$butCheck                        = New-Object system.Windows.Forms.Button
$butCheck.text                   = "Check"
$butCheck.width                  = 89
$butCheck.height                 = 25
$butCheck.location               = New-Object System.Drawing.Point(18,118)
$butCheck.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$butClear                        = New-Object system.Windows.Forms.Button
$butClear.text                   = "Clear"
$butClear.width                  = 89
$butClear.height                 = 25
$butClear.location               = New-Object System.Drawing.Point(18,146)
$butClear.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form.controls.AddRange(@($rbutSingleFile,$rbutCompare,$butExport,$cbHashType,$tbConsole,$tbFile1,$tbFile2,$lbFile1,$lbFile2,$butFile1,$butFile2,$lbFile1Hash,$TextBox1,$TextBox2,$lbFile2Hash,$panelColor,$ProgressBar1,$butCheck,$butClear))

#endregion GUI

#GUI Event Calls
$butCheck.Add_Click({ Go-TheThing })
$butFile1.Add_Click({ Get-FileName1 })
$butFile2.Add_Click({ Get-FileName2 })
$butClear.Add_Click({ Clear-TB })
$butExport.Add_Click({ ExprtHashes })

function DragProcess1 ($object) {
    $tbFile1.Text = ""
    foreach ($file in $object.Data.GetFileDropList()){
        $tbFile1.AppendText($file)
    }
}
function DragProcess2 ($object) {
    $tbFile2.Text = ""
    foreach ($file in $object.Data.GetFileDropList()){
        $tbFile2.AppendText($file)
      }
}

#Clears Hashes and sets loading bar to 0
Function Clear-TB {
    $TextBox1.Text = ""
    $TextBox2.Text = ""
    (SetLoad-Bar -barValue 0)
}

Function Get-FileName1
{  
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
 Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = "C:\"
 $OpenFileDialog.filter = "All files (*.*)| *.*"
 $OpenFileDialog.ShowDialog() | Out-Null
 $tbFile1.text = $OpenFileDialog.filename
}
Function Get-FileName2
{  
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
 Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = "C:\"
 $OpenFileDialog.filter = "All files (*.*)| *.*"
 $OpenFileDialog.ShowDialog() | Out-Null
 $tbFile2.text = $OpenFileDialog.filename
}

function Write-Console {
    param(
            [string] $Message,
            [string] $Color = 'White'
    )
    $tbConsole.SelectionColor = $Color
    $tbConsole.AppendText("$Message `n")
    $tbConsole.Update()
    $tbConsole.ScrollToCaret()
}

function SetLoad-Bar {
    param(
            [int] $barValue
    )
    $ProgressBar1.value = $barValue
}

function Cert-Util {
    param(
            [string] $FilePath,
            [string] $Type
    )
    Certutil.exe -HashFile $FilePath $Type
}

function Get-Hash {
    param(
            [string] $FileIndexPath
    )
    $panelColor.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
    IF ($cbHashType.Text -eq "MD2") {
       $fileHash = Cert-Util -FilePath $FileIndexPath -Type MD2
       $fileHash[1]
    }
    IF ($cbHashType.Text -eq "MD4") {
        $fileHash = Cert-Util -FilePath $FileIndexPath -Type MD4
        $fileHash[1]
     }
     IF ($cbHashType.Text -eq "MD5") {
        $fileHash = Cert-Util -FilePath $FileIndexPath -Type MD5
        $fileHash[1]
     }
     IF ($cbHashType.Text -eq "SHA1") {
        $fileHash = Cert-Util -FilePath $FileIndexPath -Type SHA1
        $fileHash[1]
     }
     IF ($cbHashType.Text -eq "SHA256") {
        $fileHash = Cert-Util -FilePath $FileIndexPath -Type SHA256
        $fileHash[1]
     }
     IF ($cbHashType.Text -eq "SHA384") {
        $fileHash = Cert-Util -FilePath $FileIndexPath -Type SHA384
        $fileHash[1]
     }
     IF ($cbHashType.Text -eq "SHA512") {
        $fileHash = Cert-Util -FilePath $FileIndexPath -Type SHA512
        $fileHash[1]
     }
     IF ($cbHashType.Text -eq "Hash Type") {
        $tbConsole.Text = ""
        Write-Console -Message "Please select a Hash Type" -Color "Red"
        SetLoad-Bar -barValue 0
        $panelColor.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
     }
        Else {

     }
}

function Get-Hashes {
    IF ($rbutCompare.Checked -eq $true) {
        $panelColor.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
        IF ($tbFile2.Text -ne "") {
            SetLoad-Bar -barValue 10
            $TextBox1.Text = (Get-Hash -FileIndexPath $tbFile1.Text)
            SetLoad-Bar -barValue 50
            $TextBox2.Text = (Get-Hash -FileIndexPath $tbFile2.Text)
            SetLoad-Bar -barValue 100
        }
        ELSE {
            $tbConsole.Text = ""
            Write-Console -Message "Please select a second file" -Color "Red"
            $panelColor.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
            SetLoad-Bar -barValue 0
        }
    }
    IF ($rbutSingleFile.Checked -eq $true) {
        $TextBox1.Text = (Get-Hash -FileIndexPath $tbFile1.Text)
        SetLoad-Bar -barValue 100
    }
    IF ($cbHashType.Text -eq "Hash Type") {
        $tbConsole.Text = ""
        Write-Console -Message "Please select a Hash Type" -Color "Red"
        $panelColor.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
        SetLoad-Bar -barValue 0
     }
    ELSE {
    }
}

function Go-Compare {
    $panelColor.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
    IF ($rbutCompare.Checked -eq $true) {
        $panelColor.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
        IF ($TextBox2.Text -ne "") {
            IF ($TextBox1.Text -eq $TextBox2.Text) {
                $panelColor.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#7ED321")
            }
            IF ($TextBox1.Text -ne $TextBox2.Text) {
                $panelColor.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#D0021B")
            }
            IF ($cbHashType.Text -eq "Hash Type") {
                $panelColor.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
            }
        }
    }
}


function Go-TheThing {
    Clear-TB
    $panelColor.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
    SetLoad-Bar -barValue 0
    $tbConsole.Text = ""
    IF ($tbFile1.Text -eq "") {
        $tbConsole.Text = ""
        Write-Console -Message "Please select a file" -Color "Red"
    }

    Else {
        SetLoad-Bar -barValue 10
        Get-Hashes
        Go-Compare
    }
}      

function ExprtHashes {
    If ($TextBox1.Text -ne "") {
        IF ($rbutSingleFile.Checked -eq $True) {
            $File1hash = $TextBox1.Text
            $hashType = $cbHashType.Text
            $file1Dir = $tbFile1.Text
            "File1-HASH>  $File1hash // $hashType" | Out-File -FilePath "C:\Users\$env:USERNAME\Desktop\hash.txt"
            "File1-PATH> $file1Dir" | Out-File -FilePath "C:\Users\$env:USERNAME\Desktop\hash.txt" -Append
        }
        IF ($rbutCompare.Checked -eq $True) {
            $File1hash = $TextBox1.Text
            $File2hash = $TextBox2.Text
            $hashType = $cbHashType.Text
            $file1Dir = $tbFile1.Text
            $file2Dir = $tbFile2.Text
            "File1-HASH>  $File1hash // $hashType" | Out-File -FilePath "C:\Users\$env:USERNAME\Desktop\hash.txt"
            "File1-PATH> $file1Dir" | Out-File -FilePath "C:\Users\$env:USERNAME\Desktop\hash.txt" -Append
            " " | Out-File -FilePath "C:\Users\$env:USERNAME\Desktop\hash.txt" -Append
            "File2-HASH>  $File2hash // $hashType" | Out-File -FilePath "C:\Users\$env:USERNAME\Desktop\hash.txt" -Append
            "File2-PATH> $file2Dir" | Out-File -FilePath "C:\Users\$env:USERNAME\Desktop\hash.txt" -Append
            }

    }
    ELSE {
        Write-Console -Message "No Hash to Export" -Color "RED"
    }
}

#Write your logic code here


$Form.Add_Shown({ (Write-Console -Message "Ready." -Color "Green") })

[void]$Form.ShowDialog()
