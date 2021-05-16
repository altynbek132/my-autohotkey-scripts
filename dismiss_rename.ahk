; #NoTrayIcon
#SingleInstance

#NoTrayIcon

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetWinDelay, 0 ;Remove any delay after the popup is found
SetTitleMatchMode, 3 ;The window title must match EXACTLY

Loop ;Do repeatedly forever
{
    WinWait, Rename ahk_class #32770 ;Wait until the rename popup is found
    ControlSend, , !y ;Send alt+y to say 'Yes'
}
