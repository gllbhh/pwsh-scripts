Function Get-Message{

    Param(
    [Parameter(Mandatory = $true, HelpMessage = "Enter a message:")]
    [ValidateNotNullorEmpty()]
    [string]$Message
    )
    $Message
}

Get-Message -Message RRRR