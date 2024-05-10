if not A_IsAdmin													;Running as Admin
{
  Run, *RunAs "%A_ScriptFullPath%"
  ExitApp
}

;Open AutoHotKey
#F12::
  Run, "C:\Users\Eduardo\GitHub\0dd1nn\Scripts\Shortcuts\Shortcuts.code-workspace"
Return

#ifWinActive Shortcuts (Workspace) 									 		;Save and reload AHK
  ^s::
    Send, ^{s}
    Suspend, On
    Suspend, Off
    Sleep, 500
    Suspend, On
    Suspend, Off
    Sleep, 500
    Suspend, On
    Suspend, Off
    Sleep, 500
    Reload
    Sleep, 500
    Reload
    Sleep, 500
    Reload
  Return

#if
