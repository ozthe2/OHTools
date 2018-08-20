Function Test-ComputerConnection {
    #Attempts a CIM connection to a local or remote computer.  Returns true if connected OK otherwise returns false.
    param ($Computer)

    if (Get-CimInstance -ComputerName $Computer -ClassName Win32_ComputerSystem -ea SilentlyContinue) {
        return $true
    }
    else {
        return $false
    }
}