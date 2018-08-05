#Requires -Module Pester


if ((Get-Module).Name -contains 'OHTools') {
    Remove-Module -Name OHTools
}

Import-Module "$PSScriptRoot\..\OHTools\OHTools.psm1"

#Simple test just to kick things off for testing AppVeyor. Many more to come...

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path "$PSScriptRoot\..\OHTools\OHTools.psd1"
        $? | Should Be $true
    }
}