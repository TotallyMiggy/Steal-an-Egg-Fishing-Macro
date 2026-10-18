#Requires AutoHotkey v2.0
#SingleInstance Force
CoordMode "Pixel", "Screen"
CoordMode "Mouse", "Screen"

; ===== SHARED SETTINGS =====
HoldTime      := 1100     ; <-- put YOUR tuned value here
ClickDelay    := 40
LoopDelay     := 3500
PromptTimeout := 30000
GoneGrace     := 600
PromptColor   := 0xE53838
Variation     := 40

; ===== MONITOR PROFILES: [X1, Y1, X2, Y2] =====
Profiles := Map(
    "normal",   [1370, 945, 1495, 1020],
    "vertical", [-314, 1205, -238, 1242]
)

running := false
X1 := 0, Y1 := 0, X2 := 0, Y2 := 0

F6:: ToggleMacro("normal")      ; start/stop on normal monitor
F3:: ToggleMacro("vertical")    ; start/stop on vertical monitor
F7::ExitApp                     ; quit
F8:: TestDetect("normal")       ; test detection, normal
F10:: TestDetect("vertical")    ; test detection, vertical

F12:: {   ; shows mouse position and color (for calibration)
    MouseGetPos(&mx, &my)
    ToolTip("Mouse x=" mx "  y=" my "`nColor " PixelGetColor(mx, my))
    SetTimer(() => ToolTip(), -4000)
}

ToggleMacro(name) {
    global running, Profiles, X1, Y1, X2, Y2
    running := !running
    if running {
        box := Profiles[name]
        X1 := box[1], Y1 := box[2], X2 := box[3], Y2 := box[4]
        ToolTip("Macro ON (" name ")")
        SetTimer(Cycle, -10)
    } else {
        ToolTip("Macro OFF")
    }
    SetTimer(() => ToolTip(), -1500)
}

TestDetect(name) {
    global Profiles, X1, Y1, X2, Y2
    box := Profiles[name]
    X1 := box[1], Y1 := box[2], X2 := box[3], Y2 := box[4]
    ToolTip(name ": " (PromptVisible() ? "Prompt FOUND" : "Prompt NOT found"))
    SetTimer(() => ToolTip(), -1500)
}

PromptVisible() {
    return PixelSearch(&px, &py, X1, Y1, X2, Y2, PromptColor, Variation)
}

Cycle() {
    global running
    if !running
        return

    ; 1) Cast
    Click "Down"
    if !WaitMs(HoldTime) {
        Click "Up"
        return
    }
    Click "Up"

    ; 2) Wait for the prompt
    start := A_TickCount
    while running && !PromptVisible() {
        if A_TickCount - start > PromptTimeout
            break
        Sleep 30
    }
    if !running
        return

    ; 3) Spam click while the prompt is visible
    goneSince := 0
    while running {
        if PromptVisible() {
            goneSince := 0
            Click
            Sleep ClickDelay
        } else {
            if !goneSince
                goneSince := A_TickCount
            else if A_TickCount - goneSince > GoneGrace
                break
            Sleep 30
        }
    }

    ; 4) Pause and repeat
    if WaitMs(LoopDelay)
        SetTimer(Cycle, -10)
}

WaitMs(ms) {
    global running
    end := A_TickCount + ms
    while A_TickCount < end {
        if !running
            return false
        Sleep 20
    }
    return true
}