## the following advanced function starts and rdp session. 

function Start-RDP {
<#   
.SYNOPSIS   
	Function to connect an RDP session without the password prompt
.DESCRIPTION 
	This function provides the functionality to start an RDP session without having to type in the password
.PARAMETER ComputerName
    This can be a single computername or an array of computers to which RDP session will be opened
.PARAMETER Credential
    Optional parameter for the System.Management.Automation.Credential Object to open the RDP connection
.EXAMPLE   
	Start-RDP -ComputerName server01 -Credential (Get-Credential)
.EXAMPLE   
	Start-RDP server01,server02
#>
[CmdletBinding(SupportsShouldProcess=$true, 
                  ConfirmImpact='Medium')]
    PARAM (
        # The host(s) connecting into
        [Parameter(Mandatory=$true,
                    Position=0,
                    ValueFromPipeline=$true,
                    ValueFromPipelineByPropertyName=$true
                    )]
        [Alias("IPAddress")]
        [string[]]$ComputerName,
        # The credential used to connect to the hosts
        [Parameter(Mandatory=$false,
                    Position=1,
                    ValueFromPipeline=$false
                    )]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty,
        # Run as Admin
        [Parameter(Mandatory=$false,
                    Position=3,
                    ValueFromPipeline=$false
                    )]
        [Alias("A")]
            [switch]$Admin
    )
    BEGIN {
        [string]$MstscArguments = ''
        switch ($true) 
        {
            {$Admin} {$MstscArguments += '/admin'}
        }
        if(!($Credential))
        {
            $Credential = Get-Credential
            if(!($Credential))
            {
                write-error "Credential not supplied. Terminating session startup...." -ErrorAction Stop;
            }
        }
    }#end BEGIN
    PROCESS 
    {
        foreach ($Computer in $ComputerName) {
            $ProcessInfo = New-Object System.Diagnostics.ProcessStartInfo
            $Process = New-Object System.Diagnostics.Process
            $User = $Credential.UserName
            $Password = $Credential.GetNetworkCredential().Password
            $ProcessInfo.FileName = "$($env:SystemRoot)\system32\cmdkey.exe"
            $ProcessInfo.Arguments = "/generic:TERMSRV/$Computer /user:$User /pass:$Password"
            $Process.StartInfo = $ProcessInfo
            $Process.Start()

            $ProcessInfo.FileName = "$($env:SystemRoot)\system32\mstsc.exe"
            $ProcessInfo.Arguments = "$MstscArguments /v $Computer"
            $Process.StartInfo = $ProcessInfo
            $Process.Start()
        }
    }#end PROCESS
    END
    {

    }#end END
}#close Start-RDP
