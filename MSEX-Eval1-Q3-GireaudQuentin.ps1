New-AddressBookPolicy -Name "Dev-AB" -AddressLists "Département Dev","Département IT" -OfflineAddressBook "\Dev-OAB" -RoomList "Dev-Rooms"

Get-User -Filter 'Department -eq "Dev"' | Set-Mailbox -AddressBookPolicy "DEV-ABP"

