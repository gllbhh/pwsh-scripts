Function Get-FileVersion
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, HelpMessage = "One or more file names:")]
        [ValidatePattern('exe$')]
        [Alias('fn')]
        [string[]]$FileName
    )

    foreach ($File in $FileName){
    	Write-Verbose "Checing $File"
        Get-ItemPropertyValue -Path $File -Name VersionInfo | Select-Object ProductVersion, FileVersion, CompanyName, FileName
    }
}