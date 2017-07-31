##################################################################################################################

# Please Configure the following variables....

$smtpServer="SERVERNAME"

$expireindays = 7

$from = "Administrator@DOMAINNAME.COM"

###################################################################################################################

#Get Users From AD who are enabled

Import-Module ActiveDirectory

$users = get-aduser -filter * -properties Name, PasswordNeverExpires, PasswordExpired, PasswordLastSet, EmailAddress |where {$_.Enabled -eq "True"} | where { $_.PasswordNeverExpires -eq $false } | where { $_.passwordexpired -eq $false }

foreach ($user in $users)

{

$Name = (Get-ADUser $user | foreach { $_.Name})

$emailaddress = $user.emailaddress

$passwordSetDate = (get-aduser $user -properties * | foreach { $_.PasswordLastSet })

$PasswordPol = (Get-AduserResultantPasswordPolicy $user)

# Check for Fine Grained Password

if (($PasswordPol) -ne $null)

{

$maxPasswordAge = ($PasswordPol).MaxPasswordAge

}

else

{

$maxPasswordAge = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge

}

$expireson = $passwordsetdate + $maxPasswordAge

$today = (get-date)

$daystoexpire = (New-TimeSpan -Start $today -End $Expireson).Days

$subject="Your windows password will expire in $daystoExpire days"

$body = "

Dear $name,

Your windows/exchange email password will expire in $daystoexpire days.
To change your password on a PC press CTRL, ALT, Delete and choose Change Password. 
If you will not be in the office to change your password before the expiry date. 
Note - if you have an iPhone or iPad connected to your email, you will need to update your exchange password there also.
"


if ($daystoexpire -lt $expireindays)

{

Send-Mailmessage -smtpServer $smtpServer -from $from -to $emailaddress -subject $subject -body $body -bodyasHTML -priority High
#Send-Mailmessage -smtpServer $smtpServer -from $from -to indie.sanghera@nebosh.org.uk -subject $subject -body $body -bodyasHTML -priority High

}

}
