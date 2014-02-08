function Select-ViaAST { 
    
    param( 
        $Pattern, 
        [Parameter(ValueFromPipeLineByPropertyName)] 
        $Fullname, 
        [Switch]$Function, 
        [Switch]$Variable, 
        [Switch]$Parameter
    ) 

    Begin { 

        function New-ASTItem ($ItemType, $Name, $Fullname, $Extent, $Parent){ 
            [PSCustomObject]@{ 
                Type              = $ItemType 
                Name              = $Name 
                FileName          = $Fullname
                Line              = $Parent.Extent.Text
                StartLineNumber   = $Extent.StartLineNumber
                StartColumnNumber = $Extent.StartColumnNumber
                EndLineNumber     = $Extent.EndLineNumber
                EndColumnNumber   = $Extent.EndColumnNumber
            } 
        } 

        $list = @()

        if($Function)  {$list += 'System.Management.Automation.Language.FunctionDefinitionAst'} 
        if($Variable)  {$list += 'System.Management.Automation.Language.VariableExpressionAst'} 
        if($Parameter) {$list += 'System.Management.Automation.Language.ParamBlockAst'} 
        
        # If no switches, do a FindAll on each AST
        if($list.Count -eq 0) {
            $list = 'System.Management.Automation.Language.FunctionDefinitionAst', `
                    'System.Management.Automation.Language.VariableExpressionAst', `
                    'System.Management.Automation.Language.ParamBlockAst'
        } 

        $predicate = {$list -eq $args[0].GetType().FullName} 
    } 

    Process { 
        
        [ref]$tokens=$null 
        [ref]$errors=$null 
        
        $ast=[System.Management.Automation.Language.Parser]::ParseFile( (Resolve-Path $Fullname), $tokens, $errors) 

        # Normalize the ASTs here for pattern matching 
        $(switch ($ast.FindAll($predicate, $true)) {
                
            {$_ -is [System.Management.Automation.Language.FunctionDefinitionAst]} { 
                New-ASTItem Function $_.Name $Fullname $_.Extent $_.Parent
            } 
                
            {$_ -is [System.Management.Automation.Language.ParamBlockAst]} { 
                $_.Parameters.Extent | ForEach-Object {
                    New-ASTItem Parameter $_ $Fullname $_ $_.Parent
                } 
            } 
                
            {$_ -is [System.Management.Automation.Language.VariableExpressionAst]} { 
                New-ASTItem Variable $_.Extent.Text $Fullname $_.Extent $_.Parent
            } 
        }) | Where {$_.Name -match $Pattern}
        
    } 
}