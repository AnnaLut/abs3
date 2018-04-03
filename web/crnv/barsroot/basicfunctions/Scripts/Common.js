//Переменние
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
  return window.showModalDialog("dialog.aspx?type="+type+"&message="+escape(message),"","dialogHeight:160px;center:yes;edge:sunken;help:no;status:no;");
}
//---------------------------------------------------------------------
//Обработка ошибок от веб-сервиса
function getError(result,type)
{
  if(result.error)
  {
     if(window.dialogArguments || type){
       window.showModalDialog("dialog.aspx?type=err","","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
	 } 
	 else
        location.replace("dialog.aspx?type=err");
   return false;
 }
 return true;
}
//---------------------------------------------------------------------
//Типа back
function goBack()
{
	if(parent.frames["header"]) parent.frames["header"].goBack();
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

