Function Get-FileVersion
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $True,
                    ValueFromPipeline = $True,
                    ValueFromPipelineByPropertyName = $True,
                    HelpMessage = "One or more filenames:")]
        [ValidatePattern('exe$')]
        [Alias('fn')]
        [string[]]$FileName
    )

    #with pipeline input powershell calls for a Process block
	PROCESS {
		foreach ($File in $FileName){
			Write-Verbose "Checing $File"
			Get-ItemPropertyValue -Path $File -Name VersionInfo | Select-Object ProductVersion, FileVersion, CompanyName, FileName
		}	
	}
}

# Get File Version for each .exe file in Windows folder
# Get-ChildItem C:\Windows\ -Filter *.exe | Select-Object -ExpandProperty FullName | Get-FileVersion