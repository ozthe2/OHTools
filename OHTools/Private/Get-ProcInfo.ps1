Function Get-ProcInfo {
    #Gets Processor information and outputs as an object
    param ($Computer)

    $ProcInfo = Get-CimInstance -ComputerName $Computer -ClassName Win32_Processor -ea SilentlyContinue

    foreach ($Proc in $ProcInfo) {
        [PSCustomObject]@{
            DeviceID          = $Proc.DeviceID
            Manufacturer      = $Proc.Manufacturer
            Name              = $Proc.Name
            Caption           = $Proc.Caption
            MaxClockSpeed     = $Proc.MaxClockSpeed
            Cores             = $Proc.NumberOfCores
            LogicalProcessors = $Proc.NumberOfLogicalProcessors        
        }
    }
}