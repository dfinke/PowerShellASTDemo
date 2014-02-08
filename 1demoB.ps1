#
# Expanded FunctionDefinitionAst. Filters and Workflows
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
}.Ast.FindAll({$args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]} , $true) |
    ForEach {            
        
        $Type="Function"
        
        # Transform properties
        if($_.IsFilter)   {$Type="Filter"}
        if($_.IsWorkflow) {$Type="Workflow"}

        [pscustomobject]@{
            Type=$Type
            Name=$_.Name
        }

    } | Format-Table -AutoSize