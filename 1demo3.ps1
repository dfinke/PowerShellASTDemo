#
# More  Getting Tokens 
#
# Different white space
#

cls

$script= @'
  $x    	= 	3 * ( $y - $z )
'@


[ref]$errors=$null
$tokens = [System.Management.Automation.PSParser]::Tokenize($script, $errors) 

$tokens | 
    Format-Table -AutoSize
