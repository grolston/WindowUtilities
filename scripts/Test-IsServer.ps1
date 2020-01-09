## The following script checks whether the computer if it is a server or workstation. If 
## a server it will return true.

function Test-IsServer { 
    $os = (Get-WmiObject -class Win32_OperatingSystem)
    if($OS.ProductType -NE 1) {  
        $true
    }
    else {
        $false
    }
}#close Test-IsServer
