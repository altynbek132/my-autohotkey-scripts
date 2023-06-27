; #	Win (Windows logo key)
; !	Alt
; ^	Ctrl
; +	Shift
; &	An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.

#NoEnv
#NoTrayIcon
#SingleInstance, Force
#MaxHotkeysPerInterval 120

SendMode Input
SetWorkingDir, %A_ScriptDir%

^#!Left::SoundSet, -5
^#!Right::SoundSet, +5
