#if
*SC056:: Send, {SC056}
*^SC056:: Send, ^{SC056}
*^+SC056:: Send, ^+{SC056}
*^+!SC056:: Send, ^+!{SC056}

#SC056:: Send, #{~}
~#SC056 up:: Return

SC056 & k::		MouseMove, 0, -20, 100, R
SC056 & w::		MouseMove, 0, -20, 100, R

SC056 & j::		MouseMove, 0, 20, 20, R
SC056 & s::		MouseMove, 0, 20, 20, R

SC056 & h::		MouseMove, -20, 0, 100, R
SC056 & a::		MouseMove, -20, 0, 100, R

SC056 & l::		MouseMove, 20, 0, 20, R
SC056 & d::		MouseMove, 20, 0, 20, R

SC056 & SC034::		Send, {WheelUp}
SC056 & SC033::		Send, {WheelDown}

SC056 & Space:: Click, Left
SC056 & v::		Click, Right

#if GetKeyState("LAlt", "P")

  SC056 & k::		MouseMove, 0, -100, 100, R
  SC056 & w::		MouseMove, 0, -100, 100, R
  SC056 & j::		MouseMove, 0, 100, 10, R
  SC056 & s::		MouseMove, 0, 100, 10, R
  SC056 & h::		MouseMove, -100, 0, 0, R
  SC056 & a::		MouseMove, -100, 0, 0, R
  SC056 & l::		MouseMove, 100, 0, 0, R
  SC056 & d::		MouseMove, 100, 0, 0, R

#if GetKeyState("LControl", "P")

  SC056 & k::		Send, {WheelUp}
  SC056 & w::		Send, {WheelUp}
  SC056 & j::		Send, {WheelDown}
  SC056 & s::		Send, {WheelDown}
  SC056 & h::		Send, {WheelLeft}
  SC056 & a::		Send, {WheelLeft}
  SC056 & l::		Send, {WheelRight}
  SC056 & d::		Send, {WheelRight}
  Space:: Send, ^{Click, Left}
#if
