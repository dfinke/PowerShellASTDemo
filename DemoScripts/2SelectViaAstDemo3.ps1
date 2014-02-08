#
# Using Select-ViaAST to find functions
#
# See the signal

cls

. .\Select-ViaAST.ps1

Select-ViaAST -Fullname .\test.ps1 -Function | 
    
    
    Select * -ExcludeProperty Line | 
    Format-Table -AutoSize