dsacls "DC=domain,DC=local" /I:T /G "domain\AccountName:CCDC;computer"

dsacls "DC=domain,DC=local" /I:S /G "domain\AccountName:RPWP;;computer"

dsacls "DC=domain,DC=local" /I:S /G "domain\AccountName:RCWD;;computer"

dsacls "DC=domain,DC=local" /I:S /G "domain\AccountName:CA;Change Password;Computer"

dsacls "DC=domain,DC=local" /I:S /G "domain\AccountName:CA;Reset Password;Computer"

dsacls "DC=domain,DC=local" /I:S /G "domain\AccountName:WS;Validated write to DNS host name;Computer"

dsacls "DC=domain,DC=local" /I:S /G "domain\AccountName:WS;Validated write to service principal name;Computer"
