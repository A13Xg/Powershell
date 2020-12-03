<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

## ABOUT
#This script's purpose is to be an importable library of funtions that can be refrenced and used in other utilities.


# Call this function to test if the Codex was imported properly - it will write to console and set $codexImported = $true
$global:codexImported = $true
function testImport {
    Write-Host "Modules Imported Successfully"
}
# // PS Object Example
$myObject = [PSCustomObject]@{
    Name     = 'Kevin'
    Language = 'PowerShell'
    State    = 'Texas'
}
function pingDate {
    Get-Date -Format "MM/dd/yyyy-HH:mm"
}

function loginator {
    param (
        [string] $Message,
        [string] $Path
    )
    $Date = (pingDate)
    "[$Date] ~   $Message" | Out-File -FilePath $Path -Append
}

# Ensure GUI has a textbox designated as the console output and is named '$tbConsole'
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

#// RichTextBox for WPF
Function Write-WPFConsole {
    Param(
        [string]$Message,
        [string]$Color = "Black"
    )

    $RichTextRange = New-Object System.Windows.Documents.TextRange( 
        $tbConsole.Document.ContentEnd,$tbConsole.Document.ContentEnd ) 
    $RichTextRange.Text = "$Message `n"
    $RichTextRange.ApplyPropertyValue( ( [System.Windows.Documents.TextElement]::ForegroundProperty ), $Color )  

}
function Write-CmdLine {
    param(
        [string] $Message,
        [string] $Color = 'White'
    )
   # Colors "Black","Blue","Cyan","DarkBlue","DarkCyan","DarkGray","DarkGreen","DarkMagenta","DarkRed","DarkYellow","Gray","Green","Magenta","Red","White","Yellow"
   Write-Host $Message -ForegroundColor $Color 
}

#Compare the hash of a running script to that of a saved 'Control' hash to ensure script has not been modified. *Hash is stored in MD5*
        #Inputs -ControlHashPath <Path to a file containing your expected correct hash>
        #       -RunningPath <Path to current script that is being ran to compare against control hash>
        #Outputs [BOOLEAN] True / False 

    #//Usage: PS:\> VerifyIntegrity -ControlHashPath <Path to File> -RunningPath <Path to script>
function VerifyIntegrity {
    param(
        [string] $ControlHashPath,
        [string] $RunningPath
    )
    $LiveHash = CertUtil.exe -HashFile $RunningPath MD5
    $ControlHash = Get-Content $ControlHashPath
    IF ($LiveHash -eq $ControlHash) {
        $output = $True
    }
    ELSE {
        $output = $False
    }
    return $output
}

# Hashes the file passed to it
# Assign the function to a variable and then call the variable with '[1]' to return only the string
# Example: $hash = hashItem -FilePath "C:\File.txt" -HashType MD5
# Call the variable like this: $hash[1]
function hashItem {
    param (
        [string] $FilePath,
        [string] $HashType
    )
    Certutil.exe -HashFile $FilePath $HashType
}

#Powershell version of CMD Pause
Function Pause {
    param (
        $Message,
        $Color
    )
    # Check if running Powershell ISE
    if ($userChecks -eq $true) {
        if ($psISE)
        {
            Add-Type -AssemblyName System.Windows.Forms
            [System.Windows.Forms.MessageBox]::Show("$Message")
        }
        else
        {
            Write-Host "$Message" -ForegroundColor $Color
            $x = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
    }
}

# Function to remove Codex Module
function codexRemove {
    $global:codexImported = $null
    Remove-Module fnCodex
}
