Function Test-ScriptBlock
{
    [CmdletBinding()]
    Param
    (
        [Parameter(ValueFromPipeline)]
        [int]$Number,

        [Parameter(Mandatory)]
        [string]$String
    )
    BEGIN
    {
        Write-Host "Begin block: create log files or variables"
    }

    PROCESS
    {
        Write-Host "Process block: main script"
        Write-Host "$Number $String"
    }

    END
    {
        Write-Host "End block: clenup"
    }
}

1,2,3 | Test-ScriptBlock