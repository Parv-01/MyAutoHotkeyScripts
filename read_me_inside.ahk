#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;-----------------
; Functionality 1: Pinning a Window
;-----------------
; This function uses Ctrl+Tab to pin or unpin the currently active window, making it stay on top of other windows.

^TAB::
    WinGetActiveTitle, Title
    Title := StrReplace(Title, " [Pinned]")
    ID := WinExist("A")
    WinGet, ExStyle, ExStyle, ahk_id %ID%
    If (ExStyle & 0x8) ; If window is already always on top
    {
        WinSet, AlwaysOnTop, Off, A
        WinSetTitle, , , %Title%
    }
    Else ; If window is not always on top
    {
        WinSet, AlwaysOnTop, On, A
        WinSetTitle, , , %Title% . " [Pinned]"
    }
return

;-----------------
; Functionality 2: VLC Media Player Controls
;-----------------
; These hotkeys are restricted to work only in VLC Media Player.
; They allow the user to control playback and volume using the mouse.

#IfWinActive ahk_exe vlc.exe ; Restricts the hotkeys to VLC Media Player

; Toggle play/pause with the left mouse button
~LButton:: 
    WinActivate, A ; Ensure VLC is the active window
    Send, {Space} ; Sends a "Space" keystroke to toggle play/pause
return

; Increase volume with the mouse wheel up
WheelUp::
    WinActivate, A
    Sleep, 50 ; Short delay to ensure the active window is set
    Send, {Volume_Up}
return

; Decrease volume with the mouse wheel down
WheelDown::
    WinActivate, A
    Sleep, 50
    Send, {Volume_Down}
return

#IfWinActive

;-----------------
; Functionality 3: Take Screenshot with Both Mouse Buttons
;-----------------
; This function captures a screenshot when both the left and right mouse buttons are pressed together.

~LButton & RButton::
~RButton & LButton::
{
    ; Check if both buttons are pressed
    if (GetKeyState("LButton", "P") and GetKeyState("RButton", "P"))
    {
        ; Capture the screenshot
        Send, {PrintScreen}
        
        ; Increase the time for selecting the area (adjust as needed)
        Sleep, 3000  ; Wait 3 seconds (3000 milliseconds) before dismissing the selection window
        
        ; Optional: Save the screenshot to a file
        ; Adjust the path and filename as needed
        ; FileAppend, %ClipboardAll%, %A_Desktop%\Screenshot_%A_Now%.png

        ; Notify user
        Tooltip, Screenshot taken!, 500, 500, 1
        Sleep, 1000
        Tooltip
    }
}
return

; Suggestions for robustness:
; 1. Add error handling and logging to track any issues.
; 2. Ensure the script does not conflict with other global hotkeys or applications.
; 3. Consider adding user-configurable settings for file paths, delays, and other parameters.
; 4. Use specific paths and filenames for saving screenshots to avoid overwriting or conflicts.
; 5. Use AHK's built-in ImageSearch functionality to provide visual confirmation of actions.
; 6. Ensure all hotkeys and their effects are documented for ease of use and maintenance.
; 7. Validate that the necessary permissions (like access to Clipboard) are available for the script to function properly.
; 8. Use `ClipWait` to ensure the clipboard data is ready before using it in the screenshot functionality.
