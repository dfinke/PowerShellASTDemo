$users = @{}

# This is the Add-User function
function Add-User {
    param($UserName)

    $users.$UserName=$null
}

function Remove-User {
    <#
        .Synopsis
            This function removes a user
    #>
    param($UserName)

    $users.Remove($UserName)
}

function Find-User {
    param($UserName)

    function Test-InnerFunction { param($innerParam) "Test-InnerFunction"}

    $users.Keys | Where {$_ -match $UserName}
}

Add-User John
Add-User Jane
Add-User Tom
Add-User Harry

Remove-User harry

Find-User h