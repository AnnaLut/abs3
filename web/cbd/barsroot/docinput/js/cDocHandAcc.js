function chkAccount(n,form,elem)
{ 
  var x = elem.name.substring(elem.name.length-2,elem.name.length);
  var e1 = form["Kv"+x];
  var e2 = form["Nls"+x];
  var e3 = form["Mfo"+x];
  
  if ( e2.value == "" || e3.value == "" ) return;
  if ( e1.value == "" || e2.value == "" ) return;
  
  if(e2.value.indexOf('*') != -1 || e2.value.indexOf('%') != -1 )
	return;
  
  if(elem.name == e1.name && true==e1.readOnly) return;
  if(elem.name == e2.name && true==e2.readOnly) return;
  
  if ( e2.value != cDocVkrz(e3.value,e2.value)) 
  { alert(LocalizedString('Message1'));
    setFocus1(e2.name,form); return;
  }
  //EQ
  if (document.getElementById("__FLAGS").value.substr(14, 1) == "1")
      cDocHand(8, form);
  
  //Выбрать из справочника alien
  if(e3.value != form["__OURMFO"].value)
  {
      n=6;
  }
  if ( cDocHand(n,form) ) return;
  if (elem.name == e1.name)
      if(false==e2.readOnly) setFocus1(e2.name,form);
      else setFocus1(e1.name,form);
  else
      if(false==e1.readOnly) setFocus1(e1.name,form);
      else setFocus1(e2.name,form);
}

function setFocus1(ename,form)
{ var elem = form[ename];
      elem.focus();
      elem.select();
}
function cDocVkrz(mfo,nls0)
{ 
   var nls=nls0.substring(0,4)+'0'+nls0.substring(5, nls0.length );
   var m1 = '137130'         ;
   var m2 = '37137137137137' ;
   var  j = 0                ;
   for ( var i = 0; i < mfo.length; i++ )
       { j =j +  parseInt(mfo.substring(i,i+1)) * parseInt(m1.substring(i,i+1)); }

   for ( var i = 0; i < nls.length; i++ )
       { j =j +  parseInt(nls.substring(i,i+1)) * parseInt(m2.substring(i,i+1)); }
         
   return nls.substring(0,4) +
          (((j + nls.length ) * 7) % 10 ) +
          nls.substring(5, nls.length );
}

function chkAccount_link(form,ctrl,ctrl_nms)
{ 
  var e1 = form["Kv_A"];
  var e2 = event.srcElement;
  var e3 = form["Mfo_A"];
  
  if ( e2.value == "" || e3.value == "" ) return;
  if ( e1.value == "" || e2.value == "" ) return;
  
  if(e2.value.indexOf('*') != -1 || e2.value.indexOf('%') != -1 )
	return;
  
  if(ctrl.name == e1.name && true==e1.readOnly) return;
  if(ctrl.name == e2.name && true==e2.readOnly) return;
  
  if ( e2.value != cDocVkrz(e3.value,e2.value)) 
  { alert(LocalizedString('Message1'));
    setFocus1(e2.name,form); return;
  }
  
  if ( cDocHand_link(form,0,ctrl,ctrl_nms) ) return;  
}