function Delete-UserDesktopFiles {
    
  function Test-IsAdmin {
    ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
  }#close Test-IsAdmin

  if(Test-IsAdmin){
    ## the following will delete all files in the users desktop directory
    $DownloadFolders = @("$($env:SystemDrive)\Users\*\Desktop\*")
    Remove-Item $DownloadFolders -Recurse -Force 
  } 
}#close Delete-UserDownloadFolderFiles
