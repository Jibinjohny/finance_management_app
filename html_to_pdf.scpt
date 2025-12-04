#!/usr/bin/osascript
# AppleScript to convert HTML to PDF using Safari

on run argv
    set htmlFile to item 1 of argv
    set pdfFile to item 2 of argv
    
    tell application "Safari"
        activate
        open POSIX file htmlFile
        delay 3
        
        tell application "System Events"
            keystroke "p" using command down
            delay 2
            keystroke "p" using {command down, shift down}
            delay 1
            
            keystroke "g" using {command down, shift down}
            delay 1
            keystroke pdfFile
            delay 1
            keystroke return
            delay 2
            keystroke return
        end tell
        
        delay 2
        close front window
    end tell
end run
