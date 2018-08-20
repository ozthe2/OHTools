Function Get-BIOSInfo {
    #Gets BIOS information and outputs as an object
    param ($Computer)
    
    $BiosInfo = Get-CimInstance -ComputerName $Computer -ClassName Win32_BIOS -ea SilentlyContinue

    [PSCustomObject]@{
        Manufacturer = $BiosInfo.Manufacturer
        SMVersion    = $BiosInfo.SMBIOSBIOSVersion
        BIOSVersion  = $BiosInfo.BIOSVersion
    }
}