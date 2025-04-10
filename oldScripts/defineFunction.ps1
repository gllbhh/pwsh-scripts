function Test-SpaceX {
    [CmdletBinding()] # turns into adv. function
    param(
        [Parameter(Mandatory)] # if mandatory parameter is not specified, it will ask user input on it
        [int32]$pingCount
        )
        Test-Connection spacex.com -Count $pingCount
        #ping spacex.com
}

Test-SpaceX