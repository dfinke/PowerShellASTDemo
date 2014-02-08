#
# Ast Parse, Input|File
#

cls

$script = @"
    #This is function test1
    function test1 ($p) {}
    function test2 ($p) {}
    function test3 ($p) {}
    filter test4 ($p) {}
    workflow test5 ($p) {}
    net use    
"@

[ref]$tokens=$null
[ref]$errors=$null

$ast = [System.Management.Automation.Language.Parser]::ParseInput($script, $tokens, $errors)
#$ast = [System.Management.Automation.Language.Parser]::ParseFile($fileName, $tokens, $errors)

$ast.FindAll({$args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]}, $true) |
    ForEach {            
        $Type="Function"
        if($_.IsFilter)   {$Type="Filter"}
        if($_.IsWorkflow) {$Type="Workflow"}

        [pscustomobject]@{
            Type=$Type
            Name=$_.Name
        }

    } | ft -a