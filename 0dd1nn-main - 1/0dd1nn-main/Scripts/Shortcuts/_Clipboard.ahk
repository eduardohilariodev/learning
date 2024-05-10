#if
#v::
  Clip0 = %ClipboardAll%
  Clipboard = %Clipboard% ; Convert to text
  Clipboard := RegExReplace(Clipboard, " *\v+ *", " ")
  Send, ^v ; For best compatibility: SendPlay
  Sleep, 50 ; Don't change Clipboard while it is pasted! (Sleep > 0)
  Clipboard = %Clip0% ; Restore original Clipboard
  VarSetCapacity(Clip0, 0) ; Free memory
Return

+#v:: 									; Text–only paste from Clipboard
  Clip0 = %ClipboardAll%
  Clipboard = %Clipboard% 						; Convert to text
  Send, ^v 						; For best compatibility: SendPlay
  Sleep, 50 						; Don't change Clipboard while it is pasted! (Sleep > 0)
  Clipboard = %Clip0% 						; Restore original Clipboard
  VarSetCapacity(Clip0, 0) 						; Free memory
Return

!#v::
  Loop, 10 {
    Send, ^a
  }

  Send, ^{v}
  Send, {Enter}
Return

+#^v:: 									; Text–only paste from Clipboard
  str := Clipboard
  ClipWait
  send % Slugify(str)
Return

Slugify(str) {
  str := Trim(Format("{:L}", str))
  str := RegexReplace(str, "\s+", "-")
  str := RegexReplace(str, "[^\w-]+", "")
  str := RegexReplace(str, "--+", "-")
  str := RegexReplace(str, "-+$", "")
  str := RegexReplace(str, "^-+", "")
  Return str
}
#if
