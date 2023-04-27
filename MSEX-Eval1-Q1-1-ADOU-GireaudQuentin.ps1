Import-Module ActiveDirectory

$parentOU = 'OU=UsersEnt,DC=lab40,DC=newb,DC=fr'

$parentOUDev  = 'OU=Dev,'+ $parentOU


New-ADOrganizationalUnit -Name "UsersEnt" -DisplayName "UsersEnt" -path "DC=lab40,DC=newb,DC=fr"


New-ADOrganizationalUnit -Name "Dev" -DisplayName "Dev" -path $parentOU


New-ADOrganizationalUnit -Name "Computers" -DisplayName "Computers" -path $parentOUDev
New-ADOrganizationalUnit -Name "Groups" -DisplayName "Groups"-path $parentOUDev
New-ADOrganizationalUnit -Name "Users" -DisplayName "Users"-path $parentOUDev