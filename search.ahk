; #	Win (Windows logo key)
; !	Alt
; ^	Ctrl
; +	Shift
; &	An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.

#NoEnv
#NoTrayIcon
#SingleInstance

UrlEscape( url, flags )
{
    VarSetCapacity( newUrl, 4096, 0 ), pcche := 4096
    DllCall( "shlwapi\UrlEscapeW", Str, url, Str, newUrl, UIntP, pcche, UInt, flags )
    Return newUrl
}

UrlUnEscape( url, flags )
{
    VarSetCapacity( newUrl, 4096, 0 ), pcche := 4096
    DllCall( "shlwapi\UrlUnescapeW", Str, url, Str, newUrl, UIntP, pcche, UInt, flags )
    Return newUrl
}

OpenURL(url)
{
    prevClipboard := ClipboardAll
    Clipboard =
    Send, ^c
    ClipWait
    
    aStr := UrlEscape( RegExReplace(RegExReplace(Clipboard, "\r?\n", " "), "(^\s+|\s+$)"), 0x00080000 | 0x00002000 | 0x00001000)
    Clipboard := prevClipboard
    if SubStr(aStr, 1, 8)="https://"
    Run, %aStr%
    else
        Run, %url%%aStr%
}

#IfWinNotActive ahk_exe chrome.exe
!w::  ; YaTranslate with Win+Ctrl+s
OpenURL("https://translate.google.com/?sl=en&tl=ru&text=")
return

!q::  ; Search in Google with Win+Ctrl+g
OpenUrl("https://www.google.com/search?q=")
return
#IfWinNotActive
