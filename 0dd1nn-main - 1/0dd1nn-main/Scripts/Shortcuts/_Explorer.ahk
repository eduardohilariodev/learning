#if
^!+Esc::														;Reload Explorer
  WinGet, h, ID, ahk_class Progman
  PostMessage, 0x12, 0, 0, , ahk_id %h%
  Sleep, 200
  Run, explorer.exe
Return

#+d::															;Open Desktop folder
  SetTitleMatchMode, 3
  ; 1 = A window's title must start with the specified WinTitle to be a match.
  ; 2 = A window's title can contain WinTitle anywhere inside it to be a match.
  ; 3 = A window's title must exactly match WinTitle to be a match.
  If WinExist("Desktop")
  {
    WinActivate
  }
  Else
  {
    Run, %A_Desktop%
  }
Return

#if WinActive("ahk_exe explorer.exe")
  !0:: Send, ^!{6}
  !1:: Send, ^!{1}
  !2:: Send, ^!{7}
  !3:: Send, ^!{8 }
  ^r:: Send, {F2}

  !F2::															;Quickly View or Hide Hidden Files
    GoSub,CheckActiveWindow
  CheckActiveWindow:
    ID := WinExist("A")
    WinGetClass,Class, ahk_id %ID%
    WClasses := "CabinetWClass ExploreWClass"
    IfInString, WClasses, %Class%
      GoSub, Toggle_HiddenFiles_Display
  Return

  Toggle_HiddenFiles_Display:
    RootKey = HKEY_CURRENT_USER
    SubKey = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced

    RegRead, HiddenFiles_Status, % RootKey, % SubKey, Hidden

    if HiddenFiles_Status = 2
      RegWrite, REG_DWORD, % RootKey, % SubKey, Hidden, 1
    else
      RegWrite, REG_DWORD, % RootKey, % SubKey, Hidden, 2
    PostMessage, 0x111, 41504,,, ahk_id %ID%
  Return

#if WinActive("ahk_exe explorer.exe") && GetKeyState("F13", "P")	;Open folder location of selected item in Windows Explorer
  Enter::
    ClipSaved := ClipboardAll
    Clipboard =
    Send, ^c
    ClipWait
    If !ErrorLevel
      Loop, parse, Clipboard, `n, `r
      {
        ext=
        SplitPath,A_LoopField,name, dir, ext, name_no_ext, drive
        OutTarget:=A_zLoopField
        If(ext="lnk")
        {
          FileGetShortcut,%A_LoopField%,OutTarget,dir
        }
        Run, explorer.exe /select`,"%OutTarget%"
      }
    Clipboard := ClipSaved
    ClipSaved =x

#if
