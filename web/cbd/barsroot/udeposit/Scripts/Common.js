var dd_data = new Array();
var url_dlg = "dialog.aspx?type=metatab&tail=''&role=wr_deposit_u&tabname="; 
var url_dlg_mod = "dialog.aspx?type=metatab&role=wr_deposit_u&tabname=";
//---------------------------------------------------------------------
function getParamFromUrl(param,url)
{
 url = url.substring(url.indexOf('?')+1); 
 for(i = 0; i < url.split("&").length; i++)
 if(url.split("&")[i].split("=")[0] == param) return url.split("&")[i].split("=")[1]; 
 return "";
}
//---------------------------------------------------------------------
//Dialog
function Dialog(message,type)
{
  return window.showModalDialog("dialog.aspx?type="+type+"&message="+escape(message),"","dialogHeight:260px;center:yes;edge:sunken;help:no;status:no;");
}
//---------------------------------------------------------------------
//Обработка ошибок от веб-сервиса
function getError(result)
{
  if(result.error) {
       if(window.dialogArguments){
		//location.href = "dialog.aspx?type=err&page=DptUService.asmx";
		window.showModalDialog("dialog.aspx?type=err","","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
	  }	
	  else
		location.replace("dialog.aspx?type=err");
	  return false;
 }
 return true;
}
//---------------------------------------------------------------------
function HideImg(img)
{
  img.disabled = true;
  img.style.filter='progid:DXImageTransform.Microsoft.Alpha( style=0,opacity=25)progid:DXImageTransform.Microsoft.BasicImage(grayScale=1)';
}
//---------------------------------------------------------------------
function UnHideImg(img)
{
  img.disabled = false;
  img.style.filter = '';
}
//---------------------------------------------------------------------
// Rad-контрол для дат
function IniDateTimeControl(name)
{
 window[name] = new RadDateInput(name, "Windows");			                    
 //window[name].AllowEmpty = true;
 window[name].PromptChar=" ";
 window[name].DisplayPromptChar="_";
 window[name].SetMask(rdmskr(1, 31, false, true),rdmskl('.'),rdmskr(1,12, false, true),rdmskl('.'),rdmskr(1, 2999, false, true));		
 window[name].RangeValidation=true;
 window[name].SetMinDate('01/01/1980 00:00:00');
 window[name].SetMaxDate('31/12/2099 00:00:00');
 window[name].SetValue(document.getElementById(name+"_TextBox").value);
 window[name].Initialize();
}
//---------------------------------------------------------------------
//Выпадающие списки
function cmb_dlg(ddlist,control)
{
 var result = window.showModalDialog(dd_data[ddlist.id],window,"dialogHeight:700px;dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
 if(result != null)
 {
  if(ddlist.options.length == 0)
  {
    var oOption = document.createElement("OPTION");
    ddlist.options.add(oOption);
    oOption.innerText = result[1];
    oOption.value = result[0];
  }
  else
  {
	ddlist.options[0].value = result[0];
	ddlist.options[0].text = result[1];
  }
  if(control!=null) {
    control.value = result[0];
  }
  if(ddlist.id == "ddVidD")		SetVal();
 } 
}
//**********************************************************************//
//Проверка счета на контрольный розряд
function checkControlRank(mfo,nls0)
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
//Go back
function goBack()
{
  if(parent.frames["header"]) parent.frames["header"].document.all.imgBack.fireEvent("onclick");
}
//
function gE(id)
{
    return document.getElementById(id);
}