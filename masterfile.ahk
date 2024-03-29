#NoEnv
#SingleInstance, Force

SetWorkingDir %A_ScriptDir%

IniFile := A_ScriptDir . "\config.ini"

/*  Created: Matthew Pieterse
 *  Version: Pre-release
 */

; ----------------------------------------------------------------------------------------------------

#Include %A_ScriptDir%\Functions\func-Tasker.ahk

Run %A_ScriptDir%\acceleration.ahk

; ----------------------------------------------------------------------------------------------------

KeySwap(false)          ; Read documentation for more information on this function and its use.
KeyDisable(x, x, x)     ; Read documentation for more information on this function and its use.

IniRead, TrayIcon, % IniFile, Settings, TrayIcon

if !(%TrayIcon%) { ; Percentage symbols are required for this statement to work.
	Menu, Tray, NoIcon
}

; ----------------------------------------------------------------------------------------------------

 #F1::Return
 #F2::Return
 #F3::Return
 #F4::Return
 #F5::Return
 #F6::Return
 #F7::Return
 #F8::Return
 #F9::Return
#F10::Return
#F11::Return
#F12::Return
#F13::Return
#F14::Return
#F15::Return
#F16::Return
#F17::Return
#F18::Return
#F19::Return
#F20::Return
#F21::Return
#F22::Return
#F23::Return
#F24::Return

; ----------------------------------------------------------------------------------------------------

#1::Return
#2::Return
#3::Return
#4::Return
#5::Return
#6::Return
#7::Return
#8::Return
#9::Return
#0::Return

; ----------------------------------------------------------------------------------------------------

#a::
    Return
    
#b::
    Return
    
#c::
    WindowCenter(true)
    Return
    
#d::
    Return
    
#e::
    Return
    
#f::
    Return
    
#g::
    Return
    
#h::
    Return
    
#i::
    Return
    
#j::
    Return
    
#k::
    Return
    
#l::
    Return
    
#m::
    Return
    
#n::
    Return
    
#o::
    Return
    
#p::
    Return
    
#q::
    Return
    
#r::
    Return
    
#s::
    Return
    
#t::
    Return
    
#u::
    Return
    
#v::
    Return
    
#w::
    Return
    
#x::
    Return
    
#y::
    Return
    
#z::
    Return
    
#Esc::
; Toggle between desktop and windows.
    ComObjCreate("Shell.Application").ToggleDesktop()
    Return
    
#End::
; Reload the current script at this location.
    Reload
    Return

#PgUp::
; Change the display resolution to (1920 x 1080).
    Resolution(1920, 1080)
    Return

#PgDn::
; Change the display resolution to (1600 x 900).
    Resolution(1600, 900)
    Return

#NumpadAdd::
    Brightness(currentBrightness += 10)
    Return

#NumpadSub::
    Brightness(currentBrightness -= 10)
    Return

#NumpadMult::
    Brightness(currentBrightness := 50)
    Return

#Delete::
; Clear the system recycle bin.
    FileRecycleEmpty 
    Return
    
; ----------------------------------------------------------------------------------------------------