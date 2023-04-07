$parentDev 	= 'OU=Groups,OU=Dev,OU=UsersEnt,DC=lab40,DC=newb,dc=fr'

New-ADGroup -Name "GG_UsersEnt" -SamAccountName GG_UsersEnt -GroupCategory Security -GroupScope Global -DisplayName "GG_UsersEnt" -Path "OU=UsersEnt,DC=lab40,DC=newb,dc=fr"

New-ADGroup -Name "GG_DEV" -SamAccountName GG_DEV -GroupCategory Security -GroupScope Global -DisplayName "GG_DEV" -Path $parentDEV
New-ADGroup -Name "GS_DEV" -SamAccountName GS_DEV -GroupCategory Security -GroupScope Global -DisplayName "GS_DEV" -Path $parentDEV
New-ADGroup -Name "GS_DEV_Stagiaire" -SamAccountName GS_DEV_Stagiaire -GroupCategory Security -GroupScope Global -DisplayName "GS_DEV_Stagiaire" -Path $parentDEV
New-ADGroup -Name "GS_DEV_Invité" -SamAccountName GS_DEV_Invité -GroupCategory Security -GroupScope Global -DisplayName "GS_DEV_Invité" -Path $parentDEV

New-ADGroup -Name "GL_DEV_ALL" -SamAccountName GL_DEV_ALL -GroupCategory Security -GroupScope DomainLocal -DisplayName "GL_DEV_ALL" -Path $parentDEV
New-ADGroup -Name "GL_DEV_READ" -SamAccountName GL_DEV_READ -GroupCategory Security -GroupScope DomainLocal -DisplayName "GL_DEV_READ" -Path $parentDEV
New-ADGroup -Name "GL_DEV_CREATE" -SamAccountName GL_DEV_CREATE -GroupCategory Security -GroupScope DomainLocal -DisplayName "GL_DEV_CREATE" -Path $parentDEV

Add-ADGroupMember -Identity GL_DEV_ALL -Members GS_DEV
Add-ADGroupMember -Identity GL_DEV_READ -Members GS_DEV_Invité,GS_DEV_Stagiaire
Add-ADGroupMember -Identity GL_DEV_CREATE -Members GS_DEV_Stagiaire

Add-ADGroupMember -Identity GG_DEV -Members GS_DEV,GS_DEV_Invité,GS_DEV_Stagiaire

Add-ADGroupMember -Identity GG_UsersEnt -Members GG_Direction, GG_Vente,GG_IT,GG_RD,GG_RH,GG_DEV
