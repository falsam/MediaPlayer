Enumeration window
  #mainForm
EndEnumeration

Enumeration gadget
  #viewer
  #stream
EndEnumeration

Declare loadStream()
Declare selectStream()

Global stream.s, HTML.s, script.s

OpenWindow(#mainForm, 88, 244, 800, 620, "Web Video Audio", #PB_Window_SystemMenu | #PB_Window_ScreenCentered) 
WebGadget (#viewer, 0, 0, 800, 600, "")
ComboBoxGadget(#stream, 0, 600, 800, 23)

BindGadgetEvent(#stream, @selectStream(), #PB_EventType_Change)

;load script
If ReadFile(0, "script.js")
  While Eof(0) = 0
    script + ReadString(0)
  Wend
EndIf

loadStream()
SetGadgetState(#stream, 0)
selectStream()

Repeat : Until WaitWindowEvent() = #PB_Event_CloseWindow

Procedure loadStream()
  Restore stream
  
  For i = 0 To 5
    Read.s title$
    Read.s stream$
    AddGadgetItem(#stream, -1, title$)
    SetGadgetItemData(#stream, i, i)
  Next
EndProcedure

Procedure selectStream()
  Protected index = GetGadgetItemData(#stream, GetGadgetState(#stream)), n
  
  Restore stream
  For n = 0 To index
    Read.s title$
    Read.s stream$
  Next
  
  stream = stream$
  
  ;HTML
  HTML = "<meta http-equiv='X-UA-Compatible' content='IE=edge' />" 
  HTML + "<body bgcolor=black scroll=no>"
  HTML + "<video controls='true' autoplay preload>"
  HTML + "      <source src='" + stream + "' type='video/mp4'>"
  HTML + "</video>"
  
  ;Script
  HTML + "<script>" + script + "</script>"
  
  Delay(500)
  
  SetGadgetItemText(#viewer, #PB_Web_HtmlCode , HTML)
EndProcedure

DataSection
  stream:
  ;Audio
  Data.s "Deep link NYC", "http://176.9.219.133:9998/stream"
  Data.s "DI Radio", "http://5.39.71.159:8110/stream"
  Data.s "Club hits", "http://178.32.62.172:9371/stream"
  Data.s "Creek Valley Radio", "http://www.youtube.com/demo/google_main.mp4"
  
  ;Vidéo
  Data.s "Jan Hammer - Crockett's Theme (live by Kebu @ Dynamo)", "https://www.youtube.com/watch?v=TRCQmNMOqUY"
  Data.s "Scorpions - Tease Me Please Me", "https://www.youtube.com/watch?v=wENdZneWDYs"
EndDataSection
; IDE Options = PureBasic 5.42 LTS (Windows - x86)
; CursorPosition = 21
; Folding = -
; EnableUnicode
; EnableXP