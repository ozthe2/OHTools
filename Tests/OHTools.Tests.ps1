#Requires -Module Pester

if ((Get-Module).Name -contains 'OHTools') {
    Remove-Module -Name OHTools
}

Import-Module "$PSScriptRoot\..\OHTools\OHTools.psm1"

InModuleScope OHTools {
    describe "OHTools" { 
        Context "Prereqs" {
            It 'Passes Test-ModuleManifest' {
                Test-ModuleManifest -Path "$PSScriptRoot\..\OHTools\OHTools.psd1"
                $? | Should Be $true
            }
        }

        Context "Input" {
            
            $Cases = @{value = "127.0.0.1"; expected = $true}, @{value = "DoesNotExist"; expected = $false}, @{value = "localhost"; expected = $true}

            it "Attempts to Connect to '<value>' and Returns '<expected>' " -TestCases $cases {        
                param ($value, $expected)
            
                Test-ComputerConnection -Computer $value | should be $expected
            }

            it "Should write a warning if a computer connection fails" {
                mock write-warning {}

                Get-OHComputerInfo -ComputerName "ThisDoesNotExist"

                Assert-MockCalled write-warning -Exactly 1
            }

            it "Should accept pipeline input" {
                $Result = $env:computername, $env:computername | Get-OHComputerInfo
                $result | should not benullorempty
                $result[0].ComputerName | should be $env:computername   
                $result.count -eq 2 | should be true     
            }
        }    

        Context "Execution" {

            it "Get-BiosInfo returns a Custom Object" { 
                Get-BiosInfo -Computer localhost | should beOfType [PSCustomObject]
            }

            it "Get-OSInfo returns a Custom Object" { 
                Get-OSInfo -Computer localhost | should beOfType [PSCustomObject]
            }

            it "Get-CompSysInfo returns a Custom Object" { 
                Get-CompSysInfo -Computer localhost | should beOfType [PSCustomObject]
            }

            it "Get-ProcInfo returns a Custom Object" { 
                Get-ProcInfo -Computer localhost | should beOfType [PSCustomObject]
            }
        
            it "Get-DiskInfo returns a Custom Object" { 
                Get-DiskInfo -Computer localhost | should beOfType [PSCustomObject]
            }

            it "Get-NICInfo returns a Custom Object" { 
                Get-NICInfo -Computer localhost | should beOfType [PSCustomObject]
            }   
        }
   
        context "Output" {

            it "Get-OHComputerInfo returns a Custom Object" { 
                Get-OHComputerInfo -Computer localhost | should beOfType [PSCustomObject]
            }
        }
    }
}