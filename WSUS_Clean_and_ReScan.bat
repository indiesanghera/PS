
net stop wuauserv
rmdir /q /s C:\WINDOWS\SOFTWAREDISTRIBUTION\DOWNLOAD
net start wuauserv
wuauclt /scannow
wuauclt /detectnow
wuauclt /r /ReportNow 

