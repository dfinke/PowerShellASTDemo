#
# Using Select-ViaAST to find other just Parameters
#

cls

Select-ViaAST -Fullname .\test.ps1 -Parameter | Format-Table -AutoSize
