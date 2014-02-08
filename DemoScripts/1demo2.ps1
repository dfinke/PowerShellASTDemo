#
# Getting Tokens 
#
# Who, What and Where
#
cls

$script= "1 + 1"

[ref]$errors=$null
[System.Management.Automation.PSParser]::Tokenize($script, $errors) | 
    Format-Table -AutoSize
