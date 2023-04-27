Import-Module ActiveDirectory

function Test-ADUser {
  param(
    [Parameter(Mandatory = $true)]
    [String] $sAMAccountName
  )
  $null -ne ([ADSISearcher] "(sAMAccountName=$sAMAccountName)").FindOne()
}


$Users = Import-Csv -Delimiter ";" -Path ".\MSEX-Eval1-UsersDepDev.csv"

foreach ($u in $Users)
{
	$Ou				= $u.OU
	$Login 			= $u.FirstName[0]+"."+$u.LastName
	$Poste 			= $u.Poste
    $Title          = $u.Poste
	$Password		= "P@ssw0rd"
	$PathOu			= "OU=UsersEnt,DC=lab40,DC=newb,DC=fr"
	$PathUser       = "OU=Users,"
	$PathGroup		= "OU=Groups,"
	$GroupPrefix	= "GS_"
	$GroupOu		= ""
	$Group 			= ""
	
	$OuDirection 	= 'OU=Direction, OU=UsersEnt,DC=lab40,DC=newb,DC=fr'
	$OuVente 		= 'OU=Vente,OU=UsersEnt,DC=lab40,DC=newb,DC=fr'
	$OuIT 			= 'OU=IT,OU=UsersEnt,DC=lab40,DC=newb,DC=fr'
	$OuRD 			= 'OU=RD,OU=UsersEnt,DC=lab40,DC=newb,DC=fr'
	$OuRH 			= 'OU=RH,OU=UsersEnt,DC=lab40,DC=newb,DC=fr'
	$OuMarketing 	= 'OU=Marketing,OU=UsersEnt,DC=lab40,DC=newb,DC=fr'
	$OuDev 	        = 'OU=Dev,OU=UsersEnt,DC=lab40,DC=newb,DC=fr'
  

    if($u.FirstName -ne "")
    {
        if(-Not (Test-ADUser($Login)))
        {
	        #$instance 		= Get-ADUser ctemplate -Properties *
	        $instance 		= Get-ADUser "CN=TemplateUser,OU=UsersEnt,DC=lab40,DC=newb,DC=fr" -Properties company,PostalCode,st,City

	
	        switch ($Ou)
	        {
		        "Direction" { $PathOu = $OuDirection 	; $GroupOu 	= "Direction_"}
		        "Vente" 	{ $PathOu = $OuVente 	 	; $GroupOu 	= "Vente_"}
		        "It" 		{ $PathOu = $OuIT 			; $GroupOu 	= "IT_"}
		        "RD" 		{ $PathOu = $OuRD 			; $GroupOu 	= "RD_"}
		        "Rh" 		{ $PathOu = $OuRH 			; $GroupOu 	= "RH_"}
		        "Marketing" { $PathOu = $OuMarketing 	; $GroupOu 	= "Marketing_"}
		        "Dev"       { $PathOu = $OuDev 	; $GroupOu 	= "Dev_"}

	        }	
	
            
            if($Poste -eq "Responsable" -or $Poste -eq "Directeur"){$Poste =""}

	        $Group= $GroupPrefix+$GroupOu+$Poste
	        if($Poste -eq "") {	$Group = $Group.Substring(0,$Group.Length-1)}
    
    
	        $Path=$PathUser+$PathOu
	        $Group = "CN="+$Group+","+$PathGroup+$PathOu
		
	        $Params = @{
	
		        #Company 			= "ACTUS"
		        DisplayName			= $Login
		        GivenName			= $u.FirstName
		        Name				= $u.FirstName+" "+$u.LastName
		        SamAccountName		= $Login
		        Surname				= $u.LastName
		        UserPrincipalName 	= $Login+"@lab40.newb.fr"
                Department          = $Ou
                Title               = $Title
		        Instance			= $instance

		        AccountPassword=(ConvertTo-SecureString $Password -AsPlainText -Force)
		        Enabled=$true
		        PasswordNeverExpires=$true
		        ChangePasswordAtLogon=$false
		        Path=$Path
	        }
		
	        New-ADUser @Params

	        Add-ADGroupMember -Identity $Group -Members $Login
        }
        else
        {
            Write-Host("Le compte $Login existe déjà")
        }
    }
    else
    {
        Write-Host("Information insufisante")
    }
}




#ex chemin complet d'un Groupe
#CN=GS_Direction,OU=Groups,OU=Direction,OU=UsersEnt,DC=ACTUS,DC=lan

#ex chemin complet d'une OU Users
#OU=Users,OU=Direction,OU=UsersEnt,DC=ACTUS,DC=lan



#https://docs.microsoft.com/fr-fr/system-center/scsm/ad-ds-attribs?view=sc-sm-2019
#cn = Andy Delorme
#company = Axxom
#displayName = Andy Delorme
#givenName = Andy
#mail = toto@aol.fr						=> EmailAddress
#name = Andy Delorme
#SamAccountName = a.delorme
#sn= Delorme									=> Surname
#telephoneNumber = 06.41.15.70.98				=> OfficePhone
#UserPrincipalName = a.delorme@newb.fr
