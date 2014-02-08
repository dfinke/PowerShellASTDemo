Function Expand-Alias {

    $Editor=$psISE.CurrentFile.Editor
    $script=$Editor.Text

    [ref]$errors=$null
    [System.Management.Automation.PsParser]::Tokenize($script, $errors) |
        Where { $_.Type -eq 'Command'} |
        Sort StartLine, StartColumn -Desc |
    
    ForEach {
      if($_.Content -eq '?')
        { $result = Get-Command '`?' -CommandType Alias } 
        else 
        { $result = Get-Command $_.Content -CommandType Alias -ErrorAction SilentlyContinue }

      if($result)
      {
        $Editor.Select($_.StartLine,$_.StartColumn,$_.EndLine,$_.EndColumn)
        $Editor.InsertText($result.Definition)
      }
    }
}