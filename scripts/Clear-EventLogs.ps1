## the following will clear all event logs on a server.
function Clear-EventLogs {

  function Test-IsAdmin {
    ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
  }#close Test-IsAdmin
  if(Test-IsAdmin){
    wevtutil el | % {wevtutil cl "$_"};
  }
  else {
    write-warning "function requires elevated privileges. Restart PS running as admin..."
  }

}# close Clear-EventLogs
