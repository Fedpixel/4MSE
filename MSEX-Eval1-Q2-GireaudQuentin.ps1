Get-POPSettings -Server W2k22Ex | Format-List

Start-Service MSExchangePOP3
Start-Service MSExchangePOP3BE

Set-Service MSExchangePOP3 -StartupType Automatic
Set-Service MSExchangePOP3BE -StartupType Automatic

Set-PopSettings -ExternalConnectionSettings "mail.lab40.newb.fr:995:SSL","mail.lab40.newb.fr:110:TLS" -X509CertificateName mail.lab40.newb.fr.com

Get-Service MSExchangePOP3
Get-Service MSExchangePOP3BE

Restart-Service -Name "MSExchangePOP3"
Restart-Service -Name "MSExchangePOP3BE"