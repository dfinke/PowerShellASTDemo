. .\Select-ViaAST.ps1

[xml]$MainWindow=@'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"       
        WindowStartupLocation="CenterScreen"
        Title="PSHarp" Height="550" Width="825">
    <Grid>
        <Grid.RowDefinitions>        
            <RowDefinition Height="*" />
        </Grid.RowDefinitions>

        <ListView x:Name="ResultsPane" Margin="5" FontSize="28">
            <ListView.View>
                <GridView>
                    <GridViewColumn Width="140" Header="LineNumber" DisplayMemberBinding="{Binding StartLineNumber}"/>
                    <GridViewColumn Width="140" Header="Type" DisplayMemberBinding="{Binding Type}"/>
                    <GridViewColumn Width="140" Header="Name" DisplayMemberBinding="{Binding Name}"/>
                    <GridViewColumn Width="140" Header="FileName" DisplayMemberBinding="{Binding FileName}"/>
                </GridView>
            </ListView.View>
        </ListView>
    </Grid>
</Window>
'@

cls

$XmlNodeReader = New-Object System.Xml.XmlNodeReader ($MainWindow)
$Window = [Windows.Markup.XamlReader]::Load($XmlNodeReader)

$ResultsPane=$Window.FindName("ResultsPane")

$ResultsPane.ItemsSource = Select-ViaAST -Fullname .\test.ps1

[void]$Window.ShowDialog()