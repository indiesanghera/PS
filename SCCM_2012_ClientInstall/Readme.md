' ConfigMgr Startup Script  
' Version 1.70  
' Jason Sandys  
' http://blog.configmgrftw.com


## Edit XML
need to update Servername, Site Code etc


## Group Policy  
Computer Configuration  
Windows Settings  
Scripts  
Startup  
Name = ConfigMgrStartup1.75.vbs  
Parameters =    /config:ConfigMgrStartup.xml
