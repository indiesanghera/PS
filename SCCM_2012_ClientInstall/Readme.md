' ConfigMgr Startup Script  
' Version 1.70  
' Jason Sandys  
' http://blog.configmgrftw.com 
' Step by Step Instructions - http://eskonr.com/2016/09/sccm-configmgr-how-to-implement-jason-sandys-client-startup-script-to-achieve-good-client-success-rate/


## Edit XML
need to update Servername, Site Code etc


## Group Policy  
Computer Configuration  
Windows Settings  
Scripts  
Startup  
Name = ConfigMgrStartup1.75.vbs  
Parameters =    /config:ConfigMgrStartup.xml
