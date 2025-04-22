#Requires AutoHotkey v2.0
SendMode("Input")

isWaiting := false
timerDuration := 5000 ; 5 seconds

Alt & 3::
{
    global isWaiting, timerDuration
    if (!isWaiting) {
        isWaiting := true
        SetTimer(ResetState, -timerDuration)
        ToolTip("Waiting for key press...")
    }
    return
}

; Register hotkeys for a-z, A-Z, and 0-9
for key in StrSplit("abcdefghijklmnopqrstuvwxyz0123456789") {
    Hotkey("~*" key, KeyHandler)
}

for key in StrSplit("ABCDEFGHIJKLMNOPQRSTUVWXYZ") {
    Hotkey("~*" key, KeyHandler)
}

KeyHandler(ThisHotkey) {
    global isWaiting
    if (isWaiting) {
        isWaiting := false
        SetTimer(ResetState, 0)
        ToolTip()

        key := SubStr(ThisHotkey, 3) ; remove "~*" prefix
        Send("{F3 down}" key "{F3 up}") ; press F3 + key simultaneously
    }
}

ResetState() {
    global isWaiting
    isWaiting := false
    ToolTip()
}