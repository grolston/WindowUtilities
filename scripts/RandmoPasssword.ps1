function Get-RandomCharacters($length, $characters) { 
    $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length } 
    $private:ofs="" 
    return [String]$characters[$random]
}

Get-RandomCharacters -Length 12 -characters 'abcdefghiklmnoprstuvwxyz1234567890ABCDEFGHKLMNPRSTUVWXYZ!$&()=@' | Clip