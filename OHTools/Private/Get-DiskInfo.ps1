function Get-DiskInfo {
    #Gets Disk information and outputs as an object
    param ($Computer)
    
    $DiskInfo = Get-CimInstance Win32_LogicalDisk -ComputerName $Computer -filter "drivetype = 3" -ea SilentlyContinue
    foreach ($Disk in $DiskInfo) {
        [PSCustomObject]@{
            DriveLetter = $Disk.DeviceID
            VolumeName  = $Disk.VolumeName
            Size        = $Disk.Size
            Freespace   = $Disk.FreeSpace
        }
    } 
}