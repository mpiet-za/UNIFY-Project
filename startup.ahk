#NoEnv
#NoTrayIcon
#SingleInstance, Force

SetWorkingDir %A_ScriptDir%

#Include %A_ScriptDir%\Functions\func-Tasker.ahk

IniFile := A_ScriptDir . "\config.ini"

IniRead, I_Active, % IniFile, Settings, DelayStartup    ; Interprets values to variable.
IniRead, I_Delay, % IniFile, Settings, DelayAmmount     ; Interprets values to variable.
I_Delay := I_Delay > 1200000 ? 1200000 : I_Delay        ; Ternary operation to cap the delay.

if !(FileExist(IniFile)) {
    SoundPlay *64
    MsgBox, 262160
        , Configuration Error
        , The configuration file could not be found. `n "%A_ScriptDir%\config.ini"
    ExitApp
} if (A_AhkVersion < "1.1.33.10") {
; This dialog was built using the magicbox script in the development tools folder.
; https://sourceforge.net/projects/magicbox-factory/
    SoundPlay *64
    OnMessage(0x44, "OnMsgBox")
    MsgBox, 0x21
        , Update Notice (%A_AhkVersion%)
        , The current version of autohotkey is outdated - please update to the latest version or some scripts may not work.
    OnMessage(0x44, "")
    IfMsgBox OK, {
        Run https://www.autohotkey.com/
        ExitApp
    } else IfMsgBox Cancel, {
        Initialize()
    }
    OnMsgBox() { 
    ; Configure the dialog button text.
        DetectHiddenWindows, On
        Process, Exist
        If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
            ControlSetText Button1, UPDATE
            ControlSetText Button2, Ignore
        }
    }
} else {
    Initialize()
}

Initialize() {
    if (I_Active = "true") {
        Sleep I_Delay
    }
    Run, %A_ScriptDir%\masterfile.ahk
    IfExist, %A_ScriptDir%\Development\Hitlist.ahk
        ExecuteHitlist(x)
    ExitApp
}