$ISErrorLogPreference = "c:\errors.txt"

Function Get-ISSystemInfo {
    <#
    .SYNOPSIS
    Queries Local Computer information
    .DESCRIPTION
    Queries OS and hardware information from a computer. This utilises WMI, so the appropriate WMI ports must be open and you must be an Admin on the remote machine. 
    .PARAMETER ComputerName
    The name of the computer to query. Accepts multiple values and accepts pipeline input. 
    .PARAMETER IPAddress
    The IP address of the computer to query. Accepts multiple values and accepts pipeline input. 
    .PARAMETER ShowProgress
    Displays a progress bar showing current operation and percent complete. (does not work when computernames are piped into the command)
    .EXAMPLE
    Get-ISSystemInfo -ComputerName WHATEVER
    This will query information from the computer WHATEVER
    .EXAMPLE
    Get-ISSystemInfo -ComputerName WHATEVER | Format-Table *
    This will query information from the computer WHATEVER and will display the information in a Table. 
    .EXAMPLE
    Get-ISSystemInfo -ComputerName localhost,localhost,localhost,localhost,localhost,localhost,localhost,localhost -ShowProgress
    This will display a progress bar
    .LINK
    http://www.google.com
    #if you run help Get-ISSysteminfo -Online it will open the above link
    #>
    
    #[CmdletBinding()] - This Enable Advanced Features i.e Mandatory Parameters
    [CmdletBinding()]
    #param( ) - This is where you can declare Parameters, and additionl options for those. 
    param(
        [Parameter(Mandatory=$True,
                   ValueFromPipeline=$True,
                   ValuefromPipelineByPropertyName=$True,
                   ParameterSetName='computername',
                   HelpMessage="Computer name to query via WMI")]
        [Alias('hostname')]
        [ValidateLength(4,10)]
        [string[]]$ComputerName,

        [Parameter(Mandatory=$True,
                   ParameterSetName='ip',
                   HelpMessage="IP Address to query via WMI")]  
        [ValidatePattern('\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}')]
        [string[]]$IPAddress,
                        
        [Parameter()]
        [string]$ErrorLogFilePath = $ISErrorLogPreference,

        [switch]$ShowProgress
    )
    BEGIN {
        if ($PSBoundParameters.ContainsKey('ipaddress')) {
            $computername = $IPAddress
            #This puts the IPAddress Value into the $Computername variable so that the below Process works.  
        }
        $each_computer = (100 / ($ComputerName.count) -as [int])
        $current_complete = 0
    }
    PROCESS {
        #Process and foreach, this is so that if you pipeline a number of computernames, it PROCESS's them one by one (foreach).
        foreach ($Computer in $ComputerName) {
            Write-Verbose "Connecting via WMI to $computer"

            if ($computer -eq '127.0.0.1') {
                Write-Warning "Connecting to Local Computer Loopback"
            }
            
            if ($ShowProgress) { Write-Progress -Activity "Message to display $Computer" -PercentComplete $current_complete }

            $os = Get-WmiObject -Class win32_operatingsystem -ComputerName $Computer
            $cs = Get-WmiObject -Class win32_computersystem -ComputerName $Computer
           
            Write-Verbose "Finished with WMI, building output"
            $props = @{'ComputerName'=$Computer;
                       'OSVersion'=$os.version;
                       'OSBuild'=$os.buildnumber
                       'SPVersion'=$os.servicepackmajorversion;
                       'Model'=$cs.model;
                       'Manufacturer'=$cs.manufacturer;
                       'RAM'=$cs.totalphysicalmemory / 1GB -as [int];
                       'Sockets'=$cs.numberofprocessors;
                       'Cores'=$cs.numberoflogicalprocessors;
                       'SystemType'=$cs.SystemType}
            $obj = New-Object -TypeName PSObject -Property $props
        
            Write-Verbose "Outputting to Pipeline"    
            Write-Output $obj
        
            Write-Verbose "Done with $computer"
            $current_complete += $each_computer
        }
    }
    END {}
}


#Examples
#Get-ISSystemInfo -IPAddress 127.0.0.1
#Get-ISSystemInfo -ComputerName localhost,localhost,localhost,localhost
#'localhost','localhost','localhost' | Get-ISSystemInfo
Get-ISSystemInfo -ComputerName localhost,localhost | Format-Table *
#Get-ISSystemInfo -ComputerName localhost,localhost -Verbose



#Shows all of the properties from the WMI class
#Get-WmiObject -Class win32_operatingsystem  | Get-Member
#Get-WmiObject -Class win32_computersystem  | Get-Member

#Warning Preference
##Off
#$WarningPreference = 'SilentlyContinue'
##On
#$WarningPreference = 'Continue'
