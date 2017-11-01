

### Check services run on domain by specific user

#### Original Source

by Andrew Samuel
https://community.spiceworks.com/scripts/show/856-check-services-run-on-domain-by-specific-user



Description

This script was in answer to the following question: http://community.spiceworks.com/topic/136545-is-there-a-tool-to-search-the-domain-systems-for-a-specific-user-account-being-u

It basically does an LDAP lookup and then loops through each computer on the domain to see which services run under the given user account.

To run it, change line 42 to suit your needs, open a command prompt and browse to the folder where the VBS file is. Then run this command:

cscript.exe serviceChecker.vbs

If you want to log the results to a file use this command:

cscript.exe serviceChecker.vbs >> serviceChecker.log


````vbs
Option Explicit
Dim adoCommand, adoConnection, strBase, strFilter, strAttributes
Dim objRootDSE, strDNSDomain, strQuery, adoRecordset, strName, strCN, strTele
' Setup ADO objects.
Set adoCommand = CreateObject("ADODB.Command")
Set adoConnection = CreateObject("ADODB.Connection")
adoConnection.Provider = "ADsDSOObject"
adoConnection.Open "Active Directory Provider"
adoCommand.ActiveConnection = adoConnection
' Search entire Active Directory domain.
Set objRootDSE = GetObject("LDAP://RootDSE")
strDNSDomain = objRootDSE.Get("defaultNamingContext")
strBase = "<LDAP://" & strDNSDomain & ">"
' Filter on user objects.
strFilter = "(objectCategory=computer)"
' Comma delimited list of attribute values to retrieve.
strAttributes = "name"
' Construct the LDAP syntax query.
strQuery = strBase & ";" & strFilter & ";" & strAttributes & ";subtree"
adoCommand.CommandText = strQuery
adoCommand.Properties("Page Size") = 100
adoCommand.Properties("Timeout") = 30
adoCommand.Properties("Cache Results") = False
' Run the query.
Set adoRecordset = adoCommand.Execute
' Enumerate the resulting recordset.
Do Until adoRecordset.EOF
    ' Retrieve values and display.
    Wscript.Echo adoRecordset.Fields("name").Value
    checkServices(adoRecordset.Fields("name").Value)
    ' Move to the next record in the recordset.
    adoRecordset.MoveNext
Loop
' Clean up.
adoRecordset.Close
adoConnection.Close

Sub checkServices( strServer )
on error resume next
dim strComputer, strStartName, objWMIService, colListOfServices, objService
strComputer = strServer
strStartName = "DOMAIN\\User" 'The double backslash is required to escape

Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colListOfServices = objWMIService.ExecQuery("Select * from Win32_Service where StartName='" & strStartName & "'")
For Each objService in colListOfServices
Wscript.Echo vbTab & objService.DisplayName & VbTab & objService.State & vbtab & objService.StartName

next	
End Sub

wscript.echo "DONE"
````
