#
# More  Getting Tokens 
#
# Functions etc
#

cls

$script= @'
function test ($p) {
    Test-Path $p
}
'@

[ref]$errors=$null
[System.Management.Automation.PSParser]::Tokenize($script, $errors) | 
    Format-Table -AutoSize

