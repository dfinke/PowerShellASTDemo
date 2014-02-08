#
# Using Select-ViaAST to find 
# several 
#

cls

Select-ViaAST -Fullname .\test.ps1 | 
    
    Select-Object * -ExcludeProperty line | 
    Format-Table -AutoSize 