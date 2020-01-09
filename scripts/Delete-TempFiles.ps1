function Delete-TempFiles {
  function Test-IsAdmin {
    ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
  }#close Test-IsAdmin
  if(Test-IsAdmin){
    ## using environment variables will only give you user temp directories.
    ## the following will delete all temp files from all users.
    $TempFolders = @("$env:SystemRoot\Temp\*", 
                    "$($env:SystemDrive)\Users\*\Appdata\Local\Temp\*");
    try{                
      Remove-Item $TempFolders -Recurse -Force -ErrorAction Stop
    }
    catch {
       Write-Error $_ -ErrorAction Stop
    } 
  }
}# close Delete-TempFolderFiles
