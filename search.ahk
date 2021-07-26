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

; URL with %s in place of query
OpenURL(url)
{
    prevClipboard := ClipboardAll
    Clipboard =
    Send, ^c
    ClipWait

    aStr := UrlEscape( RegExReplace(RegExReplace(Clipboard, "\r?\n", " "), "(^\s+|\s+$)"), 0x00080000 | 0x00002000 | 0x00001000)
    Clipboard := prevClipboard
    if SubStr(aStr, 1, 8)="https://" OR SubStr(aStr, 1, 4)="www."
        Run, %aStr%
    else{
        toSearch := "%s"
        asdf := StrReplace(url, toSearch, aStr)
        Run, %asdf%
    }
}

!w::
    OpenURL("https://translate.google.com/?sl=en&tl=ru&text=%s")
return

#IfWinNotActive ahk_exe chrome.exe
!q::
    OpenUrl("https://www.google.com/search?q=%s")
return
#IfWinNotActive

custom := ""

#IfWinNotActive ahk_exe chrome.exe
!^q:: ; Search in Google with additional custom query
    custom := UrlEscape( RegExReplace(RegExReplace(custom, "\r?\n", " "), "(^\s+|\s+$)", " "), 0x00080000 | 0x00002000 | 0x00001000)
    OpenUrl("https://www.google.com/search?q=%s%20" . custom)
return
#IfWinNotActive

#IfWinNotActive ahk_exe chrome.exe
!+^q:: ; Search in Google with additional new custom query
    InputBox, custom, "Enter additional query for future searches"
    custom := UrlEscape( RegExReplace(RegExReplace(custom, "\r?\n", " "), "(^\s+|\s+$)", " "), 0x00080000 | 0x00002000 | 0x00001000)
    OpenUrl("https://www.google.com/search?q=%s%20" . custom)
return
#IfWinNotActive
