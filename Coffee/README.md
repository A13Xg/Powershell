[//]: # (SubRepo Version - 1.4)
# Powershell/Coffee
[![Language](https://img.shields.io/badge/Language:-PowerShell-blue)](https://docs.microsoft.com/en-us/powershell/) [![Version](https://img.shields.io/badge/SubRepo_Ver.-1.4-green)](https://docs.microsoft.com/en-us/powershell/)


This code prevents a system from going to sleep due to a forced Group Policy or other machine settings.This is accomplished by toggling the 'Scroll Lock' key on and off every 45 seconds.
>**NOTE:** This application is NOT intended to circumvent security measures. When running this application ensure the system is physically supervised and protected.


---




## Contents

- [What's New](https://github.com/A13Xg/Powershell/tree/main/Coffee#whats-new)
- [Installation](https://github.com/A13Xg/Powershell/tree/main/Coffee#installation)
- [Usage](https://github.com/A13Xg/Powershell/tree/main/Coffee#usage)
    - < more to come >

---

### What's New
> 1. **Added GUI and cmdLine versions of the utility**
>    - coffee-cmd.ps1
>    - coffee-gui.ps1
> 2. **Updated/Optimized**
>    - Used PSObjects instead of seperate variables
>    - Added '*Assets*' folder to store images and icons

## Usage
### GUI
##### Launch the GUI
```Powershell
PS C:\> .\coffee-gui.ps1
```

### cmdLine

#### Start the Script
```Powershell
PS C:\> .\coffee-cmd.ps1
```
>    -> Coffee Script Loaded <-
>
>    Would you like to [Start] or [Stop] Coffee?
```Powershell
PS C:\> Start
```
>   Coffee running...

## Installation
#### Powershell Command Line:
```powershell
PS C:\> Invoke-WebRequest -Uri https://github.com/A13Xg/Powershell/archive/main.zip -OutFile <PATH>.zip
```
-or-
#### Download .Zip File for Release:
[Release](https://github.com/A13Xg/Powershell/releases/tag/v1.2)
> 
> - MD5 Hash: 22bd4974ebf0c28c7e6b39f59d801ce9