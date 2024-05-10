#if GetKeyState("F13", "P")

  +Space::
    Send, {Space}
    Send, {Left}
  Return

  SC033::
  1::
    Send, {WheelDown}
  Return

  SC034::
  2::
    Send, {WheelUp}
  Return

  ^1::
    Send, ^{WheelDown}
  Return

  ^2::
    Send, ^{WheelUp}
  Return

  !SC033::
  !1::
    Send, {WheelLeft}
  Return

  !SC034::
  !2::
    Send, {WheelRight}
  Return

  ;Autoclicker
  LButton::
    while (GetKeyState("LButton", "P"))
    {
      Send, {LButton}
      Sleep, 100
    }
  Return

  ;Autoclicker faster
  !LButton::
    while (GetKeyState("LButton", "P"))
    {
      Send, {LButton}
      Sleep, 10
    }
  Return

  ;Autoescape
  Esc::
    while (GetKeyState("Esc", "P"))
    {
      Send, {Esc}
      Sleep, 50
    }
  Return

  w::																	;Up
    k::				Send, {Up}
  ^w::																;Ctrl + Up
    ^k::			Send, ^{Up}
  +w::																;Shift + Up
    +k::			Send, +{Up}
  !w::																;Alt + 	Up
    !k::			Send, !{Up}
  ^+w::																;Control + Shift + Up
    ^+k::			Send, ^+{Up}
  !+w::																;Alt + Shift + Up
    !+k::			Send, !+{Up}
  ^!w::																;Control + Alt + Up
    ^!k::			Send, ^!{Up}
  #w::																;Windows + Up
    #k::			Send, #{Up}
  #!w::																;Windows + Control + Up
    #!k::			Send, #!^{Up}

  s::																	;Down
    j::				Send, {Down}
  ^s::																;Ctrl + Down
    ^j::			Send, ^{Down}
  +s::																;Shift + Down
    +j::			Send, +{Down}
  !s::																;Alt + 	Down
    !j::			Send, !{Down}
  ^+s::																;Control + Shift + Down
    ^+j::			Send, ^+{Down}
  !+s::																;Alt + Shift + Down
    !+j::			Send, !+{Down}
  ^!s::																;Control + Alt + Down
    ^!j::			Send, ^!{Down}
  #s::
    #j::Send, #{Down}																;Windows + Down

  #!s::																;Windows + Control + Down
    #!j::			Send, #!^{Down}

  a::																	;Left
    h::				Send, {Left}
  i::																	;Ctrl + Left
  ^a::
    ^h::			Send, ^{Left}
  +a::																;Shift + Left
    +h::			Send, +{Left}
  +i:: 																;Control + Shift + Left
  +1::
  ^+a::
    ^+h::			Send, ^+{Left}
  !a::																;Alt + 	Left
    !h::			Send, !{Left}
  !+a::																;Alt + Shift + Left
    !+h::			Send, !+{Left}

  ^!a::																;Control + Alt + Left
    ^!h::			Send, ^!{Left}
  #a::																;Windows + Left
    #h::			Send, #{Left}

  #!a::																;Windows + Control + Left
    #!h::			Send, #!^{Left}

  d::																	;Right
    l::				Send, {Right}
  o::																	;Ctrl + Right
  ^d::
    ^l::			Send, ^{Right}
  +d::																;Shift + Right
    +l::			Send, +{Right}
  +o::																;Control + Shift + Right
  +2::
  ^+d::
    ^+l::			Send, ^+{Right}
  !d::																;Alt + 	Right
    !l::			Send, !{Right}
  !+d::
    !+l::			Send, !+{Right}										;Alt + Shift + Right

  ^!d::																;Control + Alt + Right
    ^!l::			Send, ^!{Right}
  #d::																;Windows + Right
    #l::			Send, #{Right}
  #!d::																;Windows + Control + Right
    #!l::			Send, #!^{Right}

  !i::
    Loop, 6{
      Send, ^{Left}
    }
  Return

  +!i::
    Loop, 6{
      Send, +^{Left}
    }
  Return

  !o::
    Loop, 6 {
      Send, ^{Right}
    }
  Return

  +!o::
    Loop, 6 {
      Send, +^{Right}
    }
  Return

  ^o::
    Send, ^{Right}{Left}
  Return

  q::																	;Home
    u::				Send, {Home}
  ^q::																;Ctrl + Home
    ^u::			Send, ^{Home}
  +q::																;Shift + Home
    +u::			Send, +{Home}
  ^+q::																;Control + Shift + Home
    ^+u::			Send, ^+{Home}
  !q::																;Alt + 	Home
    !u::			Send, !{Home}
  !+q::																;Alt + Shift + Home
    !+u::			Send, !+{Home}
  ^!q::																;Control + Alt + Home
    ^!u::			Send, ^!{Home}

  e::																	;End
    p::				Send, {End}
  ^e::																;Ctrl + End
    ^p::			Send, ^{End}
  +e::																;Shift + End
    +p::			Send, +{End}
  ^+e::																;Control + Shift + End
    ^+p::			Send, ^+{End}
  !e::																;Alt + 	End
    !p::			Send, !{End}
  !+e::																;Alt + Shift + End
    !+p::			Send, !+{End}
  ^!e::																;Control + Alt + End
    ^!p::			Send, ^!{End}

    x::				Send, {PgUp}											;PgUp
    !x::			Send, !{PgUp}										;Alt + PgUp
    +x::			Send, +{PgUp}										;Shift + PgUp
    ^+x::			Send, ^+{PgUp}										;Control + Shift + PgUp
    !+x::			Send, !+{PgUp}										;Alt + Shift + PgUp
    ^!x::			Send, ^!{PgUp}										;Control + Alt + PgUp
    #x::			Send, #{PgUp}										;Windows + PgUp
    z::				Send, {PgDn}											;PgDn
    !z::			Send, !{PgDn}										;Ctrl + Alt + PgDn
    +z::			Send, +{PgDn}										;Shift + PgDn
    ^+z::			Send, ^+{PgDn}										;Control + Shift + PgDn
    !+z::			Send, !+{PgDn}										;Alt + Shift + PgDn
    ^!z::			Send, ^!{PgDn}										;Control + Alt + PgDn
    #z::			Send, #{PgDn}										;Windows + PgDn

    ^Enter:: Send, {End}+{Enter} ;Insert line below
    ^+Enter:: Send, {Home}+{Enter}{Up} ;Insert line above

    m::				Send, {Esc}											;Esc

    ; SC034::			Send, {Home}{Tab}									;Indent (.)
    ; +SC034::		Send, {Tab}											;Tab

    ; SC033::			Send, {Home}+{Tab}									;Unindent (,)
    ; +SC033::		Send, +{Tab}											;Shift + Tab

    c::				Send, {Home}+{End}									;Select line
    ^c:: Send, {Home}+{End}^c ;Copy line
    ^!c:: Send, ^c^v^v ;Duplicate selection
    +!c:: Send, ^c^v,^v ;Duplicate selection with comma
    +c::			Send,, ^{Left}^+{Right}								;Select word

  !c::
    Send, ^{Left}
    Send, ^+{Right}
    Sleep, 50
    Send, ^c
  Return							;Copy word

  ^x:: Send, {Home}+{End}^x

  v::				Send, {AppsKey}										;Apps key
  ^v:: Send, {Home}+{End}^{v} ;Paste line
  !v::
    Send, ^{Left}
    Send, ^+{Right}
    Sleep, 50
    Send, ^v
  Return													;Paste word

  ^z::	 ;Ctrl + PgDn
    Loop, 3{
      Send, ^z
    }
  Return

  SC028::															;Comment
    Loop, 3 {
      Send, {U+0060}
    }
  Return

  Space::			Send, {NumpadEnter}									;Enter

  Delete::		Send, +{End}{Delete}									;Control + Backspace
  Backspace:: 	Send, +{Home}{Delete}								;Delete
  !Backspace::	Send, {End}+{Home}{Delete}							;Delete line
  ; Delete::		Send, {Backspace}									;Backspace
  ; Backspace::		Send, ^{Backspace}							;Delete line

  !+#k::			Run, ms-settings:keyboard							;Keyboard on settings

  0::				Send, #{Home}										;0-Aero Shake

  ; 1::				Run, https://todoist.com/app/project/2269743316		;1-Whatsapp
  ; 2:: Run, https://keep.google.com/u/0/ ;2-Google Keep
  3::				Run, https://calendar.google.com/calendar/u/0/r/week	;3-Google Calendar

  4::				Run, https://mail.google.com/mail/u/0/#inbox			;4-Google Gmail
  5::				Run, https://www.google.com.br/maps					;5-Google Maps
  6::				Run, https://contacts.google.com						;6-Google Contacts
  7::				Run, https://drive.google.com/drive/my-drive			;7-Google Drive
  8::				Run, https://photos.google.com/						;8—Google Photos

  F5::				Run, https://www.deepl.com/translator#pt/en/Receba ;8-DeepL
  F6::				Run, https://www.linguee.com/						;9-Linguee

  ; SC02B::			Run, https://www.phosphoricons.com/					;F2—hosphor Icons

  F9::			Run, "C:\Program Files\Logitech\LogiOptions\LogiOptions.exe" ;F9-Logitech Option

  F10::			Run, shell:startup									;F10-Start-up apps folder

  F11::			Run, ms-settings:nightlight							;F11-Night light

  !F11:: 																;Toggle Night light
    Run, ms-settings:nightlight
    WinWaitActive, Settings
    Sleep 400
    Loop, 2
    {
      Send, +{Tab}
      Sleep 10
    }
    Send, {Enter}
    Sleep 10
    WinClose
  Return

  AppsKey::		Run, ms-settings:bluetooth 							;Bluetooth on settings

  !AppsKey::															;Toggle Bluetooth
    Run, ms-settings:bluetooth
    WinWaitActive, Settings
    Sleep 100
    Send, {Tab}
    Send, {Space}
    WinClose, Settings
  Return

  +!AppsKey::															;Toggle Sennheiser
    Run, ms-settings:bluetooth
    WinWaitActive, Settings
    Sleep 2000
    Loop, 7
    {
      Send, {Tab}
    }
    Sleep 100
    Send, {Down}
    Send, {Tab}
    Send, {Space}
    Sleep 500
    Send, {Enter}
    WinClose, Settings
  Return

  !SC00D::
    DetectHiddenWindows, On
    WinActivate, ahk_exe spotify.exe
    WinWait, ahk_exe spotify.exe
    Sleep 500
    Send, ^l
    Sleep 300
    Send, {Tab}
    Sleep 300
    Send, !{Left}
    Sleep 700
    Loop, 13 {
      Send, +{Tab}
      Sleep 5
    }
  Return

  F12::			Run, ms-settings:bluetooth 							;Bluetooth on settings

  !F12:: 															;Open Sounds
    If WinExist("Settings")
    {
      WinActivate, Settings ;Or the corresponding on your language
      WinWaitActive, Settings ;Or the corresponding on your language
      Run, ms-settings:sound-devices
      Sleep, 500
      Send, {Space}
      Sleep, 500
      Loop, 9 {
        Sleep, 1
        Send, +{Tab}
      }
    } else{
      Run, ms-settings:sound-devices
      WinWaitActive, Settings ;Or the corresponding on your language
      WinActivate, Settings ;Or the corresponding on your language
      Sleep, 1000
      Send, {Space}
      Sleep, 500
      Loop, 9 {
        Sleep, 1
        Send, +{Tab}
      }
    }
  Return

#if
