#
# Refining the select string
#
#

$script= @'
#This is function test1
function test1 ($p) {}
function test2 ($p) {}
function test3 ($p) {}

filter test4 ($p) {}

workflow test5 ($p) {}

net use
'@

cls

$r = ($script -split "`r`n") | 
        Select-String "^function\s+(?<functionName>\w+)"

$r.Matches | foreach {$_.Groups["functionName"].Value}