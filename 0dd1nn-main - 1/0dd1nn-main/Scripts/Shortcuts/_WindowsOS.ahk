#if
^+#Esc::
  Run rundll32.exe user32.dll\`,LockWorkStation ; Lock PC
  Sleep 1000
  SendMessage 0x112, 0xF170, 2, , Program Manager ; Monitor off
Return
#if
