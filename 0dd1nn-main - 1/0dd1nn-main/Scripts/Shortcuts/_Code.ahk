#if  GetKeyState("F13", "P")
  G:: Send, ->
  B:: Send, =>
  9:: Send, () =>
  SC02B:: Send, () =>
  SC00C:: Send, ->

#if WinActive("ahk_exe Code - Insiders.exe") && GetKeyState("F13", "P") 		;VS Code

  1::				Send, ^{F5}
  2::				Send, +^{F5}
  3::				Send, {F5}
  4::				Send, +{F5}
  f:: Send, !+{f}
  RButton::		Send, !{d}
  +SC02B::		Send, ^+{SC02B}

  SelectFunctionBlock() {
    Send, !+{SC01A}
    Sleep, 50
    Send, ^{l}
  }
  SC01A:: SelectFunctionBlock()
  ^SC01A::
    SelectFunctionBlock()
    Send, ^c
  Return
  !SC01A::
    SelectFunctionBlock()
    Send, ^x
  Return
  +SC01A::
    SelectFunctionBlock()
    Send, ^v
  Return
  !+SC01A::
    SelectFunctionBlock()
    Send, {Delete}
  Return
  r:: SelectFunctionBlock()
  !r::
    SelectFunctionBlock()
    Send, ^v
  Return
  ^r::
    SelectFunctionBlock()
    Send, ^c
  Return
  +r::
    SelectFunctionBlock()
    Send, ^x
  Return
  !+r::
    SelectFunctionBlock()
    Send, {Delete}
  Return

  !j::
    Loop, 5 {
      Send, !{j}
      Sleep 1
    }
  Return

  !k::
    Loop, 5{
      Send, !{k}
      Sleep 1
    }
  Return

  ^l::
    Loop, 10{
      Send, ^{l}
      Sleep 1
    }
  Return

  t::
    Loop, 3{
      Send, ^{c}
      Sleep, 100
    }
    Send, ^{l}
    Send, {Up}
    Sleep, 100
    Send, {Enter}
  Return

  SetTitleMatchMode, 2
#if WinActive("ahk_exe Code - Insiders.exe") && WinActive(".dart")
  !+x:: ; Remove widget
    MouseGetPos, xpos, ypos
    MouseMove, 0, 0
    Send, ^{SC034} ;.
    Sleep, 80
    Send, {Up}
    Sleep, 80
    Send, {Enter}
    Sleep, 80
    Send, {CtrlUp}{AltUp}{ShiftUp}
    MouseMove, xpos, ypos
  Return

  SendLetters(letters) {
    Loop, % StrLen(letters) {
      Send, % SubStr(letters, A_Index, 1)
      Sleep, 100
    }
  }

  WrapWith(letters) {
    Send, ^{SC02B} ;/
    Sleep, 100
    ; Send, ^{Left}^{Right}
    ; Sleep, 100
    Send, {Right}
    Sleep, 100
    ; Send, !+{SC01A}
    ; Sleep, 100
    ; Loop, 2 {
    ;   Send, !+{L}
    ;   Sleep, 100
    ; }
    Send, ^!+{L}
    SendLetters(letters)
    Sleep, 500
    Send, {Tab}
    Send, {AltDown}{AltUp}
    Send, {ShiftDown}{ShiftUp}
    Send, {CtrlDown}{CtrlUp}
    Send, {Esc}
    Return
  }
  !+Space::WrapWith("wid")
  !+1::WrapWith("con")
  !+2::WrapWith("pad")
  !+3::WrapWith("cen")
  !+4::WrapWith("mar")
  !^1::WrapWith("col")
  !^2::WrapWith("row")

#if WinActive("ahk_exe Code - Insiders.exe")
  !+Space:: Send, {F15}
  !Space:: Send, {F16}
  !F9::
    Send, ^j
    Sleep, 200
    Send, !+{SC01A}!+{SC01A}
    Sleep, 200
    Send, !{F9}
    Sleep, 200
    Send, ^x
    Sleep, 200
    Clip0 = %ClipboardAll%
    Clipboard = %Clipboard% ; Convert to text
    Clipboard := RegExReplace(Clipboard, " *\v+ *", " ")
    Send ^v ; For best compatibility: SendPlay
    Sleep 50 ; Don't change Clipboard while it is pasted! (Sleep > 0)
    Clipboard = %Clip0% ; Restore original Clipboard
    VarSetCapacity(Clip0, 0) ; Free memory
    Sleep, 200
    Send, !+{f}
  Return

  !F4:: ; Close code
  #x::
    Send, ^+!{t}
    Sleep, 1000
    Send, !{f4}
  Return

  ^!+F12:: ;Reload code
    Send, ^+!{t}
    Sleep, 1000
    Send, ^!+{f10}
  Return

  ^!+F11:: ;Reload end tags
    Send, ^{k}{m}
    Send, Html
    Send, {Enter}
    Send, ^{k}{m}
    Send, Vue
    Send, {Enter}
  Return
#if
