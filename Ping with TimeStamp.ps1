#Ping with TimeStamp
ping -t 8.8.8.8|ForEach|{"{0} - {1}" -f (Get-Date),$_}
