Function Get-FileVersion
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, HelpMessage = "Enter path to the file:")]
        [ValidatePattern('exe$')]
        [Alias('ItemName')]
        [string]$FileName
    )

		Write-Verbose "Checing $FileName"
        Get-ItemPropertyValue -Path $FileName -Name VersionInfo | Select-Object ProductVersion, FileVersion, CompanyName, FileName
}