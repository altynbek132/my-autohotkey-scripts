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

    query := Trim(Clipboard)
    if SubStr(query, 1, 4)="http" OR SubStr(query, 1, 3)="www" {
        Run, %query%
        return
    }
    escapedQuery := UrlEscape( RegExReplace(RegExReplace(query, "\r?\n", " "), "(^\s+|\s+$)"), 0x00080000 | 0x00002000 | 0x00001000)
    toSearch := "%s"
    asdf := StrReplace(url, toSearch, escapedQuery)
    Run, %asdf%
    Clipboard := prevClipboard
}

#+w::
    OpenURL("https://translate.yandex.com/?&text=%s")
return

#q::
    OpenUrl("https://www.google.com/search?q=%s")
return

custom := ""

#^q:: ; Search in Google with additional custom query
    copy := custom
    copy := UrlEscape( RegExReplace(RegExReplace(copy, "\r?\n", " "), "(^\s+|\s+$)", " "), 0x00080000 | 0x00002000 | 0x00001000)
    OpenUrl("https://www.google.com/search?q=%s%20" . copy)
return

#+^q:: ; Search in Google with additional new custom query
    InputBox, custom, "Enter additional query for future searches"
    copy := custom
    copy := UrlEscape( RegExReplace(RegExReplace(copy, "\r?\n", " "), "(^\s+|\s+$)", " "), 0x00080000 | 0x00002000 | 0x00001000)
    OpenUrl("https://www.google.com/search?q=%s%20" . copy)
return