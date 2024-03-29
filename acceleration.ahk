#NoEnv
#SingleInstance, Force
#MaxHotkeysPerInterval 2000
Process, Priority, , H
CoordMode, mouse, screen
SendMode Input

SetWorkingDir %A_ScriptDir%

IniFile := A_ScriptDir . "\config.ini"

/*  The adaptation and refactoring of this code was done by: (2022) MATTHEW PIETERSE
 *  The original messy code can be found here: https://github.com/TaranVH/2nd-keyboard
 */

; ----------------------------------------------------------------------------------------------------

IniRead, scrollGUI, % IniFile, Settings, ScrollGUI
IniRead, scrollBoost, % IniFile, Settings, ScrollBoost
IniRead, scrollLimit, % IniFile, Settings, ScrollLimit
IniRead, scrollTimeout, % IniFile, Settings, ScrollTimeout
IniRead, scrollTooltip, % IniFile, Settings, ScrollTooltip

; ----------------------------------------------------------------------------------------------------

size := 200

Menu, Tray, Icon, shell32.dll, 44

Gui, -Caption +ToolWindow +AlwaysOnTop +LastFound
Gui, Color, 008833
GuiHwnd := WinExist()
DetectHiddenWindows, On
WinSet, Region, % "0-0 W" Size " H" Size, ahk_id %GuiHwnd%
WinSet, ExStyle, +0x20, ahk_id %GuiHwnd%
WinSet, TransColor, 008833 100
Gui, Show, w%Size% h%Size%
Gui, Font, s32, lucida console
Gui, Add, Text, vMyText cLime,

; ----------------------------------------------------------------------------------------------------

scrollDistance := 0
scrollMaximum  := 1

if (scrollGUI) {
    SetTimer, Looper, -2
}

Scroll:
    t := A_TimeSincePriorHotkey
    if (A_PriorHotkey = A_ThisHotkey && t < scrollTimeout) {
        scrollDistance++
        scrollCurrent := (t < 80 && t > 1) ? (250.0 / t) - 1 : 1
        if (scrollBoost > 1 && scrollDistance > scrollBoost) {
            if (scrollCurrent > scrollMaximum) {
                scrollMaximum := scrollCurrent
            } else {
                scrollCurrent := scrollMaximum
            }
            scrollCurrent *= scrollDistance / scrollBoost
        }
        scrollCurrent := (scrollCurrent > 1) ? ((scrollCurrent > scrollLimit) ? scrollLimit : Floor(scrollCurrent)) : 1
        if (scrollCurrent > 1 && %scrollTooltip%) {
            QuickTooltip(scrollCurrent, scrollTimeout)
        }
        MouseClick, %A_ThisHotkey%,,, scrollCurrent
        Return
    } else {
        scrollDistance := 0
        scrollMaximum := 1
        MouseClick %A_ThisHotkey%
        Return
    } 

EndGUI:
    if (mouseWheelUp = -1) {
        mouseWheelUp = 0
        Gui, Hide
    }
    if (mouseWheelDown = -1) {
        mouseWheelDown = 0
        Gui, Hide
    }
    Return

Looper:
    MouseGetPos, realposX, realposY
    posX := realposX - Size / 3.4
    posY := realposY - Size / 4.1 + 0
    if (toggleFakeCursor = 1) {
        ToolTip, ^
    } else if (toggleFakeCursor = 0) {
        ToolTip, 
    }
    if (mouseButtonL = 1 && mouseButtonR = 1) {
        GuiControl,, MyText, ()
        posX := posX - 10
        Gui, Show, x%posX% y%posY% NA
        SetTimer, Looper, -20
        Return
    }
    if (mouseButtonL = 1) {
        GuiControl,, MyText, (
        posXX := posX - 10
        Gui, Show, x%posXX% y%posY% NA
    }
    if (mouseButtonL = -1) {
        mouseButtonL = 0
        Gui, Hide
    }
    if (mouseButtonR = 1) {
        posX := posX + 20
        GuiControl,, MyText, )
        Gui, Show, x%posX% y%posY% NA
    }
    if (mouseButtonR = -1) {
        mouseButtonR = 0
        Gui, Hide
    }
    if (mouseWheelUp = 1) {
        posYu := posY - 10
        posXu := posX + 8
        GuiControl,, MyText, ^
        Gui, Show, x%posXu% y%posYu% NA
        SetTimer, EndGUI, -200
        mouseWheelUp = -1
    }
    if (mouseWheelDown = 1) {
        posYd := posY + 32
        posXd := posX + 8
        Gui, Font, s20 cBlue, Verdana
        GuiControl,, mytext, v
        Gui, Show, x%posXd% y%posYd% NA
        SetTimer, EndGUI, -200
        mouseWheelDown = -1
    }
    SetTimer, Looper, -1
    Return

QuickTooltip(text, delay) {
    ToolTip, %text%
    SetTimer TooltipOff, %delay%
    Return
    TooltipOff:
        SetTimer TooltipOff, off
        ToolTip, 
        Return
}

; ----------------------------------------------------------------------------------------------------

#Lbutton::
    if (toggleFakeCursor = 1) {
        toggleFakeCursor = 0
        Return
    } else {
        toggleFakeCursor = 1
        Sleep 2
        ToolTip, 
        Return
    }

~*$LButton::
    mouseButtonL = 1
    Return

~*$LButton up::
    mouseButtonL = -1
    Return

~*$RButton::
    mouseButtonR = 1
    Return

~*$RButton up::
    mouseButtonR = -1
    Return

 ~^WheelUp::
 ~+WheelUp::
 ~!WheelUp::
~^+WheelUp::
    mouseWheelUp = 1
    Return

 ~^WheelDown::
 ~+WheelDown::
 ~!WheelDown::
~^+WheelDown::
    mouseWheelDown = 1
    Return

WheelUp::
    Gui, Hide
    mouseWheelUp = 1
    Goto Scroll
    Return

WheelDown::
    Gui, Hide
    mouseWheelDown = 1
    Goto Scroll
    Return

; ----------------------------------------------------------------------------------------------------