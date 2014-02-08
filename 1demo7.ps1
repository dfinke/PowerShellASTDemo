#
# Getting Tokens 
#
# A solution to too much noise
#

cls

$script= @'
#This is function test1
function test1 ($p) {}
function test2 ($p) {}
function test3 ($p) {}

filter test4 ($p) {}

workflow test5 ($p) {}

net use
'@

[ref]$errors=$null
$tokens = [System.Management.Automation.PSParser]::Tokenize($script, $errors) 


$functionNames = for($idx = 0; $idx -lt $tokens.Count ; $idx += 1) {

    $currentToken = $tokens[$idx]
    
    if($currentToken.Type -eq 'Keyword' -and 
       $currentToken.Content -eq 'function') {
        $nextToken = $tokens[$idx+1]
        $nextToken.Content
    }
}

$functionNames | Format-Table