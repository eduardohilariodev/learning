#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

MinimizeOtherWindows() {
  Send, #{Home}
}

MinimizeAllWindows() {
  Send, #{d}
}

global TitleIDE := "Visual Studio Code - Insiders"
global PathIDE := "C:\Users\Eduardo\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Visual Studio Code - Insiders\Visual Studio Code - Insiders.lnk"
