#if
/* -------------------------------------------------------------------------- */
/*                              Search Clipboard                              */
/* -------------------------------------------------------------------------- */

/*
/* -------------------------------- Functions ------------------------------- */
*/

CopyToClipboard() {
  Send, ^c
  Sleep, 200
}

ActivateEdge() {
  DetectHiddenWindows, On
  If WinExist("- Microsoft Edge")
  {
    WinWait - Microsoft Edge
    WinActivate
  }
  Sleep, 200
}

RunQueryURL(query, base_url) {
  Run, %base_url%%query%
}

PromptInputAndRunURL(title, base_url, method := "") {
  CopyToClipboard()
  processedClipboard := Clipboard
  if (method != "") {
    methodFunc := Func(method)
    processedClipboard := methodFunc.Call(Clipboard)
  }
  InputBox, userInput, %title%,,, 360, 100 ,,, 5,, %processedClipboard%
  WinActivate, %title%
  WinSet, AlwaysOnTop, On , %title%
  if !ErrorLevel {
    RunQueryURL(userInput, base_url)
  }
}

CopyAndRunURL(base_url) {
  CopyToClipboard()
  ActivateEdge()
  RunQueryURL(Clipboard, base_url)
}

OnlyDigits(string) {
  newString := RegExReplace(string, "\D")
  Return newString
}

SelectLine() {
  Send, {Home}+{End}
}

/*
/* -------------------------------- Shortcuts ------------------------------- */
*/

#c::       CopyAndRunURL("https://www.google.com/search?q=")
#!c::      CopyAndRunURL("http://google.com/search?btnI=&q=")
#+c::      CopyAndRunURL("https://www.google.com/search?tbm=isch&q=")
#^c::      CopyAndRunURL("")
#j::       PromptInputAndRunURL("Search on Google",                       "https://www.google.com/search?q=")
#+k::      PromptInputAndRunURL("Search on Google Images",                "https://www.google.com/search?tbm=isch&q=")
#k::       PromptInputAndRunURL("I'm Feeling Lucky",                      "http://google.com/search?btnI=I'm+Feeling+Lucky&q=")
#!g::      PromptInputAndRunURL("Look up on Instagram",                   "https://www.instagram.com/")
#!y::      PromptInputAndRunURL("Search on YouTube",                      "https://www.youtube.com/results?search_query=")
#F5::      PromptInputAndRunURL("Search on Oxford Learner's Dictionary",  "https://www.oxfordlearnersdictionaries.com/search/english/?q=")
#!F5::     PromptInputAndRunURL("Search on Thesaurus",                    "https://www.thesaurus.com/browse/")
#F6::      PromptInputAndRunURL("Search on Linguee",                      "https://www.linguee.com/english-portuguese/search?source=auto&query=")
#!F6::     PromptInputAndRunURL("Translate on Google Translate",          "https://translate.google.com/?sl=auto&tl=pt&text=&op=translate")
#F7::      PromptInputAndRunURL("Definicao em brasileiro no Dicio",       "https://www.dicio.com.br/pesquisa.php?q=")
#!F7::     PromptInputAndRunURL("Sinonimo de",                            "https://www.sinonimos.com.br/")
#F8::      PromptInputAndRunURL("Search on DeepL",                        "https://www.deepl.com/translator#en/pt/")
#!F8::     PromptInputAndRunURL("Search on WhatsApp",                      "https://wa.me/",                                                       "OnlyDigits")
#9::       PromptInputAndRunURL("Search on MDN Web Docs",                 "https://developer.mozilla.org/en-US/search?q=")

#if GetKeyState("F13", "P")
  #c::
    SelectLine()
    CopyAndRunURL("https://www.google.com/search?q=")
  Return

  #SC034:: PromptInputAndRunURL("Search emoji on Emojipedia",             "https://www.emojipedia.org/search/?q=")

#if
