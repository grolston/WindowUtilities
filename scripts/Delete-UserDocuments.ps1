function Delete-UserDocumentFiles {
  function Test-IsAdmin {
    ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
  }#close Test-IsAdmin
  if(Test-IsAdmin){
    ## the following will delete all files in the users document directory
    $DownloadFolders = @("$($env:SystemDrive)\Users\*\Document\*")
    Remove-Item $DownloadFolders -Recurse -Force 
  } 
}#close Delete-UserDownloadFolderFiles
