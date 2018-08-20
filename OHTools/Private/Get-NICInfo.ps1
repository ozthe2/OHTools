function Get-NICInfo {
    #Gets NIC information and outputs as an object
    param ($Computer)
    
    $NICInfo = Get-CimInstance Win32_NetworkAdapterConfiguration -ComputerName $Computer -ea SilentlyContinue

    foreach ($Nic in $NICInfo) {
        [PSCustomObject]@{
            Caption        = $nic.Caption
            Index          = $nic.Index
            InterfaceIndex = $NIC.InterfaceIndex
            DHCP           = $nic.DHCPEnabled
            IP             = $nic.IPAddress
            Subnet         = $nic.IPSubnet
            Gateway        = $nic.DefaultIPGateway
            MAC            = $NIC.MACAddress
            DNS            = $NIC.dnsserversearchorder
        }
    }
}