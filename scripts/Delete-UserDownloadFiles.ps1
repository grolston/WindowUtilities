function Delete-UserDownloadFiles {
  function Test-IsAdmin {
    ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
  }#close Test-IsAdmin
  if(Test-IsAdmin){
    ## the following will delete all files in the users download directory
    $DownloadFolders = @("$($env:SystemDrive)\Users\*\Downloads\*")
    try{
      Remove-Item $DownloadFolders -Recurse -Force -ErrorAction Stop
    }
    catch {
       Write-Error $_ -ErrorAction Stop
    } 
  } 
}#close Delete-UserDownloadFiles
