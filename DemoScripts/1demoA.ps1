#
# Scriptblocks, Ast.FindAll and FunctionDefinitionAst
#

cls

{
    #This is function test1
    function test1 ($p) {}
    function test2 ($p) {}
    function test3 ($p) {}
    filter test4 ($p) {}
    workflow test5 ($p) {}
    net use    
}.Ast.FindAll(
 { $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true) |
Format-Table -AutoSize