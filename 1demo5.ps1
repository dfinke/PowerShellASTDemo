#
# Getting Tokens 
#
# Filtering, goal is to get all the names of the functions
#

cls

$script= @'
function test1 ($p) {}
function test2 ($p) {}
function test3 ($p) {}
'@

[ref]$errors=$null

$tokens = [System.Management.Automation.PSParser]::Tokenize($script, $errors) 
$tokens | 
    Where Type -match "Keyword|CommandArgument" | 
    Format-Table -AutoSize