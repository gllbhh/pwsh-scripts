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
			$version = Get-ItemPropertyValue -Path $File -Name VersionInfo | Select-Object ProductVersion, FileVersion, CompanyName, FileName
		    $CreationDate = Get-ItemProperty -Path $File | Select -ExpandProperty CreationTime
            $LastAccessDate = Get-ItemProperty -Path $File | Select -ExpandProperty LastAccessTime
            $Properties = @{
                            'FileName' = $File;
                            'ProductVersion' = $version.ProductVersion;
                            'FileVersion' = $version.FileVersion;
                            'CreationDate' = $CreationDate;
                            'LastAccessDate' = $LastAccessDate;
                            }
            $Output = New-Object -TypeName PSObject -Property $Properties
            Write-Output $Output
        }	
	}
}

# Get File Version for each .exe file in Windows folder
# Get-ChildItem C:\Windows\ -Filter *.exe | Select-Object -ExpandProperty FullName | Get-FileVersion