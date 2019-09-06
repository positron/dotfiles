; My AutoHotkey shortcuts
; To open the startup folder for all users, hit Win-R and type shell:common startup

; Replace the old instance automatically when this script is launched
#SingleInstance force

; Map Caps Lock to Escape
Capslock::Esc

; Ctrl-PgUp and PgDown adjust the volume since my keyboard doesn't have dedicated buttons anymore
^PgUp::Send {Volume_Up 1}
^PgDn::Send {Volume_Down 1}

; Win-PgUp toggles mute
#PgUp::Send {Volume_Mute}
