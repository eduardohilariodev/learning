#if

#o:: ;Kg to pounds
  Clipboard := ""
  Send, ^c
  Sleep, 50
  Clipboard := RegExReplace(Clipboard, "[\r\n\t]", "")
  WeightConversionFactor := RegExReplace(Clipboard, "[^\d.]+", "")
  if (WeightConversionFactor = "" || RegExMatch(WeightConversionFactor, "[A-Za-z]")) {
    InputBox, weight, Enter weight in pounds, Please enter weight in pounds,,, 100
    weightInKilos := weight * 0.45359237
    if ErrorLevel || weightInKilos = 0 || weightInKilos = ""
      Return
  } else {
    weightInKilos := WeightConversionFactor * 0.45359237
  }
  if (weightInKilos > 0 and weightInKilos < 1) {
    weightFormatted := Format("{:.0f}", weightInKilos * 1000) "g"
  } else {
    weightFormatted := Format("{:.2f}", weightInKilos) "kg"
  }
  MsgBox, % weightFormatted
Return

#if
