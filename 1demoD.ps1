#
# Find all parameter/function definitions
#
# Not ParamBlocks

cls

{    
    function test1 ($test1Parameter)    {}
    function test2 ($test2Parameter)    {}
    function test3 ($test3Parameter)    {}
    filter   test4 ($filterParameter)   {}
    workflow test5 ($workflowParameter) {}
    net use    
}.Ast.FindAll({
    $args[0] -is [System.Management.Automation.Language.ParameterAst] -Or
    $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]}, $true) | 

    Select Name, IsFilter, IsWorkflow, @{Name="Type"; Expression={$_.GetType().Name}} |
    Format-Table -AutoSize