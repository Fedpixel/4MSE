Set-MailboxDatabase Lab40VipDB1 -IsExcludedFromProvisioning $True
Get-User | Where-Object {$_.
OrganizationalUnit -notlike '*IT*' -and $_.OrganizationalUnit -notlike '*Direction*' -and $_.OrganizationalUnit -ne 'lab40.newb.fr/Users'} | Enable-Mailbox -DataBase Lab50UserDB1, Lab40UserDB2
Get-Mailbox | Group-Object -Property:Database | Select-Object Name,Count | Sort-Object Name | Format-Table -Auto