#if

KillProcess()
{
  WinGet, PID, PID, % "ahk_id " WinExist("A")
  Process, Close, %PID%
}

#ifWinExist ahk_group AltTabWindow									;Task View with WASD and VIM
  GroupAdd AltTabWindow, ahk_class XamlExplorerHostIslandWindow

  w::				Up
  k::				Up

  s::				Down
  j::				Down

  a::				Left
  h::				Left

  d::				Right
  l::				Right

  Backspace::		Delete											;Close window
  !^LButton::    MouseClick, Middle									;Click window

#ifWinExist ahk_group SnapWindow
  GroupAdd SnapWindow, ahk_class Xaml_WindowedPopupClass

  w::				Up
  k::				Up

  s::				Down
  j::				Down

  a::				Left
  h::				Left

  d::				Right
  l::				Right

#ifWinExist ahk_group VirtualDesktop
  GroupAdd VirtualDesktop, ahk_class XamlExplorerHostIslandWindow

  w::				Up
  k::				Up

  s::				Down
  j::				Down

  a::				Left
  h::				Left

  d::				Right
  l::				Right

#if

#!Space::		Winset, Alwaysontop, , A						;Sets a window to Always On Top

#^d::
#^l::
  Send, #^{Right}
Return

#^a::
#^h::
  Send, #^{Left}
Return

#!+a::															;Send, window to the left monitor
  #!+h::			Send, #+{Left}
#!+d::															;Send, window to the right monitor
  #!+l::			Send, #+{Right}

#w::															;Maximize window
#^k::
  #!Up::			WinMaximize, A
  #s:: WinRestore, A
#!s::															;Minimize window
#^j::
  #!Down::		WinMinimize, A
  #x::			WinClose, A										;Kill window
#^x:: 															;Kill process of window
  KillProcess()
Return

#if GetKeyState("F13", "P")
  ^LButton::
    MouseClick, L
    WinClose, A
  Return
  ^!LButton::
    MouseClick, L
    KillProcess()
  Return

#if GetKeyState("LWin","P") && GetKeyState("LAlt","P")
  h::#left
  a::#left
  l::#right
  d::#right
  j::#down
  k::#up

#if GetKeyState("LWin","P") && GetKeyState("LShift","P")
  w::#+up
  k::#+up

#if
ActivateIDE() {
  MinimizeAllWindows()
  WinWait, %TitleIDE%
  WinActivate, %TitleIDE%
  WinMaximize, %TitleIDE%
  MinimizeOtherWindows()
}
SetTitleMatchMode, 2
F13 & SC045:: ;Boss key
  DetectHiddenWindows, On
  If(WinExist(TitleIDE)) {
    ActivateIDE()
  } Else {
    Run, %PathIDE%
    ActivateIDE()
  }
Return
#if
