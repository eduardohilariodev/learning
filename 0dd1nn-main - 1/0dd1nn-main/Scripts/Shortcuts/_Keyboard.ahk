#if
~$RShift::														;CapsLock on RShift
  KeyWait, RShift
  If (A_ThisHotkey = A_PriorHotkey) && (A_TimeSincePriorHotkey < 400)
    SetCapsLockState, % ((GetKeyState("CapsLock", "T") = 1) ? "Off" : "AlwaysOn")
Return
#if
