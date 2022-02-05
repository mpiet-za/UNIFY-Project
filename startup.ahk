#NoEnv
#NoTrayIcon
#SingleInstance, Force

SetWorkingDir %A_ScriptDir%

#Include %A_ScriptDir%\Functions\func-Tasker.ahk

IniFile := A_ScriptDir . "\config.ini"

if !(FileExist(IniFile)) {
    MsgBox, 262160, Configuration Error, The configuration file could not be found. `n "%A_ScriptDir%\config.ini"
    ExitApp
} else {
    IniRead, I_Active, %A_ScriptDir%\config.ini, Settings, DelayStartup    ; Interprets values to variable.
    IniRead, I_Delay, %A_ScriptDir%\config.ini, Settings, DelayAmmount     ; Interprets values to variable.
    I_Delay := I_Delay > 1200000 ? 1200000 : I_Delay        ; Ternary operation to cap the delay.
    if (I_Active = "true")
        Sleep I_Delay
    ExecuteHitlist(x)
    Run %A_ScriptDir%\masterfile.ahk
    ExitApp
}