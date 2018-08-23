Function Get-OHComputerInfo {
   # .ExternalHelp OHTools-help.xml  

    [CmdletBinding(HelpURI='https://github.com/ozthe2/OHTools/blob/master/Docs/Get-OHComputerInfo.md')]
    param(
        [Parameter(	    
            ValueFromPipelineByPropertyName = $true,
            ValueFromPipeline = $true)]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )

    begin {}

    process {
        foreach ($Computer in $ComputerName) {
            Write-Verbose "Trying to connect to computer: $Computer."
            if (!(Test-ComputerConnection -Computer $Computer)) {
                write-warning "Unable to connect to $computer`n"
                continue
            }

            write-verbose "Getting the information!"
            $CompSysInfo = Get-CompSysInfo -Computer $Computer
            $OSInfo = Get-OSInfo -Computer $Computer
            $BiosInfo = Get-BIOSInfo -Computer $Computer
            $ProcInfo = Get-ProcInfo -Computer $Computer
            $DiskInfo = Get-DiskInfo -Computer $Computer
            $NICInfo = Get-NICInfo -Computer $Computer

            #Create an object
            $Obj = [PSCustomObject]@{
                ComputerName       = $CompSysInfo.ComputerName                
                DomainRole         = $CompSysInfo.DomainRole
                Manufacturer       = $CompSysInfo.Manufacturer
                Model              = $CompSysInfo.Model
                Memory             = $CompSysInfo.Memory
                OS                 = $OSInfo.OS
                OSBuild            = $OSInfo.OSBuild
                OSSPVersion        = $OSInfo.OSSPVersion
                OSArchitecture     = $OSinfo.Architecture
                OSInstallDate      = $OSInfo.InstallDate
                OSSystemDrive      = $OSInfo.SystemDrive
                OSWindowsDirectory = $OSInfo.WindowsDirectory
                OSSystemDirectory  = $OSInfo.SystemDirectory
                OSLocale           = $OSInfo.Locale
                OSLanguage         = $OSInfo.OSLanguage
                BiosManufacturer   = $BiosInfo.Manufacturer
                BiosSMVersion      = $BiosInfo.SMVersion
                BIOSVersion        = $BiosInfo.BIOSVersion               
            } 

            Foreach ($Processor in $ProcInfo) {
                $obj | Add-Member -MemberType NoteProperty -Name "ProcID($($processor.deviceID))"  -value $Processor.DeviceID
                $obj | Add-Member -MemberType NoteProperty -Name "ProcManufacturer($($processor.deviceID))"  -value $Processor.Manufacturer
                $obj | Add-Member -MemberType NoteProperty -Name "ProcCaption($($processor.deviceID))"  -value $Processor.Caption
                $obj | Add-Member -MemberType NoteProperty -Name "ProcName($($processor.deviceID))"  -value $Processor.Name
                $obj | Add-Member -MemberType NoteProperty -Name "ProcSpeed($($processor.deviceID))"  -value $Processor.MaxClockSpeed
                $obj | Add-Member -MemberType NoteProperty -Name "ProcCores($($processor.deviceID))"  -value $Processor.Cores
                $obj | Add-Member -MemberType NoteProperty -Name "ProcLogicalProcessors($($processor.deviceID))"  -value $Processor.LogicalProcessors
            }
            
            Foreach ($Disk in $DiskInfo) {
                $size = ([math]::round(($disk.size/1GB),2))
                $free = ([math]::round(($disk.freespace/1GB),2))
                $obj | Add-Member -MemberType NoteProperty -Name "DriveLetter($($disk.DriveLetter))" -value $disk.DriveLetter    
                $obj | Add-Member -MemberType NoteProperty -Name "VolumeName($($disk.DriveLetter))"  -value $disk.volumename
                $obj | Add-Member -MemberType NoteProperty -Name "DiskSize($($disk.DriveLetter))"  -value "$size GB"
                $obj | Add-Member -MemberType NoteProperty -Name "DiskFreespace($($disk.DriveLetter))"  -value "$free GB"
            }
            
            foreach ($Network in $NICInfo) {
                if ($null -eq $network.ip) {
                    continue
                }
                else {
                    $obj | Add-Member -MemberType NoteProperty -Name "IPAddressIndex($($network.index[0]))"  -value $($Network.index[0])
                    $obj | Add-Member -MemberType NoteProperty -Name "IPAddress($($network.index[0]))"  -value $($Network.ip[0])
                }                  

                if ($NULL -eq $network.subnet) {
                    $obj | Add-Member -MemberType NoteProperty -Name "Subnet($($network.index[0]))"  -value ""
                }
                else {
                    $obj | Add-Member -MemberType NoteProperty -Name "Subnet($($network.index[0]))"  -value $($Network.subnet[0])
                }

                if ($Null -eq $network.gateway) {
                    $obj | Add-Member -MemberType NoteProperty -Name "Gateway($($network.index[0]))"  -value ""
                }
                else {
                    $obj | Add-Member -MemberType NoteProperty -Name "Gateway($($network.index[0]))"  -value $($Network.gateway[0])
                }

                if ($NULL -eq $network.dhcp) {
                    $obj | Add-Member -MemberType NoteProperty -Name "DHCPEnabled($($network.index[0]))"  -value "False"
                }
                else {
                    $obj | Add-Member -MemberType NoteProperty -Name "DHCPEnabled($($network.index[0]))"  -value $($Network.dhcp[0])
                }

                if ($NULL -eq $network.dns) {
                    $obj | Add-Member -MemberType NoteProperty -Name "DNS($($network.index[0]))"  -value ""
                }
                else {
                    $obj | Add-Member -MemberType NoteProperty -Name "DNS($($network.index[0]))"  -value (@($Network.dns) -join ',')
                }

                if ($NULL -eq $network.MAC) {
                    $obj | Add-Member -MemberType NoteProperty -Name "MAC($($network.index[0]))"  -value ""
                }
                else {
                    $obj | Add-Member -MemberType NoteProperty -Name "MAC($($network.index[0]))"  -value $($Network.MAC)
                }

            }# foreach $network            
            
            $obj.psobject.TypeNames.Insert(0, 'OH.OHTools.OHComputerInfo')
            $obj

        }#foreach
    }#proc

}#function