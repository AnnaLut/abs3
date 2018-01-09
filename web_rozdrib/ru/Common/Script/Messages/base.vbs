Function makeMsgBox(title,mess,icon,buts,defbut,mods)
   butVal = buts + (icon*16) + (defbut*256) + (mods*4096)
   makeMsgBox = MsgBox(mess,butVal,title)
End Function

Function makeInputBox(title,pr,def)
   makeInputBox = InputBox(pr,title,def)
End Function


