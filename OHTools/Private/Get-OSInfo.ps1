Function Get-OSInfo {
    #Gets Operating System information and outputs as an object
    param ($Computer)
    
    $OSInfo = Get-CimInstance -ComputerName $Computer -ClassName Win32_OperatingSystem -ea SilentlyContinue

    [PSCustomObject]@{        
        OS               = $OSInfo.Caption
        Architecture     = $OSinfo.OSArchitecture
        InstallDate      = $OSInfo.InstallDate
        SystemDrive      = $OSInfo.SystemDrive
        WindowsDirectory = $OSInfo.WindowsDirectory
        SystemDirectory  = $OSInfo.SystemDirectory
        Locale           = $OSInfo.Locale
        OSLanguage       = $OSInfo.OSLanguage        
    }
}