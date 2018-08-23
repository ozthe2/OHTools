---
external help file: OHTools-help.xml
Module Name: ohtools
online version:
schema: 2.0.0
---

# Get-OHComputerInfo

## SYNOPSIS
Gets computer information such as NIC, OS, Disks, processor details etc.

## SYNTAX

```
Get-OHComputerInfo [[-ComputerName] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
By default, this will pull basic but fundamental info from the computer such as OS, OSBuild, OS Service Pack version, OS Architecture and Manufacturer.  (The Manufacturer will let you know if the computer is virtual or not)
Use the -verbose switch to see which computers failed the connection test.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-OHComputerInfo
```
```
ComputerName   : UKLGWLAP150
OS             : Microsoft Windows 10 Enterprise
OSBuild        : 16299
OSSPVersion    : 0
OSArchitecture : 64-bit
Manufacturer   : Dell Inc.
```

The computer system information of the local host will be displayed on screen.

### EXAMPLE 2
```powershell
'computer1','computer2' | Get-OHComputerInfo
```

The computer information of 'Computer1' and 'Computer2' will be displayed on screen.

### EXAMPLE 3
```powershell
(get-adcomputer -filter * -SearchBase 'ou=servers,ou=MyOU,dc=mydomain,dc=local').name  | Get-OHComputerInfo | export-csv C:\Output.csv -NoTypeInformation
```

The computer objects in the OU obtained by 'Get-ADComputer' will have all available computer information output to a CSV file.

### EXAMPLE 4
```powershell
get-content c:\ohtemp\servers.txt | Get-OHComputerInfo
```

The computer names contained in Servers.txt will be used as the input of the command.

### EXAMPLE 5
```powershell
Get-OHComputerInfo | out-file  ('{0}{1}{2}' -f "C:\temp\Output-", (get-date -Format MMMyyy), ".log")
```

The local computer will be queried, and the result written to a dated file named 'Output-MonthYear.log'

## PARAMETERS

### -ComputerName
The name of the computer that you wish to query.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $env:COMPUTERNAME
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
https://www.fearthepanda.com  
Https://github.com/ozthe2


## RELATED LINKS
