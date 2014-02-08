#
# Getting Tokens 
#
# Function|Workflow|Filter
#
# Too much noise
#

cls

$script= @'
function test1 ($p) {}
function test2 ($p) {}
function test3 ($p) {}

filter test4 ($p) {}

workflow test5 ($p) {}

net use
'@


[ref]$errors=$null
$tokens = [System.Management.Automation.PSParser]::Tokenize($script, $errors) 

$tokens |
    Where Type -match "Keyword|CommandArgument" | 
    Format-Table -AutoSize