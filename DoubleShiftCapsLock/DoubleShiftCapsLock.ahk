; Define the time interval (in milliseconds) for detecting a double tap.
DoubleTapTime := 300

; Track the state of the Shift key taps
ShiftTapCount := 0
LastShiftTime := 0

; Detect Shift key release
~Shift Up::
    ; Get the current timestamp
    CurrentTime := A_TickCount
    
    ; Check if this release is within the double-tap time frame
    if (CurrentTime - LastShiftTime < DoubleTapTime) {
        ShiftTapCount++
        if (ShiftTapCount >= 2) {
            ; Toggle Caps Lock on double-tap
            SetCapsLockState, % (GetKeyState("CapsLock", "T") ? "Off" : "On")
            ShiftTapCount := 0 ; Reset the tap count
        }
    } else {
        ; Reset if taps are too far apart
        ShiftTapCount := 1
    }
    
    ; Update the last release time
    LastShiftTime := CurrentTime
    
    return
