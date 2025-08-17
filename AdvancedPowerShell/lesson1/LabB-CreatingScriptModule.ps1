Function Get-FileVersion
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory)]
        [string]$FileName
    )

    PROCESS
    {
        Get-ItemPropertyValue -Path $FileName -Name VersionInfo | Select-Object ProductVersion, FileVersion, CompanyName, FileName
    }

}