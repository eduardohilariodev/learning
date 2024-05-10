#if

SC045::			Send, {Media_Play_Pause}							;Pause
+SC045::		Send, {Media_Prev}								;Previous track
^SC045::		Send, {Media_Next}								;Next track
#m::		Send, {Volume_Mute}								;Mute
!SC045::		Send, {Volume_Mute}								;Mute
F13 & Down::	Send, {Volume_Down}								;Volume Down
F13 & Up::		Send, {Volume_Up}								;Volume Up

#Persistent
originalVolume := 0
toggle := 0

#SC045::
  toggle := !toggle
  if (toggle) {
    SoundGet, originalVolume ; get the current volume
    SoundSet, 10 ; set the volume to 8
  } else {
    SoundSet, %originalVolume% ; set the volume back to the original
  }
Return
#if
