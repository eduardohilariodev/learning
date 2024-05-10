#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn LocalSameAsGlobal ; Enable warnings to assist with detecting common errors.
#Persistent
#HotkeyInterval,100
#SingleInstance Force
SendMode InputThenPlay ; Recommended for new scripts due to its superior speed and reliability.
SetKeyDelay, -1
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ; Makes matching the titles easier

#Include, %A_ScriptDir%\_Common.ahk

#Include, %A_ScriptDir%\_WindowManagement.ahk
#Include, %A_ScriptDir%\_MetaAutoHotkey.ahk

#Include, %A_ScriptDir%\_Apps.ahk
#Include, %A_ScriptDir%\_Code.ahk
#Include, %A_ScriptDir%\_Clipboard.ahk
#Include, %A_ScriptDir%\_Explorer.ahk
#Include, %A_ScriptDir%\_Hotstrings.ahk
#Include, %A_ScriptDir%\_Keyboard.ahk
#Include, %A_ScriptDir%\_Media.ahk
#Include, %A_ScriptDir%\_Mouse.ahk
#Include, %A_ScriptDir%\_Search.ahk
#Include, %A_ScriptDir%\_Tools.ahk
#Include, %A_ScriptDir%\_WindowsOS.ahk

#Include, %A_ScriptDir%\_PowerKey.ahk
