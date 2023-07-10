function export-gpo ($pth) {
    $xmlObject = [XML](Get-Content -Path $pth)
    return $xmlObject.report.GPO | ForEach-Object {
       

        $_ | select-object name,
        @{l='OwnerName';e={$_.SecurityDescriptor.Owner.Name.'#text'}} ,
        @{l='TrusteePermissions';e={$i=$null; foreach ($i in $_.SecurityDescriptor.Permissions.TrusteePermissions) {
         $i.type.permissiontype + " - " + $i.trustee.name.'#text' + " - " + $i.Standard.GPOGroupedAccessEnum + "#"
    
        }}},
        @{l='ComputerEnabled';e={$_.Computer.Enabled}} ,
        @{l='Computer Extension';e={$i=$null; foreach ($i in $_.Computer.ExtensionData) {
        $i.Extension.type + "#"
       
        }}},
        @{l='UserEnabled';e={$_.User.Enabled}} ,
        @{l='User Extension';e={$i=$null; foreach ($i in $_.User.ExtensionData) {
        $i.Extension.type + "#"
    
        }}},
        @{l='LinkTo';e={$i=$null; foreach ($i in $_.LinksTo) {
        $i.SOMPath + " - " + $i.Enabled + "#"
    
        }}}

    }
#>
     
    }


export-gpo -pth C:\1\\GPOReportsAll.xml | Export-Csv -Path C:\1\\gpo.csv -Force -Encoding Unicode -Delimiter ";"
