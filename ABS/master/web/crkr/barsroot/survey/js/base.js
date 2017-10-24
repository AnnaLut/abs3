IE4 = document.all;

/// BarsAlert(title,message,icon,modality)
/// BarsAlert("DHTML Lab","No confusing captions",4,0)
function BarsAlert(title,mess,icon,mods) {
   (IE4) ? makeMsgBox(title,mess,icon,0,0,mods) : alert(mess);
}

/// BarsConfirm(title,message,icon,default button,modality)
/// BarsConfirm("DHTML Lab Confirmation Request","Are you confused yet?",1,1,0)
/// icon: 0 - no icon, else - question icon
/// default button: 0 - first; 1 - second
function BarsConfirm(title,mess,icon,defbut,mods) {
   if (IE4) {
      icon = (icon==0) ? 0 : 2;
      defbut = (defbut==0) ? 0 : 1;
      retVal = makeMsgBox(title,mess,icon,4,defbut,mods);
      retVal = (retVal==6);
   }
   else {
      retVal = confirm(mess);
   }
   return retVal;
}

/// BarsPrompt(title,message,default response)
/// BarsPrompt("DHTML Lab User Input Request","Enter your name, please:","Ishmael")
function BarsPrompt(title,mess,def) {
   retVal = (IE4) ? makeInputBox(title,mess,def) : prompt(mess,def);
   return retVal;
}
/// BarsIEBox(title,message,icon,button group,default button,modality)
/// BarsIEBox("DHTML Lab Explorer Dialog","All options enabled",1,2,2,1)
function BarsIEBox(title,mess,icon,buts,defbut,mods) {
   retVal = (IE4) ? makeMsgBox(title,mess,icon,buts,defbut,mods) : null;
   return retVal;
}
