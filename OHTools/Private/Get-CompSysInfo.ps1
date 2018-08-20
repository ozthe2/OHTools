Function Get-CompSysInfo {
    #Gets Computer System information and outputs as an object
    <#
        Later, the script will be expanded to pull installed Roles & Features if it is a server...
        --- DomainRole ---
        0 {"Standalone Workstation"}
        1 {"Member Workstation"}
        2 {"Standalone Server"}
        3 {"Member Server"}
        4 {"Backup Domain Controller"}
        5 {"Primary Domain Controller"}
    #>
    param ($Computer)

    $CompSysInfo = Get-CimInstance -ComputerName $Computer -ClassName Win32_ComputerSystem -ea SilentlyContinue

    [PSCustomObject]@{
        ComputerName = $CompSysInfo.Name
        DomainRole   = $CompSysInfo.DomainRole
        Manufacturer = $CompSysInfo.Manufacturer
        Model        = $CompSysInfo.Model
        Memory       = $CompSysInfo.TotalPhysicalMemory
    }
}