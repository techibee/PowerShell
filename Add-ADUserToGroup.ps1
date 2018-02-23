[CmdletBinding()]
param(
    [parameter(Mandatory=$true)]
    [string[]]$UserName,
    [parameter(Mandatory=$true)]
    [string]$GroupName
)
$GroupObj = Get-ADGroup -identity $GroupName -EA 0
if(!$GroupObj) {
    Write-Warning "$GroupName : Group not found in Active Directory"
    return
}
Import-Module ActiveDirectory
foreach($userid in $UserName){
    $userobj = Get-ADUser -identity $userid -EA 0
    if(!$userobj) {
        Write-Warning "$userid : This account is not found"
        continue
    }
    try {
        Add-ADGroupMember -identity $GroupObj -Members $userobj -EA 0
        Write-host "Successfully added $userid to $GroupName"
    } catch {
        Write-Host "$userid : Failed to add to the group"
    }

}
