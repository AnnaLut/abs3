//Переменние
var rnk;
var type;
var nd;
var dd_data = new Array();
var url_dlg = "dialog.aspx?type=mnltab_tail&message="; 
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
function getError(result)
{
  if(result.error){
     if(window.dialogArguments){
       window.showModalDialog("dialog.aspx?type=err","","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
  } 
  else
     location.replace("dialog.aspx?type=err");
   return false;
 }
 return true;
}
//---------------------------------------------------------------------
//Установка стиля кнопок меню
function setStyleButton(bt,style)
{
 if(style == null) return;
 bt.style.borderTopStyle = style;
 bt.style.borderRightStyle = style;
 bt.style.borderLeftStyle = style;
 bt.style.borderBottomStyle = style;
}
//Выпадающие списки
function d_dlg(ddlist)
{
 var result = window.showModalDialog(dd_data[ddlist.id],"","dialogWidth:450px;center:yes;edge:sunken;help:no;status:no;");
 if(result != null){
  if(ddlist.options.length == 0)
  {
   var oOption = document.createElement("OPTION");
   ddlist.options.add(oOption);
   oOption.innerText = result[1];
   oOption.value = result[0];
  }
  else{
	ddlist.options[0].value = result[0];
	ddlist.options[0].text = result[1];
  }
  if(ddlist.id=="cmb1")
    fnCmb1();
 }  
}
//Типа back
function goBack()
{
    if (parent.frames["header"]) parent.frames["header"].document.all.imgBack.fireEvent("onclick");
    else window.close();
}