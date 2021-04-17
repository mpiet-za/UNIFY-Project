#NoEnv
#NoTrayIcon
#SingleInstance, Force

SetWorkingDir %A_ScriptDir%

Shortcut(Target) {
    Run %A_ScriptDir%\Assets\Shortcuts\%Target%
    Return
} ; Include the filetype extension.

ExecuteHit(Target) {
    Process, Close, %Target%
    Return
} ; Can also target process PID. (standard syntax 'process_name.exe')

ExecuteHitlist(Target, Attempts, Delay) {
    Recurrance = 0
    if (Attempts = "") {
        Attempts = 1
    }
    while (Recurrance < Attempts) {
        Recurrance++
        Sleep Delay
        if (Target = "") {
            Run %A_ScriptDir%\Assets\Development\Hitlist.ahk
            Return
         } else {
            Run %A_ScriptDir%\Assets\Development\%Target%
            Return
        } ; Include the filetype extension.
    }
    Return
}