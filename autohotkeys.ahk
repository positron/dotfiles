; My AutoHotkey shortcuts

; Replace the old instance automatically when this script is launched
#SingleInstance force


; Ctrl-PgUp and PgDown adjust the volume since my keyboard doesn't have dedicated buttons anymore
^PgUp::Send {Volume_Up 1}
^PgDn::Send {Volume_Down 1}

; Win-PgUp toggles mute
#PgUp::Send {Volume_Mute}


; Win+S runs snipping tool
#s::
   If WinExist("Snipping Tool")
   {
      WinActivate, Snipping Tool
      WinWaitActive, Snipping Tool
      Send !n
      Send r
   }
   else
   {
      ; Just "SnippingTool.exe" works on 32-bit systems.
      Run, "C:\Windows\Sysnative\SnippingTool.exe"
      WinWait, Snipping Tool
      WinActivate, Snipping Tool
      Send !n
      Send r
   }
RETURN

; TODO: see if this works on my laptop
; https://github.com/PProvost/AutoHotKey/blob/master/DisableTouchPad.ahk
