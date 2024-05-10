#if

#q::															;Open Everything
  Run, "C:\Program Files\Everything\Everything.exe"
Return

#f::															;Open Notepad
  If WinExist("Untitled - Notepad")
  {
    WinActivate
  }
  Else
  {
    Run, notepad.exe
  }
Return

#!t:: ;Windows Terminal
  DetectHiddenWindows, On

  If (A_IsAdmin) ;- I'm 'admin' so it works
  {
    ; Run,%comspec% /k
    Run, wt.exe

  }
  else
    msgbox,ADMIN=%A_IsAdmin%
Return

#if WinActive("ahk_exe githubdesktop.exe")
  !1::Send, ^+{p}
  !2::Send, ^{p}

#if WinActive("ahk_exe figma.exe") && GetKeyState("F13", "P")		;Figma
  1::				Send, ^!k										;Create component
  2::				Send, ^!b 											;Detach instance
  3::				Send, ^!g 											;Frame selection
  4::				Send, ^!l 											;Text align left
  5::				Send, ^!t 											;Text align center
  6::				Send, ^!r											;Text align right
  f::				Send, ^!+r 											;Resize to fit
  v::				Send, ^!+v 											;Distribute vertically
  g::				Send, ^!+h 											;Distribute horizontally
  r::				Send, !l											;Collapse all layers
  t::				Send, ^+h											;Show/hide layer

#if WinActive("ahk_exe figma.exe")
  F1::			Send, !8 										;Design panel
  F2::			Send, !9 											;Prototype panel
  F3::			Send, !0 											;Inspect panel
  !f::			Send, +i											;Search components
  !3::			Send, ^!p											;Run, last active plugin
  !x::			Send, ^+l											;Lock layer
  !c::			Send, ^+h											;Show/Hide layer

#if WinActive("- Microsoft Edge") && GetKeyState("F13", "P")		;Open bookmark bar

  b::				Send, ^+{b}

#if WinActive("YouTube")											;Download YouTube video
  F13 & f::
    Send, !{d}
    Send, ^c
    Sleep 50
    Run, https://yt1s.com/en?q="%Clipboard%"
    Sleep 1000
    WinExist("YouTube Downloader")
    WinActivate
  Return

#if WinActive("WhatsApp")

  !#v::
    Loop, 10 {
      Send, ^a
    }

    Clip0 = %ClipboardAll%
    Clipboard = %Clipboard%
    Clipboard := RegExReplace(Clipboard, " *\v+ *", " ")
    Send, ^v
    Sleep, 50
    Clipboard = %Clip0%
    VarSetCapacity(Clip0, 0)

    Sleep, 2000

    Send, {Enter}
  Return

  ^0:: Send, ^{1}
  ^1:: Send, ^{2}
  ^2:: Send, ^{3}
  ^3:: Send, ^{4}
  ^4:: Send, ^{5}
  ^5:: Send, ^{6}
  ^6:: Send, ^{7}
  ^7:: Send, ^{8}
  ^8:: Send, ^{9}

  ;Hotkeys
  F13 & r:: ;Focus on messages
    Loop, 3{
      Send, +{Tab}
    }
  Return

  F13 & f:: ;Reply
    Send, {AppsKey}
    Sleep, 100
    Send, {Down}{Down}
    Send, {Space}
  Return

  F13 & t:: ;Like
    Send, {AppsKey}
    Sleep, 100
    Send, {Space}
  Return

#if
