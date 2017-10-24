var acc;
var accessmode;
var rnk;
var acc_data = new Array();
var dd_data = new Array();
var OnAllValuts = false;
var codValutes;
var new_rights = false;
var url_dlg = "dialog.aspx?type=metatab&tail=''&role=wr_viewacc&tabname="; 
var url_dlg_mod = "dialog.aspx?type=metatab&role=wr_viewacc&tabname="; 
//Возвращает значение параметра из страки url
function getParamFromUrl(param,url)
{
 url = url.substring(url.indexOf('?')+1); 
 for(i = 0; i < url.split("&").length; i++)
 if(url.split("&")[i].split("=")[0] == param) return url.split("&")[i].split("=")[1]; 
 return "";
} 
//Диалоговое окно
function Dialog(message, type, height, width) {
    var style = "center:yes;edge:sunken;help:no;status:no;";
    if (height) style += "dialogHeight:" + height + "px;";
    else style += "dialogHeight:160px;";
    if (width) style += "dialogWidth:" + width + "px;";
    return window.showModalDialog("dialog.aspx?type=" + type + "&message=" + escape(message), "", style);
}
//Проверка при изменении активной страницы
function onChangeTab(obj)
{
  if(accessmode != 1) return;
  if(activeTab == "Tab2" && !new_rights){
  if(document.frames("Tab2").document.all.cbOthV.checked || document.frames("Tab2").document.all.cbOthD.checked || document.frames("Tab2").document.all.cbOthK.checked)
   if(confirm(LocalizedString('Message1'))) goPage(obj);
  }
}
//Выпадающие списки
function d_dlg(ddlist,control)
{
 var result = window.showModalDialog(dd_data[ddlist.id],"","dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
 if(result!=null){
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
  if(control!=null) {
    if(result[0].indexOf(" ") != -1)
      control.value = result[0].split(" ")[1];
    else control.value = result[0];
  }  
  if(ddlist.id == "ddPap")
     fnCheckPap();
  if(ddlist.id == "ddMetr" || ddlist.id == "ddBaseY" || ddlist.id == "ddFreq")
    SaveP(ddlist);
  else 
    SaveG(ddlist);
 } 
}
//
function makeArray(obj)
{
 if(obj == null) return null;
 var strobj = new Array(),i = 0;
 for(key in obj) {
   if(obj[key] == null) break;
   strobj[i] = key;
   strobj[i+1]= obj[key];
   i+=2;
 }
 return strobj;
}
//Сохранение состояния елемента
//General+Financial+Rights
function SaveG(obj)
{
 parent.edit_data.value.general.data[obj.id] = obj.value;
 if(parent.edit_data.value.general.edit == false) parent.edit_data.value.general.edit = true;
 if (obj.id == "tbNbs" && acc == 0) {
     parent.acc_obj.value[2].text = obj.value;
     parent.bTab3.style.visibility = 'visible';
     parent.window.frames[3].location.replace("acc_sp.aspx?acc=" + acc + "&accessmode=" + accessmode);

     parent.bTab4.style.visibility = 'visible';
     parent.window.frames[4].location.replace("acc_percent.aspx?acc=0&accessmode=" + accessmode + "&nbs=" + obj.value);
 }
}
//SpecParams
function SaveSP(id,value,rowId, code)
{
 parent.edit_data.value.sp.data[id] = value;
 if (parent.edit_data.value.sp.edit == false) parent.edit_data.value.sp.edit = true;
 //if (parent.localSP)
     parent.localSP[id] = { "v": value, "rid": rowId, "code": code };
}
//Percent
function SaveP(obj)
{
 parent.edit_data.value.percent.data[obj.id] = obj.value;
 if(parent.edit_data.value.percent.edit == false) parent.edit_data.value.percent.edit = true;
}
//Percent Table
function SavePT(id, ir, op, br, bdat, prev_bdat, _id)
{
 var tbl = parent.edit_data.value.percent.tbl;
 tbl[id] = new Array();
 tbl[id][0] = id;
 tbl[id][1] = ir;
 tbl[id][2] = op;
 tbl[id][3] = br;
 tbl[id][4] = bdat;
 tbl[id][5] = prev_bdat;
 tbl[id][6] = _id;
 if(parent.edit_data.value.percent.edittbl == false) parent.edit_data.value.percent.edittbl = true;
 if(parent.edit_data.value.percent.edit == false) parent.edit_data.value.percent.edit = true;
}
//Rates Table
function SaveR(id,tar,pr,smin,smax,bdat,edat,kvsmin,kvsmax)
{
 var tbl = parent.edit_data.value.rates.tbl;
 tbl[id] = new Array();
 tbl[id][0] = id;
 tbl[id][1] = tar;
 tbl[id][2] = pr;
 tbl[id][3] = smin;
 tbl[id][4] = smax;
 tbl[id][5] = bdat;
 tbl[id][6] = edat;
 tbl[id][7] = kvsmin;
 tbl[id][8] = kvsmax;
 if(parent.edit_data.value.rates.edit == false) parent.edit_data.value.rates.edit = true;
}
//Sob Table
function SaveS(id,fdat,txt)
{
 var tbl = parent.edit_data.value.sob.tbl;
 tbl[id] = new Array();
 tbl[id][0] = id;
 tbl[id][1] = fdat;
 tbl[id][2] = txt;
 if(parent.edit_data.value.sob.edit == false) parent.edit_data.value.sob.edit = true;
}
//---------------------------------------------------------------------
//Обработка ошибок от веб-сервиса
function getError(result, modal)
{
  if(result.error){
     if(window.dialogArguments || modal){
       window.showModalDialog("dialog.aspx?type=err","","dialogWidth:1000px;center:yes;edge:sunken;help:no;status:no;");
  } 
  else
     location.replace("dialog.aspx?type=err");
   return false;
 }
 return true;
}
//Возвращает дерево exeptions
function makeError(str)
{
 var result = ""; 
 var len = str.split("---").length - 1;
 var min = 1;
 if(len == 3) min = 0;
 for(i = 1; i < len/2; i++) 
 {
    result += i + str.split("---")[i] +"<BR>"+ str.split("---")[len-i-min]+"<BR>";
 }
 return result;
}
//Из копеек в гривны
function dig4(value,nDig)
{
 return Math.abs(Math.pow(10,2-nDig)*(value/100));
}
//Из гривны в коп.
function dig(value,nDig)
{
  return  value*Math.pow(10,nDig);
}
//Типа back
function goBack()
{
    if (parent.frames["header"]) parent.frames["header"].goBack();
    else window.close();
}